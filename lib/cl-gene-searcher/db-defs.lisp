(in-package :cl-gene-searcher)

(def-view-class genePlatform ()
  ((id :type integer :reader id :db-kind :key :db-constraints :primary-key)
   (name :accessor name :type (string 255) :initarg :name))
  (:base-table genePlatform))

(def-view-class genes ()
  ((name :accessor name :type (string 255) :initarg :name)
   (chr :accessor chr :type (string 5) :initarg :chr)
   (start_region :accessor start_region :type integer :initarg :start_region)
   (stop_region :accessor stop_region :type integer :initarg :stop_region)
   (strand :accessor strand :type (string 1) :initarg :strand)
   (platform :accessor platform :type integer :initarg :platform)
   (powner :accessor powner :db-kind :join
	    :db-info ( :join-class genePlatform
				   :home-key platform
				   :retrieval :immediate
				   :set nil
				   :foreign-key id
				   )))
  (:base-table genes))

(def-view-class dgv ()
  ((id :type integer :reader id :db-kind :key)
   (chr :accessor chr :type (string 5) :initarg :chr)
   (start_region :accessor start_region :type integer :initarg :start_region)
   (stop_region :accessor stop_region :type integer :initarg :stop_region)
   (strand :accessor strand :type (string 1) :initarg :strand))
  (:base-table dgv))
