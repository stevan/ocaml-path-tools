
type t = EndPoint              (* marker for directory paths *)
       | File    of string     (* x  *)
       | Dir     of string * t (* x/ *)
       | UpDir   of t          (* .. *)
       | CurrDir of t          (* .  *)
       | Root    of t          (* /  *)

(* string constants *)

let empty          = ""
let updir          = ".."
let currdir        = "."
let path_seperator = "/"

(* predicates *)

let rec is_dir = function
    (* if it is directory type and ends with an EndPoint *)
    | Dir(_, EndPoint)        
    | UpDir(EndPoint)   
    | CurrDir(EndPoint) 
    | Root(EndPoint)    -> true 
    (* if it is an EndPoint, and got past the above guards, 
       then it is false (probably a single EndPoint) *)       
    | EndPoint     
    (* if it is a file, then it is not a directory *)
    | File(_)           -> false    
    (* otherwise, keep recursing down *)
    | Dir(_, xs)        
    | UpDir(xs)         
    | CurrDir(xs)       
    | Root(xs)          -> is_dir(xs)                   

let rec is_file = function
    (* if we find a file, we are good *)
    | File(_)     -> true
    (* if we reach an EndPoint, it's a directory *)
    | EndPoint    -> false    
    (* otherwise, keep recursing down *)
    | Dir(_, xs)  
    | UpDir(xs)   
    | CurrDir(xs) 
    | Root(xs)    -> is_file(xs)

let is_absolute = function
    | Root(_) -> true
    | _       -> false

(* construction & conversion *)

let rec path_to_list = function
    | EndPoint         -> []
    | File(x)          -> x::[]        
    | UpDir(xs)        -> updir::(path_to_list xs)
    | CurrDir(xs)      -> currdir::(path_to_list xs)        
    | Dir(x, EndPoint) -> x::empty::[]      
    | Dir(x, xs)       -> x::(path_to_list xs)
    | Root(xs)         -> empty::(path_to_list xs)        

let path_from_list path =
    let rec build_path = function
        | []    -> EndPoint      
        | x::[] when x = empty   
                -> EndPoint                  
        | x::xs when x = currdir 
                -> CurrDir(build_path(xs)) 
        | x::xs when x = updir   
                -> UpDir(build_path(xs))                       
        | x::[] -> File(x) 
        | x::xs -> Dir(x, build_path(xs))
    in
    (* the root can only ever be the first element *)
    match path with 
        | []    -> EndPoint
        | x::xs when x = empty 
                -> Root(build_path(xs)) 
        | _     -> build_path(path)         

let rec path_to_string = function
    | EndPoint    -> empty
    | File(x)     -> x     
    | CurrDir(xs) -> (currdir ^ path_seperator ^ (path_to_string xs))  
    | UpDir(xs)   -> (updir ^ path_seperator ^ (path_to_string xs))       
    | Dir(x, xs)  -> (x ^ path_seperator ^ (path_to_string xs))
    | Root(xs)    -> (path_seperator ^ (path_to_string xs))            

let path_from_string = function
    | path when path = empty   
           -> EndPoint
    | path when path = path_seperator  
           -> Root(EndPoint)            
    | path -> 
        (path_from_list (Str.split_delim (Str.regexp_string path_seperator) path))

(* utilities *)

let rec clean_up_path = function
    | EndPoint       -> EndPoint
    | File(x)        -> File(x)
    | Dir(x, xs) when x = empty    
                     -> (clean_up_path xs)
    | Dir(x, xs)     -> Dir(x, (clean_up_path xs))
    | UpDir(x)       -> UpDir((clean_up_path x))
    | CurrDir(x)     -> (clean_up_path x)
    (* /../foo is not /foo, but foo *)
    | Root(UpDir(x)) -> let rec prune_updir path =
                            match path with 
                                | UpDir(x) -> prune_updir(x)
                                | _        -> path
                        in (prune_updir (clean_up_path x))
    | Root(x)        -> Root(clean_up_path x)


