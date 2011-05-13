; Package definition for cl-gene-searcher

(in-package :cl-user)

(defpackage :cl-gene-searcher
    (:use :cl :clsql-sqlite3)
  (:import-from :clsql-sys :database-state)
  (:import-from :clsql :def-view-class :disconnect :connect))
