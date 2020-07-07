-- Copyright by Shlomi Fish, 2018 under the Expat licence
-- https://opensource.org/licenses/mit-license.php

digits_sum 0 = 0
digits_sum n = (n `mod` 10) + (digits_sum (n `div` 10))

factorial n = product [1 .. n]

result = digits_sum (factorial 100)

main = putStrLn ("DigitsSum[100!] = " ++ (show result))
