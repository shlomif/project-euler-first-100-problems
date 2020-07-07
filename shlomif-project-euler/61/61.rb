#!/usr/bin/ruby

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

class Integer
    def upper
        return to_s[0,2].to_i
    end
    def lower
        return to_s[2,2].to_i
    end

    def len4?
        return ((self >= 1000) and (self <= 9999))
    end

    def oct
        return self * (3*self-2);
    end
end

class Figurate
    def get_m
        return @m
    end

    def solve
        # fill should be called first.
        n = 1
        while not n.oct.len4?
            n += 1
        end
        while ! r = solve_for([n.oct], {})
            n += 1
        end
        return r
    end

    def solve_for(nums, checked)
        if (checked.keys.length == @m.keys.length)
            if (nums[-1].lower == nums[0].upper)
                return nums
            else
                return false
            end
        else
            l = nums[-1].lower
            for base in @m.keys
                if (!checked[base])
                    new_checked = checked.clone
                    new_checked[base] = 1
                    for n in (@m[base]['s'][l] || [])
                        ret = solve_for(
                            nums +[(l.to_s + n.to_s).to_i],
                            new_checked
                        )
                        if ret
                            return ret
                        end
                    end
                end
            end
            return false
        end
    end

    def fill
        for base in @m.keys
            b = @m[base]
            g = @m[base]['g']
            n = 1
            while not g.call(n).len4?
                n += 1
            end
            while g.call(n).len4?
                result = g.call(n)
                u = result.upper
                l = result.lower
                @m[base]['s'][u] ||= []
                @m[base]['s'][u].push(l)
                n += 1
            end
        end
    end

    def initialize
        @m = {
            3 => {
                # g is the generator
                'g' => lambda { |n| ((n * (n+1))>>1) },
                # s are the steps
                's' => {},
            },
            4 => {
                'g' => lambda { |n| (n**2) },
                's' => {},
            },
            5 => {
                'g' => lambda { |n| ((n*(3*n-1))>>1) },
                's' => {},
            },
            6 => {
                'g' => lambda { |n| (n*(2*n-1)) },
                's' => {},
            },
            7 => {
                'g' => lambda { |n| ((n*(5*n-3))>>1) },
                's' => {},
            },
        };
    end
end

$f = Figurate.new
$f.fill()
$r = $f.solve()
puts $r.inject(0) { |a,b| a+b}
