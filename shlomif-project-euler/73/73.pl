#!/usr/bin/perl

use strict;
use warnings;

use POSIX qw(floor ceil);

my ( $size, $l_n, $l_d, $u_n, $u_d ) = ( 12000, 1, 3, 1, 2 );

my @masks = ( undef, undef, map { "" } ( 2 .. $size ) );

my $sum = 0;

my $l = int( $size / 2 );
foreach my $d ( 2 .. $l )
{
    print "d=$d\n" if ( $d % 1_000 == 0 );
    foreach my $m ( 2 .. int( $size / $d ) )
    {
        my $bits = \$masks[ $d * $m ];
        foreach my $i ( 1 .. $d - 1 )
        {
            vec( $$bits, $i * $m, 1 ) = 1;
        }
    }
    my $bits = \$masks[$d];
    foreach
        my $i ( ceil( ( $d * $l_n ) / $l_d ) .. floor( ( $d * $u_n ) / $u_d ) )
    {
        if ( !vec( $$bits, $i, 1 ) )
        {
            $sum++;
        }
    }
}

foreach my $d ( $l + 1 .. $size )
{
    print "d=$d\n" if ( $d % 1_000 == 0 );
    my $bits = \$masks[$d];
    foreach
        my $i ( ceil( ( $d * $l_n ) / $l_d ) .. floor( ( $d * $u_n ) / $u_d ) )
    {
        if ( !vec( $$bits, $i, 1 ) )
        {
            $sum++;
        }
    }

}

print "tot = ", $sum - 2, "\n";

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
