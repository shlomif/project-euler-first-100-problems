#!/usr/bin/env python3

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

import math


def is_prime(n):
    if n <= 1:
        return False

    top = int(math.sqrt(n))

    for i in range(2, top+2):
        if n % i == 0:
            return False
    return True


def main():
    n = 33
    found = True
    while found:
        n += 2
        if not is_prime(n):
            sq = 1
            square = 2*sq*sq
            found = False
            while n > square:
                if (is_prime(n - square)):
                    found = True
                sq += 1
                square = 2*sq*sq
    print("n = {}\n".format(n))


main()
