; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

(defun digits-sum (num)
  (labels
    ((helper (n sum)
        (if (zerop n)
          sum
          (helper (floor n 10) (+ sum (mod n 10))))))
    (helper num 0)))

(defun myfind ()
  (digits-sum (expt 2 1000)))
