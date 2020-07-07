#!/usr/bin/perl

use strict;
use warnings;

use integer;
use IO::Handle;

use List::Util qw(sum min max);

no warnings 'recursion';

sub find_for_num_product_and_sum
{
    my ( $max_i, $num_left, $product_left, $sum_left ) = @_;

# print "(num_left=$num_left, min_i=$min_i, prod_so_far=$prod_so_far, sum_left=$sum_left) Sum=$sum\n";

    # 1*1*1*1*1*$product_left
    if ( $product_left + $num_left - 1 == $sum_left )
    {
        return 1;
    }
    else
    {
    I_LOOP:
        for my $i (
            reverse(
                max( 2, $sum_left / $num_left )
                    .. min( $max_i, ( $product_left >> 1 ) )
            )
            )
        {
            if ( $product_left % $i )
            {
                next I_LOOP;
            }
            if (
                find_for_num_product_and_sum(
                    $i,
                    $num_left - 1,
                    $product_left / $i,
                    $sum_left - $i
                )
                )
            {
                return 1;
            }
        }
        return;
    }
}

sub smallest_product_n
{
    my ($n) = @_;

    my $sum = $n;

    while (1)
    {
        if ( find_for_num_product_and_sum( ( $sum >> 1 ), $n, $sum, $sum ) )
        {
            return $sum;
        }
    }
    continue
    {
        $sum++;
    }
}

my %numbers;

STDOUT->autoflush(1);

for my $n ( 2 .. 12_000 )
{
    my $val = smallest_product_n($n);

    # print "Reached $n = $val\n";
    $numbers{$val}++;

    if ( $n % 100 == 0 )
    {
        print "Reached $n = $val\n";
    }
}

print "Sum = ", sum( keys(%numbers) ), "\n";

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
