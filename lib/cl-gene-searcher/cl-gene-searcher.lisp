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

(defvar *database-path* "data/hg18.sqlite")

(defun setDatabasePath(path) 
  (setf *database-path* path))

(defun getDatabasePath ()
  *database-path*)

(defmacro with-generic-sqlite-db ((var) &body body)
  `(let* ((,var (connect-db (make-instance 'db-connection-sqlite :path (getDatabasePath)))))
     ,@body))

(define-condition query-error (error)
  ((text :initarg :text :reader text)))


; Maybe a temporary holding ground for some of the simpler fuctions
(defun query-gene-by-name (name &rest names)
  (let ((genecol '()))
    "Given 1 or more names, we attempt to loop through the names, looking up each of the names and returning a collection"
    (setf names (append names (list name)))
    (loop for x in names 
	  for gene = (with-generic-sqlite-db (v) (clsql:select 'genes :where [like [slot-value 'genes 'name] x] :database v :flatp t :caching nil))
	  while x
	  do
       (cond ((listp gene)
	      (loop for g in gene do (push g genecol)))
	     ((equal 'genes (type-of gene))
	      (push gene genecol))))
    genecol))

(defun query-ucsc-gene-by-range (&key chr start stop)
  (with-generic-sqlite-db (v)
    (when (not stop) (setf stop start))
    (clsql:select 'genes :where [and [= 'chr chr] [>= 'stop_region start] [<= 'start_region stop] [= [slot-value 'genePlatform 'name] "UCSC"]] :database v :flatp t :caching nil)))

(defun query-refFlat-gene-by-range (&key chr start stop)
  (with-generic-sqlite-db (v)
    (when (not stop) (setf stop start))
    (clsql:select 'genes :where [and [= 'chr chr] [>= 'stop_region start] [<= 'start_region stop] [= [slot-value 'genePlatform 'name] "refFlat"]] :database v :flatp t :caching nil)))

(defun query-gene-by-range (&key chr start stop)
  (when (not stop) (setf stop start))
  (with-generic-sqlite-db (v) (clsql:select 'genes :where [and [= 'chr chr] [>= 'stop_region start] [<= 'start_region stop]] :database v :flatp t :caching nil)))

(defun query-dgv-by-range (&key chr start stop)
  (when (not stop) (setf stop start))
  (with-generic-sqlite-db (v) (clsql:select 'dgv :where [and [= 'chr chr] [>= 'stop_region start] [<= 'start_region stop]] :database v :flatp t :caching nil)))
