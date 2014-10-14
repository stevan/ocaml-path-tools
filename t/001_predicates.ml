#!/usr/local/bin/ocamlrun /usr/local/bin/ocaml

#use "topfind";;
#require "testSimple";;

#load "pathTools.cma";;

open TestSimple;;
open PathTools;;

plan 42;;

(* is root predicate *)

(ok (is_absolute(Root(EndPoint))) "... this passed");;

(ok (not (is_absolute(EndPoint))) "... this passed");;
(ok (not (is_absolute(File("foo")))) "... this passed");;
(ok (not (is_absolute(Dir("foo", EndPoint)))) "... this passed");;
(ok (not (is_absolute(UpDir(EndPoint)))) "... this passed");;
(ok (not (is_absolute(CurrDir(EndPoint)))) "... this passed");;

(* is dir predicate *)

(ok (is_dir(Root(EndPoint))) "... this passed");;
(ok (is_dir(Dir("foo", EndPoint))) "... this passed");;
(ok (is_dir(UpDir(EndPoint))) "... this passed");;
(ok (is_dir(CurrDir(EndPoint))) "... this passed");;

(ok (not (is_dir(EndPoint))) "... this passed");;
(ok (not (is_dir(File("foo")))) "... this passed");;

(* is dir predicate on deeper paths *)

(ok (is_dir(Root(CurrDir(EndPoint)))) "... this passed");;
(ok (is_dir(Root(UpDir(EndPoint)))) "... this passed");;
(ok (is_dir(Root(Dir("foo", UpDir(EndPoint))))) "... this passed");;
(ok (is_dir(Dir("foo", EndPoint))) "... this passed");;
(ok (is_dir(Dir("foo", Dir("bar", EndPoint)))) "... this passed");;
(ok (is_dir(Dir("foo", Dir("bar", CurrDir(EndPoint))))) "... this passed");;

(ok (not (is_dir(Root(CurrDir(File("foo.txt")))))) "... this passed");;
(ok (not (is_dir(Root(UpDir(File("foo.txt")))))) "... this passed");;
(ok (not (is_dir(Root(Dir("foo", UpDir(File("foo.txt"))))))) "... this passed");;
(ok (not (is_dir(Dir("foo", File("foo.txt"))))) "... this passed");;
(ok (not (is_dir(Dir("foo", Dir("bar", File("foo.txt")))))) "... this passed");;
(ok (not (is_dir(Dir("foo", Dir("bar", CurrDir(File("foo.txt"))))))) "... this passed");;

(* is file predicate *)

(ok (is_file(File("foo"))) "... this passed");;

(ok (not (is_file(EndPoint))) "... this passed");;
(ok (not (is_file(Root(EndPoint)))) "... this passed");;
(ok (not (is_file(Dir("foo", EndPoint)))) "... this passed");;
(ok (not (is_file(UpDir(EndPoint)))) "... this passed");;
(ok (not (is_file(CurrDir(EndPoint)))) "... this passed");;

(* is file predicate on deeper paths *)

(ok (is_file(Root(CurrDir(File("foo.txt"))))) "... this passed");;
(ok (is_file(Root(UpDir(File("foo.txt"))))) "... this passed");;
(ok (is_file(Root(Dir("foo", UpDir(File("foo.txt")))))) "... this passed");;
(ok (is_file(Dir("foo", File("foo.txt")))) "... this passed");;
(ok (is_file(Dir("foo", Dir("bar", File("foo.txt"))))) "... this passed");;
(ok (is_file(Dir("foo", Dir("bar", CurrDir(File("foo.txt")))))) "... this passed");;

(ok (not (is_file(Root(CurrDir(EndPoint))))) "... this passed");;
(ok (not (is_file(Root(UpDir(EndPoint))))) "... this passed");;
(ok (not (is_file(Root(Dir("foo", UpDir(EndPoint)))))) "... this passed");;
(ok (not (is_file(Dir("foo", EndPoint)))) "... this passed");;
(ok (not (is_file(Dir("foo", Dir("bar", EndPoint))))) "... this passed");;
(ok (not (is_file(Dir("foo", Dir("bar", CurrDir(EndPoint)))))) "... this passed");;

