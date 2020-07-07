# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

Cache = { 1 => 0 }

def num_distinct_factors_helper(n, start_from)
    if not Cache.has_key?(n) then
        to_add = 0
        d = n
        if ((d % start_from) == 0) then
            while d % start_from == 0 do
                d /= start_from
            end
            to_add = 1
        end
        Cache[n] = to_add + num_distinct_factors_helper(d, start_from+1)
    end
    return Cache[n];
end

def num_distinct_factors(n)
    return num_distinct_factors_helper(n,2)
end

for n in 14 .. 100_000 do
    puts "NNN === #{n}"
    if not (n .. n+3).detect { |i| num_distinct_factors(i) != 4} then
        print "n = #{n}\n"
        exit
    end
end
