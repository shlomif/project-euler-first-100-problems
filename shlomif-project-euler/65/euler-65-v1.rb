# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

require 'rational'

class Integer
    def digit_sum
        return self.to_s.split(//s).reduce(0) {|a,b| a + b.to_i}
    end
    def num_digits
        return self.to_s.length
    end
end

class Rational
    def sqrt2_next
        return 1 + 1/(1 + self)
    end
    def numerator_with_more_digits?
        return self.numerator.num_digits > self.denominator.num_digits
    end
end

def e_convergent(n)
    if n == 0
        return 2
    elsif n % 3 == 2
        return (((n-2)/3+1)*2)
    else
        return 1;
    end
end

times = 100
result = e_convergent(times-1).quo(1)
(times-2).downto(0) do
    |i| result = e_convergent(i) + 1/result
    # puts result
end
# puts result.numerator
puts result.numerator.digit_sum
