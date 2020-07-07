#!/usr/bin/perl

use strict;
use warnings;

use Math::BigInt try => "GMP";
use Math::BigRat try => "GMP";

sub find_numerator
{
    my $d = shift;

    if ( $d % 7 == 0 )
    {
        return;
    }

    my $n = int( ( $d * 3 ) / 7 );

    if ( Math::BigInt::bgcd( $n, $d ) != 1 )
    {
        return;
    }
    else
    {
        return $n;
    }
}

sub find_rat
{
    my $d = shift;
    my $n = find_numerator($d);

    if ( !defined($n) )
    {
        return;
    }
    else
    {
        return Math::BigRat->new("$n/$d");
    }
}

my $top    = Math::BigRat->new('3/7');
my $d      = 1_000_000;
my $bottom = find_rat($d);

for ( ; $d >= 7 ; $d-- )
{
    if ( $d % 10_000 == 0 )
    {
        print "d=$d\n";
    }
    my $to_check = find_rat($d);

    if ( $to_check && ( $to_check > $bottom ) )
    {
        $bottom = $to_check;
        print "New bottom - $bottom (d=$d)\n";
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
