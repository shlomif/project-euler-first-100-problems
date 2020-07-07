#!/usr/bin/perl
# Adapted by Shlomi Fish.
#
# Solution for:
#
# http://projecteuler.net/problem=23

use strict;
use warnings;

use feature qw/say/;

my @divisors_sums;
$divisors_sums[1] = 0;

my $MAX = 28_123;
foreach my $div ( 1 .. ( $MAX >> 1 ) )
{
    my $prod = ( $div << 1 );
    while ( $prod <= $MAX )
    {
        $divisors_sums[$prod] += $div;
    }
    continue
    {
        $prod += $div;
    }
}

# Memoized.
#
my $is_abundant_sum = '';

my @abundants;
my $total = 0;
foreach my $num ( 1 .. $MAX )
{
    if ( $divisors_sums[$num] > $num )
    {
        push @abundants, $num;
    INNER:
        foreach my $i (@abundants)
        {
            my $s = $i + $num;
            if ( $s > $MAX )
            {
                last INNER;
            }
            if ( !vec( $is_abundant_sum, $s, 1 ) )
            {
                $total += $s;
                vec( $is_abundant_sum, $s, 1 ) = 1;
            }
        }
    }
}

say "Sum == ", ( ( ( ( 1 + $MAX ) * $MAX ) >> 1 ) - $total );

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
