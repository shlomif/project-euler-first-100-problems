# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

require "code.rb"

puts (2 .. 10_000).count { |n| (Math.sqrt(n).to_i ** 2 != n) and
    (n.continued_fraction()[1].length % 2 == 1) }
