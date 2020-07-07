#!/usr/bin/ruby

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

class Integer
    def permutation_signature
        return to_s.split(//).sort.join
    end
    def cube
        return self ** 3
    end
end

$m = {}

n = 1
while true
    c = n.cube
    sign = c.permutation_signature
    $m[sign] ||= []
    $m[sign].push(c)
    if ($m[sign].length == 5)
        puts $m[sign][0]
        break
    end
    n +=1
end

