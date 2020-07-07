#!/usr/bin/perl

use strict;
use warnings;

my $size = shift(@ARGV)
    or die "usage: perl 70.pl 10000000";

my $counts = "";

foreach my $i ( 2 .. $size - 1 )
{
    vec( $counts, $i, 32 ) = $i - 1;
}
print "Initialized Array\n";

my $min_n;
my $min_expr = 1_000_000;

sub token
{
    return join( "", sort { $a cmp $b } split //, shift() );
}

my $l = int( $size / 2 );
foreach my $d ( 2 .. $l )
{
    print "d=$d\n" if not $d & 0b111111111111;
    my $totient = vec( $counts, $d, 32 );
    for ( my $m = ( $d << 1 ) ; $m < $size ; $m += $d )
    {
        vec( $counts, $m, 32 ) -= $totient;
    }

    if ( token($totient) eq token($d) )
    {
        my $to_check = $d / $totient;
        if ( $to_check < $min_expr )
        {
            $min_n    = $d;
            $min_expr = $to_check;
            print "Min[n] = $min_n ; Min[expr] = $min_expr\n";
        }
    }
}

foreach my $d ( $l + 1 .. $size )
{
    print "d=$d\n" if not $d & 0b111111111111;
    my $totient = vec( $counts, $d, 32 );

    if ( token($totient) eq token($d) )
    {
        my $to_check = $d / $totient;
        if ( $to_check < $min_expr )
        {
            $min_n    = $d;
            $min_expr = $to_check;
            print "Min[n] = $min_n ; Min[expr] = $min_expr\n";
        }
    }
}

print "Min[n] = $min_n ; Min[expr] = $min_expr\n";

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
