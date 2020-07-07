; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

(defun factorize-using-factor (num factor)
  (if (not (= (mod num factor) 0))
    0
    (1+ (factorize-using-factor (/ num factor) factor))))

(defun factorize (num)
  (iter (for factor from 2)
        (until (= num 1))
        (let ((e (factorize-using-factor num factor)))
          (if (not (= e 0))
            (progn (collect (cons factor e))
                   (setq num (/ num (expt factor e))))))))

(defun num-divisors (num)
  (reduce #'*
          (mapcar #'(lambda (pair) (1+ (cdr pair))) (factorize num))
          :initial-value 1))

(defun sum-divisors (num)
  (iter (for div from 1 to (floor (/ num 2)))
        (if (zerop (mod num div))
          (sum div))))

(defun myfind ()
  (iter (for i from 1 to (1- 10000))
        (format t "~A~%" i)
        (let ((d-i (sum-divisors i)))
          (if (and (/= i d-i)
                   (< d-i 10000)
                   (= i (sum-divisors d-i)))
            (sum i)))))
