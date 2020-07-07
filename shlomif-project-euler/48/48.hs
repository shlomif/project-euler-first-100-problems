
Mod :: Integer
Mod = 10^10

mysum :: Integer
mysum = (sum $ map elem digit(1..1000)) `mod` Mod  where
    elem :: Integer -> Integer
    elem n = iterate n n where
        -- iterate 5 5
            -- 5=0b101
            -- = 5 * iterate (5 >> 1) (5*5)
        -- iterate 2 25
        iterate x  =
            (if (n `mod` 2 == 1)
            then current*
            )
            where
        (current*current `mod` Mod)
        iterate x



