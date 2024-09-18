#!/usr/bin/env python3

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php


def num_digits(n):
    return len(str(n))


powers = list(range(1, 9+1))
count = 0
exponent = 1
while num_digits(powers[-1]) == exponent:
    count += len([n for n in powers if num_digits(n) == exponent])
    for i in range(1, 9+1):
        powers[i-1] *= i
    exponent += 1
print(count)
