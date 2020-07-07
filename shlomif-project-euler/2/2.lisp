; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

; This aims to be a solution for:
; https://projecteuler.net/problem=2
(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

(defun sum1 (n)
  (iter (for f1 initially 1 then f2 and
             f2 initially 2 then (+ f1 f2))
        (until (> f1 n))
        (format t "Foo = ~A,~A~%" f1 f2)
        (sum f1 into mysum)
        (finally (return mysum))))

(defun display-result ()
  (format t "Total is ~A~%" (sum1 1e6)))



