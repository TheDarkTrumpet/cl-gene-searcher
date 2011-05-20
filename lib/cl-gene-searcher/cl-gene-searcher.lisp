; db-gene-searcher.lisp
;
; Requires on the included sqlite database to work correctly.
(in-package :cl-gene-searcher)

;;;; Disable caching, mostly for debugging at this point ;;;;
(setf clsql:*cache-table-queries-default* nil)

;;;;;; ENABLE SYNTAX READER ;;;;;;;
; Note, ran into some issues with this at times, run:
; (clsql:locally-disable-sql-reader-syntax) to disable syntax, then again to reenable
;
(clsql:disable-sql-reader-syntax)
(clsql:enable-sql-reader-syntax)

(defmacro with-generic-sqlite-db ((var) &body body)
  `(let* ((,var (connect-db (make-instance 'db-connection-sqlite :path "data/hg18.sqlite")))
	  (with-generic-sqlite-db-output ,@body))
     (disconnect-db ,var)
     with-generic-sqlite-db-output))

(define-condition query-error (error)
  ((text :initarg :text :reader text)))





; Maybe a temporary holding ground for some of the simpler functions
(defun query-gene-by-name (name)
  (with-generic-sqlite-db (v) (clsql:select 'genes :where [= 'name name] :database v :flatp t)))

(defun query-gene-by-range (&key chr start stop)
  (when (not stop) (setf stop start))
  (with-generic-sqlite-db (v) (clsql:select 'genes :where [and [= 'chr chr] [>= 'start_region start] [<= 'stop_region stop]] :database v :flatp t)))