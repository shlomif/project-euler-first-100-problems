; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

; This aims to be a solution for:
; http://projecteuler.net/index.php?section=problems&id=1
(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

(defun sum1 (n)
  (iter (for i from 1 to n)
        (sum (if (or (= (mod i 3) 0) (= (mod i 5) 0)) i 0) into mysum)
        (finally (return mysum))))

(defun display-result ()
  (format t "Total is ~A~%" (sum1 (1- 1000))))
