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
(clsql:locally-disable-sql-reader-syntax)
(clsql:locally-enable-sql-reader-syntax)

(defmacro with-generic-sqlite-db ((var) &body body)
  `(let ((,var (connect-db (make-instance 'db-connection-sqlite :path "data/hg18.sqlite"))))
     ,@body
     (disconnect-db ,var)))

(define-condition query-error (error)
  ((text :initarg :text :reader text)))

