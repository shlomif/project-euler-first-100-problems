# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

require 'rational'

Cache = { 1 => [], 2 => [2] }

def distinct_factors_helper(n, start_from)
    if not Cache.has_key?(n) then
        d = n
        to_add = []
        while ((d % start_from) != 0) do
            start_from += 1
        end
        while d % start_from == 0 do
            d /= start_from
        end
        to_add = [start_from]
        Cache[n] = to_add + distinct_factors_helper(d, start_from+1)
    end
    return Cache[n];
end

def distinct_factors(n)
    return distinct_factors_helper(n,2)
end

class Array
    # Returns the "power set" for this Array. This means that an array with all
    # subsets of the array's elements will be returned.
    def power_set
        # the power set line is stolen from http://johncarrino.net/blog/2006/08/11/powerset-in-ruby/
        inject([[]]) { |c,y| r=[] ; c.each{ |i| r<<i ; r<<i+[y] } ; r }
    end

    def product
        inject(1) { |p,x| p*x }
    end

    def coprimes_factor
        return power_set.inject(0) {
            |sum, subset| sum + (1.to_f / subset.product) * \
                        (-1) ** subset.length
        }
    end
end

max = 2
max_n = 1

for n in [2,3,5,7,11,13,17].power_set() do
    val = 1/n.coprimes_factor
    if (val > max) then
        max = val
        max_n = n.product
    end
end

puts "max_n = #{max_n} with #{max}"

