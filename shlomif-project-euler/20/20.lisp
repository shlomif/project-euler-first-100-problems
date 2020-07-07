; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

; This aims to be a solution for:
; https://projecteuler.net/problem=20
(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

(defun digits-sum (num)
  (labels
    ((helper (n sum)
        (if (zerop n)
          sum
          (helper (floor n 10) (+ sum (mod n 10))))))
    (helper num 0)))

(defun factorial (num)
  (labels
    ((helper (n prod)
             (if (= n 0) prod (helper (1- n) (* prod n)))))
    (helper num 1)))

(defun myfind ()
  (digits-sum (factorial 100)))
