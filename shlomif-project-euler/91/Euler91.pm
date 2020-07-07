package main;

use strict;
use warnings;

use Math::GMP;

use List::Util qw(min);

=head1 ANALYSIS

One can see that the right angle can be:

=head2 In O.

In this case, there are x_len * y_len triangles.

=cut

sub get_num_O_right_angle_triangles
{
    my ( $x_len, $y_len ) = @_;

    return $x_len * $y_len;
}

=head2 Right angle at one of (x1,y1) or (x2,y2).

If it's in (x1,y1) then we can flip it and get the same for (x2,y2). So
we can calculate only for (x1,y1) and multiply by 2.

If the corner is in (x1,y1), then the other corner should be at offsets
along d(x=y1,y=x1), only we need to make sure they are coprime numbers (i.e:
their gcd is 0).

=cut

sub _get_num_other_helper
{
    my ( $x_len, $y_len ) = @_;

    my @limits = ( $x_len, $y_len );

    my @p2_limits = ( $x_len, 0 );

    my $count = 0;

    foreach my $delta_x ( 1 .. $limits[0] )
    {
    DELTA_Y:
        foreach my $delta_y ( 1 .. $limits[1] )
        {
            if ( Math::GMP->new($delta_y)->bgcd($delta_x) != 1 )
            {
                next DELTA_Y;
            }
            my $max_p1_multi =
                min( int( $x_len / $delta_x ), int( $y_len / $delta_y ) );

            my @delta2 = ( $delta_y, -$delta_x );
            foreach my $p1_multi ( 1 .. $max_p1_multi )
            {
                my @coords = ( $p1_multi * $delta_x, $p1_multi * $delta_y );
                my $max_p2_multi = (
                    min(
                        map {
                            int(
                                ( $p2_limits[$_] - $coords[$_] ) / $delta2[$_] )
                        } ( 0 .. 1 )
                    )
                );

                # print "[@coords] $max_p2_multi\n";

                $count += $max_p2_multi;
            }
        }
    }

    # Deal with the delta_x = 0 case
    $count += $x_len * $y_len;

    return $count;
}

sub get_num_other_triangles
{
    return 2 * _get_num_other_helper(@_);
}

1;

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
