#!/usr/bin/perl

use strict;
use warnings;
no warnings 'recursion';
use integer;

{
    my %c = ( 1 => 0 );

    sub calc_seq_rank
    {
        my ($n) = @_;

        return (
            $c{$n} //= (
                1 + calc_seq_rank( ( $n & 1 ) ? ( $n * 3 + 1 ) : ( $n >> 1 ) )
            )
        );
    }

}

my $max = -1;
my $ret = 0;
foreach my $n ( 2 .. 999_999 )
{
    my $v = calc_seq_rank($n);
    if ( $v > $max )
    {
        $max = $v;
        $ret = $n;
    }
}
print "N = ", $ret, "\n";

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
