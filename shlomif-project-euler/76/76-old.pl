#!/usr/bin/perl

use strict;
use warnings;

use 5.010;

use List::Util qw(sum min max);
use Math::BigInt lib => 'GMP';

no warnings 'recursion';

# An array of arrays -
# First index is the sum.
# Second index is the maximal possible element
my @num_sums;

$num_sums[1][1] = Math::BigInt->new(1);

sub calc_num_sum
{
    my ( $sum, $max ) = @_;

    print "Calling calc_num_sum($sum,$max)\n";

    print("CalcSum[$sum][$max]\n");

    $max = min( $max, $sum );

    if ( $max == $sum )
    {
        return $num_sums[$sum][$max] //= 1;
    }

    my $ret = (
        $num_sums[$sum][$max] //=
            do
        {
            my $count = Math::BigInt->new(0);
            foreach my $first ( 1 .. $max )
            {
                my $tail_sum = $sum - $first;

                $count += ( $num_sums[$tail_sum][$first] //=
                        calc_num_sum( $tail_sum, $first ) );
            }

            $count;
        }
    );

    print "Sum[$sum][$max] = $ret\n";

    return $ret;
}

calc_num_sum( 100, 99 );

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
