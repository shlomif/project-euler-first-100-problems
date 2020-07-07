#!/usr/bin/perl

use strict;
use warnings;

my $limit = 1_500_000;

my $verdicts = "";

my $hypotenuse_lim = int( $limit / 2 );

HYPO:
for my $hypotenuse_length ( 5 .. $hypotenuse_lim )
{
    print "$hypotenuse_length\n" if ( not $hypotenuse_length % 1_000 );
    my $hypot_sq = $hypotenuse_length**2;

    my $side1_lim = int( $hypotenuse_length / 2 );

    for my $side1_len ( 1 .. $side1_lim )
    {
        my $side2_len = sqrt( $hypot_sq - ( $side1_len**2 ) );

        if ( $side2_len == int($side2_len) )
        {
            my $sum = int( $side2_len + $side1_len + $hypotenuse_length );
            if ( $sum <= $limit )
            {
                # Only even numbers can be sums, so we can divide the index
                # by 2.
                # See 75-analysis.txt
                my $idx = ( $sum >> 1 );
                if ( vec( $verdicts, $idx, 2 ) != 2 )
                {
                    vec( $verdicts, $idx, 2 )++;
                }
            }
        }
    }
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
