# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php
#
require 'rational'

class Integer
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

num = 3.quo(2)
count = 0
for i in (1 .. 1000)
    if (num.numerator_with_more_digits?)
        count += 1
    end
    num = num.sqrt2_next
end
puts "count = #{count}"
