#!/usr/bin/ruby

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

class Integer

    def rsum
        return self + self.to_s.reverse.to_i
    end

    def palin?
        s = self.to_s
        return s.reverse == s
    end

    def lycherel?
        n = self.rsum
        for i in 1..50
            if n.palin? then
                return false
            end
            n = n.rsum
        end
        return true;
    end
end

puts ((1..10000).count { |n| n.lycherel? })
