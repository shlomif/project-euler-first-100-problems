# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

class Numeric
    def square?
        root = Math.sqrt(self).to_i
        return root*root == self
    end
end

class Integer
    def find_x
        if self.square?
            return 0
        end
        x = 2
        while true
            n = x*x-1
            if n % self == 0
                puts "#{x} divides #{self}"
                if ( n / self ).square?
                    return x
                end
            end
            x += 1
        end
    end
end

max_D = 0
max_x = 0
for _D in 2 .. 1000
    x = _D.find_x
    puts "D = #{_D} x = #{x}"
    if x > max_x
        max_x = x
        max_D = _D
    end
end
puts "D = " + max_D.to_s

