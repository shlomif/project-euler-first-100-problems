#!/usr/bin/perl
#
# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

use strict;
use warnings;

my $s = "";

vec( $s, 0, 2 ) = 3;
vec( $s, 0, 2 )++;

print "Foo = ", vec( $s, 0, 2 ), "\n";
