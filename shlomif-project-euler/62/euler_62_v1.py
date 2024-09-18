#!/usr/bin/env python3

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

def permutation_signature(n):
    return "".join(sorted("{}".format(n)))


def cube(n):
    return n ** 3


def main():
    m = {}

    n = 1
    while True:
        c = cube(n)
        key = permutation_signature(c)
        if key not in m:
            m[key] = []
        arr = m[key]
        arr.append(c)
        if (len(arr) == 5):
            print(arr[0])
            break
        n += 1


main()
