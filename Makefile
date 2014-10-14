
SOURCES = pathTools.ml
RESULT  = pathTools

PACKS = str

LIBINSTALL_FILES = pathTools.mli pathTools.cmi \
		           pathTools.cma pathTools.cmxa pathTools.a

INCDIRS = /usr/local/lib/ocaml/site-lib/
OCAMLBLDFLAGS = str.cma

all: bcl

opt: ncl

test: all
	prove t/*.ml

-include OCamlMakefile