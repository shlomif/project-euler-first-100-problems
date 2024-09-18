# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

require 'set'

divisors = []
for modulo in (2..61) do
    x_set = Set.new
    y_set = Set.new
    for m in (0...modulo) do
        x_set.add((m*m) % modulo)
        y_set.add((61*m*m+1) % modulo)
    end
    numbers = (x_set & y_set).to_a.sort
    if ((numbers.length == 1) && (numbers[0] == 1))
        divisors << modulo
    end
    puts "modulo #{modulo} [" + (numbers.join(",")) + "]"
end

num = 1
for d in divisors
    num = num.lcm(d)
end
puts num
