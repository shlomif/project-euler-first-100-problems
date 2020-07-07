#!/usr/bin/ruby

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

class Integer
    def num_digits
        return to_s.length
    end
end

powers = (1..9).to_a
count = 0
exponent = 1
while powers[-1].num_digits == exponent
    count += powers.count { |n| n.num_digits == exponent }
    for i in 1..9
        powers[i-1] *= i
    end
    exponent += 1
end
puts count
