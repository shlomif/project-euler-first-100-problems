#! /bin/bash
#
# 3.bash
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.
#

factor 600851475143 | perl -lanE 'say $F[-1]'
