#!/usr/bin/perl

use strict;
use warnings;

use Math::BigInt try => "GMP";

my $size = shift(@ARGV) or die "usage: $^X $0 1000000";

my @counts = ( 0, 0, ( 1 .. $size - 1 ) );

my $sum       = 0;
my $total_sum = Math::BigInt->new("0");

my $l = int( $size / 2 );
foreach my $d ( 2 .. $l )
{
    print "d=$d\n" if ( $d % 1_000 == 0 );
    foreach my $m ( 2 .. int( $size / $d ) )
    {
        $counts[ $d * $m ] -= $counts[$d];
    }
    if ( ( $sum += $counts[$d] ) > 1_000_000_000 )
    {
        $total_sum += $sum;
        $sum = 0;
    }
}

foreach my $d ( $l + 1 .. $size )
{
    print "d=$d\n" if ( $d % 1_000 == 0 );
    if ( ( $sum += $counts[$d] ) > 1_000_000_000 )
    {
        $total_sum += $sum;
        $sum = 0;
    }
}
$total_sum += $sum;
$sum = 0;

print "total = $total_sum\n";

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
