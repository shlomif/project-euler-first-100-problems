#! /bin/bash
#
# 7.bash
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.

primesieve -p1 1e9 | perl -lnE 'do {say;exit} if $. == 10001'
