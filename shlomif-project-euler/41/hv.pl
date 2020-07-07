#! /usr/bin/env perl
#
# Short description for hv.pl
#
use strict;
use warnings;
use 5.014;
use autodie;
use Math::Pari qw/ isprime /;
use Algorithm::Loops qw/ NextPermuteNum /;
my @a = reverse( 1 .. 7 );
my @b = ( 0 .. 6 );

while (1)
{
    die( join "", @a[@b] ) if isprime( join '', @a[@b] );
    die "none found\n" unless NextPermuteNum(@b);
}
