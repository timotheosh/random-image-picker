;; Program for randomly picking a jpeg file for a given directory.
(setq ext:*help-message*
      "random-image-picker [--help | -?] <image-path>
     Picks a random jpeg file from the given path.
")

(defun select-random-background-image (image-path)
  "Select a random image"
  (let ((file-list (directory (concatenate 'string image-path "*.jpg")))
        (*random-state* (make-random-state t)))
    (namestring (nth (random (length file-list)) file-list))))

(defun print-image (image-path)
 (format t "~A~%" (select-random-background-image (car image-path))))

(defconstant +random-image-rules+
'(("--help" 0 (progn (princ ext:*help-message* *standard-output*) (ext:quit 0)))
  ("-?" 0 (progn (princ ext:*help-message* *standard-output*) (ext:quit 0)))
  ("*DEFAULT*" 1 (print-image 1) :stop)))

(let ((ext:*lisp-init-file-list* NIL)) ; No initialization files
  (handler-case (ext:process-command-args :rules +random-image-rules+)
    (error (c)
       (princ ext:*help-message* *error-output*)
       (ext:quit 1))))
(ext:quit 0)

;; ecl can compile this file with
;;(compile-file "random-image-picker.lisp" :system-p t)
;;(c:build-program "random-image-picker" :lisp-files '("random-image-picker.o"))
