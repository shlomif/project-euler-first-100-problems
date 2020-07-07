#!/usr/bin/ruby

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

def is_prime(n)
    if n <= 1 then
        return false
    end

    top = Math.sqrt(n).to_i;

    for i in 2..top do
        if n % i == 0
            return false
        end
    end
    return true
end

n = 33
found = true
while found
    n += 2
    if (!is_prime(n)) then
        sq = 1
        square = 2*sq*sq
        found = false
        while n > square do
            if (is_prime(n - square))
                found = true
                break
            end
            sq += 1
            square = 2*sq*sq
        end
    end
end
print "n = #{n}\n"

