#!/usr/bin/ruby

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

sum = 0
((1...1000).select {|i| (((i % 3) == 0) || ((i % 5) == 0)) }) \
    .each {|i| sum += i}
puts sum
