;  This file only has the database connection information.
;  Currently only SQLITE is available.

(in-package :cl-gene-searcher)

(defclass db-connection ()
  ((type :initarg :type :accessor db-type))
  (:documentation "The foundation datbase connection class, that the others will inherit"))

(defclass db-connection-sqlite (db-connection)
  ((type :initform "sqlite3" :reader db-type)
   (path :initarg :path :accessor path))
  (:documentation "The specific connection object for SQLite"))

(defgeneric connect-db (db-connection &optional make-default)
  (:documentation "Generic method for which the various database types will be supported"))

(defmethod connect-db ((db db-connection-sqlite) &optional make-default)
  (connect (list 
	    (path db))
	   :database-type :sqlite3
	   :make-default make-default))

(defun disconnect-db (db)
  (when (eql (database-state db) :open)
    (disconnect :database db))
  T)
