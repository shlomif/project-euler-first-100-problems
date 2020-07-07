#! /usr/bin/env perl
#
# Short description for from-forum-hv.pl
#
# Author Shlomi Fish <shlomif@cpan.org>
# Version 0.0.1
# Copyright (C) 2019 Shlomi Fish <shlomif@cpan.org>
#
use strict;
use warnings;
use 5.014;
use autodie;
use Math::Pari qw/ isprime /;

my @p = grep isprime($_), 2000 .. 5000;
my ( $min, $minn ) = ( 2, 0 );
for my $i ( 0 .. $#p )
{
    my $pi = $p[$i];
J: for my $j ( $i + 1 .. $#p )
    {
        my $pj = $p[$j];
        my $n  = $pi * $pj;
        last if $n > 1e7;
        my $t = my $phi = ( $pi - 1 ) * ( $pj - 1 );
        $t =~ s/$_// or next J for split //, $n;
        my $quot = $n / $phi;
        ( $min, $minn ) = ( $quot, $n ) if $min > $quot;
    }
}
print "At $minn, n/phi(n) is a minimum ($min)\n";
