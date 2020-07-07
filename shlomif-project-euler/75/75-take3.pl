#!/usr/bin/perl

use strict;
use warnings;

sub gcd
{
    my ( $n, $m ) = @_;

    if ( $m == 0 )
    {
        return $n;
    }

    return gcd( $m, $n % $m );
}

my $limit      = 1_500_000;
my $half_limit = ( $limit >> 1 );

my $verdicts = "";

my $hypotenuse_lim = int( $limit / 2 );

my $major_side_limit = int( $limit / 2 );

# Euclid's formula
my $m_limit = int( sqrt($hypotenuse_lim) );
for my $m ( 2 .. $m_limit )
{
    if ( $m % 1000 == 0 )
    {
        print "M=$m\n";
    }
    my $n = ( ( ( $m & 0x1 ) == 0 ) ? 1 : 2 );

N_LOOP:
    while ( $n < $m )
    {
        if ( gcd( $m, $n ) == 1 )
        {
            my $half_sum = $m * ( $m + $n );
            if ( $half_sum > $half_limit )
            {
                last N_LOOP;
            }

            if ( vec( $verdicts, $half_sum, 2 ) != 2 )
            {
                my $sum_product = 0;

                while ( ( $sum_product += $half_sum ) < $half_limit )
                {
                    if ( vec( $verdicts, $sum_product, 2 ) != 2 )
                    {
                        vec( $verdicts, $sum_product, 2 )++;
                    }
                }
            }
        }
    }
    continue
    {
        $n += 2;
    }
}

my $count = 0;
foreach my $sum_idx ( ( 12 >> 1 ) .. ( $limit >> 1 ) )
{
    if ( vec( $verdicts, $sum_idx, 2 ) == 1 )
    {
        $count++;
    }
}

print "Count = $count\n";

=head1 COPYRIGHT & LICENSE

Copyright 2018 by Shlomi Fish

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
