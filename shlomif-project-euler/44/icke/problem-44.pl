#!/usr/bin/perl

use strict;
use warnings;

use constant SIZE => 10_000;

my @pent = map penti($_), 1 .. SIZE;
my %pent;
{
    my $limit = 2 * $pent[-1];    # larger than the sum of any two in @pent
    my $i     = 1;
    while ( ( my $p = penti($i) ) <= $limit )
    {
        $pent{$p} = $i++;
    }
}

my $i_j = 1;
my $pd;
my $pj;
my ( $is, $ik );
my ( $k,  $s );

for my $d ( 1 .. $#pent )
{
    $pd = $pent[ $d - 1 ];
    while ( $pent[$i_j] < $pent[ $d + 1 ] - $pd )
    {
        $i_j++;
    }
    for my $j ( $i_j .. $#pent )
    {
        $pj = $pent[ $j - 1 ];
        last if ( $pent[$j] - $pj > $pd );
        ( $ik, $is ) = @pent{ ( $k, $s ) = ( $pj + $pd, $pj + $pj + $pd ) };
        if ( $is and $ik )
        {
            print "($j, $ik) $pj, $k, sum $s ($is), diff $pd ($d)\n";
            exit;
        }
    }
}

sub penti
{
    my ($n) = @_;
    $n * ( 3 * $n - 1 ) / 2;
}

