; Copyright by Shlomi Fish, 2018 under the Expat licence
; https://opensource.org/licenses/mit-license.php

; This aims to be a solution for:
; http://projecteuler.net/index.php?section=problems&id=5
(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

(format t "Total = ~A~%"
        (iter (for i from 1 to 20)
              (reducing i by #'lcm initial-value 1 into retlcm)
              (finally (return retlcm))))
