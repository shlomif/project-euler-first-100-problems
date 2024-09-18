#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2024 Shlomi Fish < https://www.shlomifish.org/ >
#
# Licensed under the terms of the MIT license.

"""

"""

from math import floor
from math import sqrt


def introot(n):
    return floor(sqrt(n))


def continued_fraction(n):

    states = {}

    root = introot(n)
    numer = 1
    denom_in_root = n
    denom_out_of_root = -root

    def _calc_state_token():
        return (root, numer, denom_in_root, denom_out_of_root)

    s = _calc_state_token()
    ret = []

    # has_key? is like exists() in Perl.
    while s not in states:

        # Store the state appropriately.
        length = len(ret)
        ret.append(root)
        states[s] = length

        # Calculate the next state.

        new_denom = denom_in_root - denom_out_of_root*denom_out_of_root
        new_denom, _mod = divmod(new_denom, numer)
        if (_mod != 0):
            raise "We don't know how to handle it!"

        new_numer = [denom_in_root, -denom_out_of_root]

        root = floor((sqrt(new_numer[0]) + new_numer[1]) / new_denom)
        numer = new_denom
        denom_in_root = new_numer[0]
        denom_out_of_root = new_numer[1] - root * new_denom

        s = _calc_state_token()

    pos = states[s]

    return [ret[:pos], ret[pos:]]


def test_euler64():
    def t(number, result):
        assert continued_fraction(number) == result

    t(number=23, result=[[4], [1, 3, 1, 8]], )
    t(number=2, result=[[1], [2]], )
    t(number=3, result=[[1], [1, 2]], )
    t(number=5, result=[[2], [4]], )
    t(number=6, result=[[2], [2, 4]], )


test_euler64()


def solve():
    ret = 0
    for n in range(2, 10_000 + 1):
        if introot(n) ** 2 != n:
            if len(continued_fraction(n)[1]) % 2 == 1:
                ret += 1
    print(ret)
    return ret


solve()
