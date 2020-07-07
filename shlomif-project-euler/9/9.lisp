; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

; This aims to be a solution for:
; https://projecteuler.net/problem=9
(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

; a^2 + b^2 = c^2
; a + b + c = 1000
; ===>
; a^2 + b^2 = (1000-(a+b))^2
; a^2 + b^2 = 1000^2 + (a+b)^2 - 2000(a+b)
; 0 = 1000^2 + 2ab - 2000a - 2000b
; 1e6+2ab = 2000(a+b)

(defun mysq (a) (* a a))

(defun mycond (a b)
  (= (+ (mysq a) (mysq b))
     (mysq (- 1000 a b))))

(iter a-iter
      (for a from 1 to 500)
      (iter b-iter
            (for b from (+ a 1) to 500)
            (until (mycond a b))
            (finally (if (mycond a b)
                       (format t
                               "a = ~A ; b = ~A ; c = ~A~%"
                               a b (- 1000 a b))))))
