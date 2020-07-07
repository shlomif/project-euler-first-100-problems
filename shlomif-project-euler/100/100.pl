#!/usr/bin/perl

use strict;
use warnings;

use IO::Handle;

use Math::BigInt lib => "GMP", ":constant";

my $n      = 7;
my $prev_n = 1;

STDOUT->autoflush(1);

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

while (1)
{
    if ( $n > 1_000_000_000_000 )
    {
        my $m = ( ( $n + 1 ) / 2 );
        print "P(BB)[$m] = ", find_blue_discs_num($m), "\n";
    }
}
continue
{
    ( $n, $prev_n ) = ( 6 * $n - $prev_n, $n );
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
