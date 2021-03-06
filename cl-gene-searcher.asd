(in-package #:cl-user)

(defpackage #:cl-gene-searcher-asd
  (:use :cl))

(in-package :cl-gene-searcher-asd)

(asdf:defsystem :cl-gene-searcher
  :name "cl-gene-searcher"
  :version "0.1"
  :maintainer "David Thole"
  :author "David Thole"
  :license "LGPL"
  :description "A simple interface to a SQLite database for querying information for genes, and DGV Tracks."
  :components ((:file "lib/cl-gene-searcher/package")
	       (:file "lib/cl-gene-searcher/db-connections")
	       (:file "lib/cl-gene-searcher/db-defs")
	       (:file "lib/cl-gene-searcher/cl-gene-searcher"))
  :serial t
  :depends-on (:clsql-sqlite3))
