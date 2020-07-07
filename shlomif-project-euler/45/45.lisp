; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

;;; n*(3*n-1) /2 = 1.5n^2 - 0.5n - P = 0
;;;                 3n^2 - n - 2*P = 0
;;; n = [ 1 +/- sqrt(1-
;;;
(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)


(defun quadratic-value (n a b c)
  (+ c (* n (+ b (* n a)))))

(defun quadratic-solve (P a b c-mul)
  (let ((n (floor (/ (+ (- b)
                      (sqrt (- (* b b) (* 4 a c-mul P))))
                   (* 2 a)))))
    (or (= (quadratic-value n a b (* P c-mul)) 0)
        (= (quadratic-value (1+ n) a b (* P c-mul)) 0))))

(defun is-pentagonal (n)
  (quadratic-solve n 3 -1 -2))

(deftest pent1 ()
         (is-pentagonal 1))

(deftest pent2 ()
         (is-pentagonal 5))

(deftest pent3 ()
         (is-pentagonal 12))

(deftest pent4 ()
         (is-pentagonal 40755))

(deftest pent5 ()
         (not (is-pentagonal 40750)))

; (cybertiggyr-test:run)

(defun is-triangle (n)
  (quadratic-solve n 1 1 -2))

(iter (for n from 144)
      (let ((Hn (* n (1- (* n 2)))))
           (if (and (is-pentagonal Hn) (is-triangle Hn))
             (format t "Number = ~A~%" Hn))))
