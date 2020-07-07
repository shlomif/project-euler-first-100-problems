#!/usr/bin/perl

use strict;
use warnings;
use 5.014;
use List::Util qw/ notall /;

my @l = `primesieve -p1 2 999999`;
chomp @l;
my $primes = '';
vec( $primes, $_, 1 ) = 1 for @l;

sub p
{
    my ($n) = @_;

    return vec( $primes, $n, 1 ) if $n < 1e7;

    my $top = int( sqrt($n) );

    for my $i (@l)
    {
        if ( $n % $i == 0 )
        {
            return 0;
        }
        return 1 if $i > $top;
    }

    return 1;
}

sub pp
{
    my $p = shift;
    return notall { p( $p . $_ ) and p( $_ . $p ) } @_;
}

for my $xx ( 4 .. $#l )
{
    my $x = $l[$xx];
    say "Reached $x";
    my @m = grep { !pp( $x, $_ ) } @l[ 1 .. $xx - 1 ];
    foreach my $yy ( 0 .. $#m )
    {
        my $y = $m[$yy];
        my @n = grep { !pp( $y, $_ ) } @m[ $yy + 1 .. $#m ];
        foreach my $zz ( 0 .. $#n )
        {
            my $z = $n[$zz];
            foreach my $ww ( $zz + 1 .. $#n )
            {
                my $w = $n[$ww];
                next if pp( $w, $z );
                foreach my $tt ( $ww + 1 .. $#n )
                {
                    my $t = $n[$tt];
                    next
                        if pp( $t, $z, $w );
                    say $w + $t + $x + $y + $z;
                    exit;
                }
            }
        }
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
