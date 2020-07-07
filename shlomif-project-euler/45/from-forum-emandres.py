#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2019 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.

from math import sqrt
for x in range(285, 100000):
    c = (x**2 + x)/2
    y = (.5 + sqrt(.25 + 6*c))/3
    z = (1 + sqrt(1 + 8*c))/4

    if y - int(y) == 0 and z - int(z) == 0:
        print('x = %d' % x)
        print('y = %d' % y)
        print('z = %d' % z)
        print('c = %d' % c)
