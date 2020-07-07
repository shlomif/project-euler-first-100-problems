#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min);

use IO::All;

my @lines = io("matrix.txt")->chomp->getlines();

my @matrix = (
    map {
        [ map { +{ v => $_ } } ( split( /,/, $_ ) ) ]
    } @lines
);

my $size = 80;
my $lim  = $size - 1;

foreach my $y ( 0 .. $lim )
{
    $matrix[$y][0]->{sum} = $matrix[$y][0]->{v};
}

sub calc_sum
{
    my ( $y, $x ) = @_;

    my @sums;

    if ( $y > 0 && exists( $matrix[ $y - 1 ][$x]->{sum} ) )
    {
        push @sums, $matrix[ $y - 1 ][$x]->{sum} + $matrix[$y][$x]->{v};
    }

    if ( $y < $lim && exists( $matrix[ $y + 1 ][$x]->{sum} ) )
    {
        push @sums, $matrix[ $y + 1 ][$x]->{sum} + $matrix[$y][$x]->{v};
    }

    push @sums, $matrix[$y][ $x - 1 ]->{sum} + $matrix[$y][$x]->{v};

    my $min = min(@sums);

    if (   ( !exists( $matrix[$y][$x]->{sum} ) )
        || ( $min < $matrix[$y][$x]->{sum} ) )
    {
        $matrix[$y][$x]->{sum} = $min;
        return 1;
    }
    else
    {
        return;
    }
}

for my $x ( 1 .. $lim )
{
    print "Reached $x\n";
    my $changed = 1;
    while ($changed)
    {
        $changed = 0;

        for my $y ( 0 .. $lim )
        {
            $changed ||= calc_sum( $y, $x );
        }
    }
}

print "Sum = ", min( map { $matrix[$_][$lim]->{sum} } ( 0 .. $lim ) ), "\n";

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
