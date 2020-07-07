# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

class Integer
    def digit_sum
        return self.to_s.split(//s).reduce(0) {|a,b| a + b.to_i}
    end
end

max = 0
for a in (2 .. 99)
    aa = a
    for b in (1 .. 99)
        s = (aa).digit_sum
        if s > max
            max = s
        end
        aa *= a
    end
end
puts max
