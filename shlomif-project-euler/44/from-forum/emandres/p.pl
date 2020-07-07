#!/usr/bin/perl

use strict;
use warnings;

sub pent
{
    my $x = shift;

    return ( ( $x * ( 3 * $x - 1 ) ) >> 1 );
}

sub is_pent
{
    my $x = shift;

    my $f = ( .5 + sqrt( .25 + 6 * $x ) ) / 3;
    return ( $f == int($f) );
}

for my $i ( 1 .. 3000 )
{
    for my $j ( $i + 1 .. 3000 )
    {
        if ( is_pent( pent($j) - pent($i) ) && is_pent( pent($j) + pent($i) ) )
        {
            print "answer = ", pent($j) - pent($i), "\n";
            exit(0);
        }
    }
}

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
