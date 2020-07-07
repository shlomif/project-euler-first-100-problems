#!/usr/bin/perl

use strict;
use warnings;
use integer;

use Math::GMP ();

=head1 Analysis

For $N , there should be $L < $N so that $L*($L-1) == ($N*($N-1))/2 :

$L^2 - $L - ($N*($N-1))/2 = 0

a = 1
b = -1
c = -N*(N-1)/2

L = [1 +/- sqrt ( 1 + 4*N*(N-1)/2)] / 2 = [1 +/- sqrt (1 + 2 * N * (N-1))] / 2
= [1 +/- sqrt ( 2*N^2 - 2*N + 1 )] / 2

2*N^2 - 2 * N + 1 = N^2 + (N-1)^2

(N+1)^2 = N^2 + 2N + 1

(N+2)^2 = (N+1)^2 + 2(N+1)+1

K^2 = N^2 + (N-1)^2

a^2 + b^2 = [ (a+b)^2 + (a-b)^2 ] / 2

N^2 + (N-1)^2 = [(2N-1)^2 + 1^2 ] / 2 = K^2

2K^2 = (2N-1)^2 + 1^2

=cut

sub find_blue_discs_num
{
    my $num_discs = shift;

    my $bottom = ( $num_discs >> 1 );
    my $top    = $num_discs;

    my $divide_by = $num_discs * ( $num_discs - 1 );

    my $wanted_product = ( $divide_by >> 1 );

    while ( $top >= $bottom )
    {
        my $mid = ( ( $bottom + $top ) >> 1 );

        my $product = $mid * ( $mid - 1 );
        if ( $product == $wanted_product )
        {
            return $mid;
        }
        elsif ( $product < $wanted_product )
        {
            $bottom = $mid + 1;
        }
        else
        {
            $top = $mid - 1;
        }
    }
    return;
}

print "P(BB)[22] = ",  find_blue_discs_num(21),  "\n";
print "P(BB)[120] = ", find_blue_discs_num(120), "\n";

my $n = Math::GMP->new('1000000000000') + 1;

while (1)
{
    print "N = $n\n";
    my $v = find_blue_discs_num($n);
    if ( defined($v) )
    {
        print "P(BB)[$n] = $v\n";
        exit(0);
    }
}
continue
{
    ++$n;
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
