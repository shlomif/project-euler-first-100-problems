#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2019 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
from functools import reduce


def gcd(*numbers):
    from math import gcd
    return reduce(gcd, numbers)


def lcm(numbers):
    return reduce((lambda a, b: (a*b) // gcd(a, b)), numbers, 1)


print(lcm(range(1, 21)))
