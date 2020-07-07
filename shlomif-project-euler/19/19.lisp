; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

(defun is-in (num lst)
  (> (count-if #'(lambda (i) (= i num)) lst) 0))

(defun div-by (num modulo)
  (= (mod num modulo) 0))

(defun month-len (y m)
  (cond ((is-in m '(4 6 9 11)) 30)
        ((= m 2) (+ 28 (if (or (div-by y 400)
                               (and (div-by y 4) (not (div-by y 100))))
                         1 0)))
        (t 31)))

(defmacro-clause (sum7 expr &optional into var initial-value init-val)
    `(reducing ,expr by #'(lambda (m n) (mod (+ m n) 7))
               into ,var initial-value ,init-val))

(defun calc ()
  (iter year-iter
        (for year from 1900 to 2000)
        (iter (for month from 1 to 12)
              (in year-iter (sum7 (month-len year month) into day-of-week
                                  initial-value 2))
              (format t "DW=~A~%" day-of-week)
              (in year-iter (sum (if (and (>= year 1901)
                                          (= day-of-week 1)) 1 0)
                                 into mycount
                                 )))
        (finally (return-from year-iter mycount))
        ))

