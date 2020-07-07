#!/usr/bin/perl

use strict;
use warnings;

use integer;

my $limit = 50_000_000;

my $sq_limit = int( sqrt($limit) );

my @primes = `primesieve -p1 2 $sq_limit`;
chomp(@primes);

my $bit_mask = "";

my $count = 0;

foreach my $p_square (@primes)
{
    print "P-Sq = $p_square\n";

    my $sum1 = ( $p_square**2 );

CUBE:
    foreach my $p_cube (@primes)
    {
        my $sum2 = $sum1 + ( $p_cube**3 );

        if ( $sum2 > $limit )
        {
            last CUBE;
        }

    FOURTH:
        foreach my $p_fourth (@primes)
        {
            my $sum3 = $sum2 + ( $p_fourth**4 );

            if ( $sum3 > $limit )
            {
                last FOURTH;
            }

            if ( !vec( $bit_mask, $sum3, 1 ) )
            {
                $count++;
                vec( $bit_mask, $sum3, 1 ) = 1;
            }
        }
    }
}
print "Count = $count\n";

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
