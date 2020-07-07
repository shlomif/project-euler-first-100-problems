#!/usr/bin/perl

use strict;
use warnings;

sub get_num_inner_rectangles
{
    my ( $w, $h ) = @_;

    my $sum = 0;
    for my $x ( 1 .. $w )
    {
        for my $y ( 1 .. $h )
        {
            $sum += ( $w - $x + 1 ) * ( $h - $y + 1 );
        }
    }

    return $sum;
}

print get_num_inner_rectangles( 3, 2 ), "\n";

my $min_w   = 3;
my $min_h   = 2;
my $min_num = get_num_inner_rectangles( $min_w, $min_h );

W:
for my $w ( 2 .. 2_000_000 )
{
    for my $h ( 1 .. $w )
    {
        my $num = get_num_inner_rectangles( $w, $h );

        if ( abs( 2_000_000 - $num ) < abs( 2_000_000 - $min_num ) )
        {
            $min_w   = $w;
            $min_h   = $h;
            $min_num = $num;
            print "Found $min_w,$min_h, @{[$min_w*$min_h]}\n";
        }
        elsif ( $num > 2_000_000 and $h == 1 )
        {
            last W;
        }
    }
}

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
