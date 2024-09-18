#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2024 Shlomi Fish < https://www.shlomifish.org/ >
#
# Licensed under the terms of the MIT license.


verbose = 0


def compare(got, expected, blurb):
    if verbose >= 1 or got != expected:
        print('blurb =', blurb, 'got =', got, 'expected =', expected,
              flush=True, )
    assert got == expected


def to_s(i):
    s = "{}".format(i)
    return s


def is_palin(i):
    s = to_s(i)
    return s == s[::-1]


def reverse_sum(i):
    s = to_s(i)
    return i + int(s[::-1])


def is_lycherel(i):
    n = reverse_sum(i)
    for _ in range(50):
        if is_palin(n):
            return False
        n = reverse_sum(n)
    return True


def count_lycherel(max_num):
    below_ten_thousand_margin = 0
    result = 0
    for x in range(1, max_num + below_ten_thousand_margin):
        if is_lycherel(x):
            result += 1
    return result


def main():
    result = count_lycherel(max_num=10_000)
    compare(result, 249, "result")
    print(result)


main()
