package Euler80;

use strict;
use warnings;

use Math::BigInt ( ":constant", lib => 'GMP' );

my $required_digits = 100;

my $margin                 = 10;
my $req_digits_with_margin = $required_digits + $margin;

sub square_root
{
    my $n = shift;

    my $n_with_digits = $n * ( 10**( $req_digits_with_margin * 2 ) );

    my $min = 0;
    my $max = $n_with_digits;
    my $mid = ( ( $max + $min ) >> 1 );

    my $epsilon = $n_with_digits / ( 10**$req_digits_with_margin );

    while (1)
    {
        my $square = $mid * $mid;

        # print "Mid = $mid\n";
        # print "Sq = $square\n";

        if ( abs( $square - $n_with_digits ) <= $epsilon )
        {
            return $mid;
        }
        elsif ( $square > $n_with_digits )
        {
            $max = $mid;
        }
        else
        {
            $min = $mid;
        }
        $mid = ( ( $max + $min ) >> 1 );
    }
}

1;

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
