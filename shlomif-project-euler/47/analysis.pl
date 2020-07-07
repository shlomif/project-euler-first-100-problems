#!/usr/bin/perl

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

use strict;
use warnings;

my $n    = shift;
my @mods = ( 0 .. $n - 1 );
foreach my $aa (@mods)
{
    foreach my $bb (@mods)
    {
        # print "$a $b ", (($a*$b*$b+1)%$n), "\n";
        print "$aa $bb ",
            ( ( ( 2 * $aa + 1 ) * ( 2 * $bb + 1 ) * ( 2 * $bb + 1 ) ) % $n ),
            "\n";
    }
}
