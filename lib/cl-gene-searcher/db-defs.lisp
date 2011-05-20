(in-package :cl-gene-searcher)

(def-view-class genes ()
  ((name :accessor name :type (string 255) :initarg :name)
   (chr :accessor chr :type (string 5) :initarg :chr)
   (start_region :accessor start_region :type integer :initarg :start_region)
   (stop_region :accessor stop_region :type integer :initarg :stop_region)
   (strand :accessor strand :type (string 1) :initarg :strand))
  (:base-table genes))
