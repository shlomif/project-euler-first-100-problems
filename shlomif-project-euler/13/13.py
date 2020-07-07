#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2019 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.

"""

"""

import re

s = open('euler-13-description.txt', 'r').read()
nums = [int(n) for n in re.findall('[0-9]{50}', s)]
print(str(sum(nums))[:10])
