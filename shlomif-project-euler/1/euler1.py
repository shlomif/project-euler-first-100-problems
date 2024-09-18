#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2024 Shlomi Fish < https://www.shlomifish.org/ >
#
# Licensed under the terms of the MIT license.

"""
"""


def mysum(top, step):
    if top % step:
        maxx = top - (top % step)
    else:
        maxx = top - step
    n = maxx // step
    sum_ = n * (step + maxx)
    sum_, mod = divmod(sum_, 2)
    assert mod == 0
    return sum_


def sum35(top):
    return mysum(top=top, step=3) + mysum(top=top, step=5) - \
        mysum(top=top, step=3*5)


def solve():
    return sum35(top=1000)


assert sum35(top=10) == 3 + 5 + 6 + 9
print(solve())
