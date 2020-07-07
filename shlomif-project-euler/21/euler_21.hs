-- Copyright by Shlomi Fish, 2018 under the Expat licence
-- https://opensource.org/licenses/mit-license.php
import Data.Array

max_ = 200000

gen 100001 = []
gen n = [(i*n,n)|i <- [2 .. max_ `div` n]] ++ (gen (n+1))

arr = accumArray (+) 0 (0,max_) (gen 1)

result = sum $ filter (\a -> let b = (arr!a) in b /= a && (arr!b) == a) [1 .. (10000 - 1)]

main = putStrLn $ show result
