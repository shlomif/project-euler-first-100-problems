#! /usr/bin/env perl
#
# Short description for 91.pl
#
# Author Shlomi Fish <shlomif@cpan.org>
# Version 0.0.1
# Copyright (C) 2019 Shlomi Fish <shlomif@cpan.org>
#
use strict;
use warnings;
use 5.014;
use autodie;

use lib '.';
use Euler91;

print get_num_O_right_angle_triangles( 50, 50 ) +
    get_num_other_triangles( 50, 50 ), "\n";
