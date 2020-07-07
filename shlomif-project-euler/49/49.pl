#!/usr/bin/perl

use strict;
use warnings;

my $primes_bitmask = "";

for my $p ( 2 .. int( sqrt(9999) ) )
{
    if ( vec( $primes_bitmask, $p, 1 ) == 0 )
    {
        my $i = $p + $p;
        while ( $i < 10_000 )
        {
            vec( $primes_bitmask, $i, 1 ) = 1;
        }
        continue
        {
            $i += $p;
        }
    }
}

sub gen_perms
{
    my ($set) = @_;

    if ( @$set == 0 )
    {
        return [ [] ];
    }

    my $elem;
    my @prev_elems;
    my @perms;
    while ( defined( $elem = shift(@$set) ) )
    {
        push @perms,
            ( map { [ $elem, @{$_} ] }
                @{ gen_perms( [ @prev_elems, @$set ] ) } );
        push @prev_elems, $elem;
    }

    return \@perms;
}

my @perms = @{ gen_perms( [ 0 .. 3 ] ) };

# Shift the trivial permutation.
shift(@perms);

N_LOOP:
foreach my $n ( 1000 .. 9999 )
{
    if ( vec( $primes_bitmask, $n, 1 ) )
    {
        next N_LOOP;
    }
    my @d        = split( m{}, $n );
    my $n_sorted = join( "", sort { $a cmp $b } @d );
PERM_LOOP:
    foreach my $p (@perms)
    {
        my $m = join( "", @d[@$p] );

        if ( $m <= $n )
        {
            next PERM_LOOP;
        }

        if ( vec( $primes_bitmask, $m, 1 ) )
        {
            next PERM_LOOP;
        }

        my $k = $m + ( $m - $n );

        if ( vec( $primes_bitmask, $k, 1 ) )
        {
            next PERM_LOOP;
        }

        if ( join( "", sort { $a cmp $b } split( //, $k ) ) eq $n_sorted )
        {
            print "Found $n,$m,$k\n";
        }
    }
}

=head1 COPYRIGHT & LICENSE

Copyright 2017 by Shlomi Fish

This program is distributed under the MIT / Expat License:
L<http://www.opensource.org/licenses/mit-license.php>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut
