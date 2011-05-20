(in-package :cl-gene-searcher)

(def-view-class genes ()
  ((name :accessor name :type (string 255) :initarg :name)
   (chr :accessor chr :type (string 5) :initarg :chr)
   (start_position :accessor start_position :type integer :initarg :start_position)
   (stop_position :accessor stop_position :type integer :initarg :stop_position)
   (strand :accessor strand :type (string 1) :initarg :strand)
   ))