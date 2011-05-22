;  This file only has the database connection information.
;  Currently only SQLITE is available.

(in-package :cl-gene-searcher)

(defvar *global-db-connection-object* nil)

(defclass db-connection ()
  ((type :initarg :type :accessor db-type))
  (:documentation "The foundation datbase connection class, that the others will inherit"))

(defclass db-connection-sqlite (db-connection)
  ((type :initform "sqlite3" :reader db-type)
   (path :initarg :path :accessor path))
  (:documentation "The specific connection object for SQLite"))

(defgeneric connect-db (db-connection)
  (:documentation "Generic method for which the various database types will be supported"))

(defmethod connect-db ((db db-connection-sqlite))
  (when (not (and *global-db-connection-object*
		  (eql (database-state *global-db-connection-object*) :open)))
    (setf *global-db-connection-object*
	  (connect (list (path db))
	     :database-type :sqlite3
	     :make-default t)))
  *global-db-connection-object*)

(defun disconnect-db ()
  (when (eql (database-state *global-db-connection-object*) :open)
    (disconnect :database *global-db-connection-object*))
  T)
