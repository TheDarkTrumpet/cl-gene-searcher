(in-package :cl-gene-searcher)

(def-view-class genePlatform ()
  ((id :type integer :reader id :db-kind :key)
   (name :accessor name :type (string 255) :initarg :name))
  (:base-table genePlatform))

(def-view-class genes ()
  ((name :accessor name :type (string 255) :initarg :name)
   (chr :accessor chr :type (string 5) :initarg :chr)
   (start_region :accessor start_region :type integer :initarg :start_region)
   (stop_region :accessor stop_region :type integer :initarg :stop_region)
   (strand :accessor strand :type (string 1) :initarg :strand)
   (platform :accessor platform :db-kind :join
	     :db-info ( :join-class genePlatform
				    :home-key platform
				    :foreign-key id
				    :retrieval :immediate
				    :set nil
				    )))
  (:base-table genes))

(def-view-class dgv ()
  ((id :type integer :reader id :db-kind :key)
   (chr :accessor chr :type (string 5) :initarg :chr)
   (start_region :accessor start_region :type integer :initarg :start_region)
   (stop_region :accessor stop_region :type integer :initarg :stop_region)
   (strand :accessor strand :type (string 1) :initarg :strand))
  (:base-table dgv))