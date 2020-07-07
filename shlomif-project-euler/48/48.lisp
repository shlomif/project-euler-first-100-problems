; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

; This aims to be a solution for:
; http://projecteuler.net/index.php?section=problems&id=48
(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

(defparameter base (expt 10 10))

(defun *mod (n m)
  (mod (* n m) base))

; The algorithm is as follows:
; We need to find a ** N mod 10**10
; step     digit-at-place-(N-&-0x1)    Digit-Product Total-Product
; ----------------------------------------------------------------
;
(defun last-ten-digits (num)
  (iter (for run-num initially num
             then (ash run-num -1))
        (until (= run-num 0))
        (for digit-prod initially num
             then (*mod digit-prod digit-prod))
        (reducing (if (= (logand run-num #B1) #B1) digit-prod 1)
                  by #'*mod
                  initial-value 1
                  into total-prod)
        (finally (return total-prod))
        ))

(defun display-result ()
    (format t "Total is ~A~%"
            (iter (for i from 1 to 1000)
                  (sum (last-ten-digits i) into mysum)
                  (finally (return (mod mysum base))))))
