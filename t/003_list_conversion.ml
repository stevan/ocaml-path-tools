#!/usr/local/bin/ocamlrun /usr/local/bin/ocaml

#use "topfind";;
#require "testSimple";;

#load "pathTools.cma";;

open TestSimple;;
open PathTools;;

plan 20;;

(* path from list *) 

(is (path_from_list [])            (EndPoint)                   "... these are equal");;
(is (path_from_list [""])          (Root(EndPoint))             "... these are equal");;  
(is (path_from_list ["";"foo"])    (Root(File "foo"))           "... these are equal");;  
(is (path_from_list ["";"foo";""]) (Root(Dir("foo", EndPoint))) "... these are equal");;
(is (path_from_list ["."])         (CurrDir(EndPoint))          "... these are equal");;
(is (path_from_list [".."])        (UpDir(EndPoint))            "... these are equal");; 

(is (path_from_list ["";"";""])    (Root(Dir("", EndPoint)))             "... these are equal");;  
(is (path_from_list ["";"";".."])  (Root(Dir("", (UpDir(EndPoint)))))    "... these are equal");;      
(is (path_from_list ["";"..";"."]) (Root(UpDir(CurrDir(EndPoint))))      "... these are equal");;            
(is (path_from_list [".";".";"."]) (CurrDir(CurrDir(CurrDir(EndPoint)))) "... these are equal");;    

(* path to list *)

(is (path_to_list (EndPoint))                   []            "... these are equal");;
(is (path_to_list (Root(EndPoint)))             [""]          "... these are equal");;  
(is (path_to_list (Root(File "foo")))           ["";"foo"]    "... these are equal");;  
(is (path_to_list (Root(Dir("foo", EndPoint)))) ["";"foo";""] "... these are equal");;
(is (path_to_list (CurrDir(EndPoint)))          ["."]         "... these are equal");;
(is (path_to_list (UpDir(EndPoint)))            [".."]        "... these are equal");; 

(is (path_to_list (Root(Dir("", EndPoint))))             ["";"";""]    "... these are equal");;  
(is (path_to_list (Root(Dir("", (UpDir(EndPoint))))))    ["";"";".."]  "... these are equal");;      
(is (path_to_list (Root(UpDir(CurrDir(EndPoint)))))      ["";"..";"."] "... these are equal");;            
(is (path_to_list (CurrDir(CurrDir(CurrDir(EndPoint))))) [".";".";"."] "... these are equal");;

