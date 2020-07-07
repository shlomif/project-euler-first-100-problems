#!/usr/bin/perl

use strict;
use warnings;

use Math::BigInt;
use Math::BigRat;

my %h = ();

foreach my $numer ( 11 .. 99 )
{
    if ( $numer % 10 == 0 )
    {
        next;
    }

    foreach my $denom ( ( $numer + 1 ) .. 99 )
    {
        my $get_my = sub {
            my $digit = shift;
            my ( $n, $d ) = ( $numer, $denom );
            if (   ( $d =~ s{$digit}{} )
                && ( $n =~ s{$digit}{} )
                && ( $d * $numer == $n * $denom ) )
            {
                return ( $n, $d );
            }
            else
            {
                return ();
            }
        };

        foreach my $digit ( $numer % 10, int( $numer / 10 ) )
        {
            if ( my ( $n, $d ) = $get_my->($digit) )
            {
                my $gcd = Math::BigInt::bgcd( $n, $d );
                $n /= "$gcd";
                $d /= "$gcd";

                print "$n/$d\n";
                $h{"$n/$d"}++;
            }
        }
    }
}

print "Results == ", ( join ' , ', keys(%h) ), "\n";

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
