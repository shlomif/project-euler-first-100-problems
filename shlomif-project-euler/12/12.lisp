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
  (apply #'*
          (mapcar #'(lambda (pair) (1+ (cdr pair))) (factorize num))))

(defun myfind ()
  (iter (for i from 1)
        (sum i into num)
        (until (> (num-divisors num) 500))
        (finally (return num))))
