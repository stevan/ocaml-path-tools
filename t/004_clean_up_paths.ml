#!/usr/local/bin/ocamlrun /usr/local/bin/ocaml

#use "topfind";;
#require "testSimple";;

#load "pathTools.cma";;

open TestSimple;;
open PathTools;;

let test_clean_path got = 
    (path_to_string (clean_up_path (path_from_string got)));;

plan 15;;

(is (test_clean_path "/foo/././///foo.txt")    "/foo/foo.txt" "... this worked");;
(is (test_clean_path "///foo/././/.//foo.txt") "/foo/foo.txt" "... this worked");;
(is (test_clean_path ".//./././/././///./////././/.//foo.txt") "foo.txt" "... this worked");;

(* 
borrowed from the File::Spec test suite here:
http://svn.pugscode.org/pugs/ext/File-Spec/p5_t/11_unix_test_p5.t
*)

(is (test_clean_path "path///to//a///////dir/")    "path/to/a/dir/" "... this worked");;
(is (test_clean_path "path/./to/././a/./././dir/") "path/to/a/dir/" "... this worked");;
(is (test_clean_path "./path/to/a/dir/")           "path/to/a/dir/" "... this worked");;
(is (test_clean_path "././path/to/a/dir/")         "path/to/a/dir/" "... this worked");;
(is (test_clean_path "/../path/to/a/dir/")         "path/to/a/dir/" "... this worked");;
(is (test_clean_path "/../../path/to/a/dir/")      "path/to/a/dir/" "... this worked");;

(is (test_clean_path "xx////xx")  "xx/xx" "... this worked");;
(is (test_clean_path "xx/././xx") "xx/xx" "... this worked");;
(is (test_clean_path "./xx")      "xx"    "... this worked");;
(is (test_clean_path "/../xx")    "xx"    "... this worked");;
(is (test_clean_path "/../../xx") "xx"    "... this worked");;

(is (test_clean_path "/../../../../../..////../../xx") "xx" "... this worked");;
