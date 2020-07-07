#!/usr/bin/perl

use strict;
use warnings;
use IO::Handle;

use 5.010;

use List::Util qw(sum min);
use Math::BigInt ( ":constant", lib => 'GMP' );

STDOUT->autoflush(1);

my @sums;

$sums[1][0] = 0;
$sums[1][1] = 1;

my $total_sum = 2;
TOTAL_SUM_LOOP:
while (1)
{
    print "N = $total_sum\n";
    $sums[$total_sum][0] = 0;
    foreach my $max ( 1 .. $total_sum )
    {
        my $remains = $total_sum - $max;
        my $count   = (
            ( $remains == 0 )
            ? 1
            : sum( @{ $sums[$remains] }[ 0 .. min( $max, $remains ) ] )
        );

        # print "Count-sums--of-$total_sum-with-max=$max = $count\n";
        $sums[$total_sum][$max] = $count;
    }

    my $v = sum( @{ $sums[$total_sum] } );
    print "V = $v\n";
    if ( $v % 1_000_000 == 0 )
    {
        print "Found for $total_sum\n";
        last TOTAL_SUM_LOOP;
    }
}
continue
{
    ++$total_sum;
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
