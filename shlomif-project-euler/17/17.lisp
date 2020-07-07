; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

(defun string-list-len (l)
  (apply #'+ (mapcar #'length l)))

(defun f-up-to-nine ()
  (list "one" "two" "three" "four" "five" "six" "seven" "eight" "nine"))

(defun f-ten-to-19 ()
  (list "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen"
        "sixteen" "seventeen" "eighteen" "nineteen"))

(defun f-tens ()
  (list "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))

(defun f-hundreds ()
  (mapcar (lambda (s) (concatenate 'string s "hundred")) (f-up-to-nine)))

(defun total ()
  (let ((up-to-nine (string-list-len (f-up-to-nine)))
        (ten-to-19 (string-list-len (f-ten-to-19)))
        (tens (string-list-len (f-tens)))
        (hundreds (string-list-len (f-hundreds)))
        )

    (+ (* up-to-nine 9 10) ; the digits of the non-teens
       (* ten-to-19 10) ; the digits of the teens
       (* tens 10 10) ; the digits of the tens
       (* hundreds 100) ; the digits of the hundreds.
       (* (length "and") 99 9) ; the digits of the "and" of the hundreds"
       (length "onethousand")
       )))

(format t "~a~%" (total))
