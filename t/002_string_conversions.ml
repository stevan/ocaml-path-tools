#!/usr/local/bin/ocamlrun /usr/local/bin/ocaml

#use "topfind";;
#require "testSimple";;

#load "pathTools.cma";;

open TestSimple;;
open PathTools;;

plan 25;;

(* path from string *) 

(is (path_from_string "")      (EndPoint)                   "... these are equal");;
(is (path_from_string "/")     (Root(EndPoint))             "... these are equal");;    
(is (path_from_string "/foo")  (Root(File "foo"))           "... these are equal");;  
(is (path_from_string "/foo/") (Root(Dir("foo", EndPoint))) "... these are equal");;
(is (path_from_string ".")     (CurrDir(EndPoint))          "... these are equal");;
(is (path_from_string "./")    (CurrDir(EndPoint))          "... these are equal");;       
(is (path_from_string "..")    (UpDir(EndPoint))            "... these are equal");; 
(is (path_from_string "../")   (UpDir(EndPoint))            "... these are equal");;                    

(is (path_from_string "//")     (Root(Dir("", EndPoint)))             "... these are equal");;  
(is (path_from_string "//..")   (Root(Dir("", (UpDir(EndPoint)))))    "... these are equal");;
(is (path_from_string "//../")  (Root(Dir("", (UpDir(EndPoint)))))    "... these are equal");;      
(is (path_from_string "/../.")  (Root(UpDir(CurrDir(EndPoint))))      "... these are equal");;      
(is (path_from_string "/.././") (Root(UpDir(CurrDir(EndPoint))))      "... these are equal");;      
(is (path_from_string "././.")  (CurrDir(CurrDir(CurrDir(EndPoint)))) "... these are equal");;    
(is (path_from_string "./././") (CurrDir(CurrDir(CurrDir(EndPoint)))) "... these are equal");;    
 
(* path to string *) 
 
(is (path_to_string (EndPoint))                   ""      "... these are equal");;
(is (path_to_string (Root(EndPoint)))             "/"     "... these are equal");;    
(is (path_to_string (Root(File "foo")))           "/foo"  "... these are equal");;  
(is (path_to_string (Root(Dir("foo", EndPoint)))) "/foo/" "... these are equal");;
(is (path_to_string (CurrDir(EndPoint)))          "./"    "... these are equal");;        
(is (path_to_string (UpDir(EndPoint)))            "../"   "... these are equal");;                    

(is (path_to_string (Root(Dir("", EndPoint))))             "//"     "... these are equal");;  
(is (path_to_string (Root(Dir("", (UpDir(EndPoint))))))    "//../"  "... these are equal");;      
(is (path_to_string (Root(UpDir(CurrDir(EndPoint)))))      "/.././" "... these are equal");;      
(is (path_to_string (CurrDir(CurrDir(CurrDir(EndPoint))))) "./././" "... these are equal");; 

