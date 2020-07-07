#!/usr/bin/perl

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

use strict;
use warnings;

use Test::More tests => 2;

use lib '.';
use Euler91;

# TEST
is( get_num_O_right_angle_triangles( 2, 2 ), 4, "2*2 O triangles" );

# TEST
is( get_num_other_triangles( 2, 2 ), 10, "2*2 O triangles" );
