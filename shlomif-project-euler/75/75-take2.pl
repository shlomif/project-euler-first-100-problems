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

my $evenness = 1;
MAJOR_SIDE:
for my $major_side ( 4 .. $major_side_limit )
{
    if ( $major_side % 100 == 0 )
    {
        print "Maj=$major_side\n";
    }

    # If the major side is odd, then the minor side cannot be odd.
    # If they are both even, then we've already inspected ($major/2,$minor/2).
MINOR_SIDE:
    for my $half_minor_side ( 2 .. ( ($major_side) >> 1 ) )
    {
        my $minor_side = ( $half_minor_side << 1 ) - $evenness;
        if ( gcd( $major_side, $minor_side ) != 1 )
        {
            next MINOR_SIDE;
        }

        my $hypot_sq = $major_side * $major_side + $minor_side * $minor_side;

        my $hypot = sqrt($hypot_sq);
        if ( $hypot == int($hypot) )
        {
            # Only even numbers can be sums, so we can divide the index
            # by 2.
            # See 75-analysis.txt
            my $sum = ( ( $major_side + $minor_side + $hypot ) >> 1 );

            if ( $sum > $half_limit )
            {
                last MINOR_SIDE;
            }

            if ( vec( $verdicts, $sum, 2 ) != 2 )
            {
                my $sum_product = 0;

                while ( ( $sum_product += $sum ) < $half_limit )
                {
                    if ( vec( $verdicts, $sum_product, 2 ) != 2 )
                    {
                        vec( $verdicts, $sum_product, 2 )++;
                    }
                }
            }
        }
    }
}
continue
{
    $evenness ^= 0b1;
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
