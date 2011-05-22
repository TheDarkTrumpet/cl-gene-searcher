; Package definition for cl-gene-searcher

(in-package :cl-user)

(defpackage :cl-gene-searcher
    (:use :cl :clsql-sqlite3)
  (:import-from :clsql-sys :database-state)
  (:import-from :clsql :def-view-class :disconnect :connect)
  (:export :setDatabasePath :getDatabasePath
	   :query-gene-by-name :query-ucsc-gene-by-range
	   :query-gene-by-range :query-dgv-by-range))
