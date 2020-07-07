#!/usr/bin/perl

use strict;
use warnings;
use IO::Handle;

no warnings 'recursion';

use 5.010;

use List::Util qw(sum min);

# use Math::BigInt (":constant", lib => 'GMP');
use integer;

STDOUT->autoflush(1);

my @p;

sub p_k_n
{
    my ( $k, $n ) = @_;

    if ( $k > $n )
    {
        return 0;
    }
    elsif ( $k == $n )
    {
        return 1;
    }
    else
    {
        return ( $p[$n][$k] //=
                ( ( p_k_n( $k + 1, $n ) + p_k_n( $k, $n - $k ) ) % 1_000_000 )
        );
    }
}

my $n = 2;
N_LOOP:
while (1)
{
    my $p = p_k_n( 1, $n );
    print "N = $n ; V = $p\n";
    if ( $p % 1000 == 0 )
    {
        last N_LOOP;
    }
}
continue
{
    $n++;
}

# For % 1,000 == 449
# For % 100 = 74
# For % 10 = 9

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
