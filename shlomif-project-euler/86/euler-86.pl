#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(min);

# my %distance_squares = ();
my $count = 0;
my $M     = 1;
while (1)
{
    for my $N ( 1 .. $M )
    {
        for my $L ( 1 .. $N )
        {
            # my @arr = ($M,$N,$L);
            # my $get_dist = sub {
            #     my $idx = shift;
            #     my $x = $arr[$idx];
            #     my $t = $arr[($idx+1)%3] + $arr[($idx+2)%3];
            #     return ($x*$x+$t*$t);
            # };
            # print join(',',map { $get_dist->($_) } (0 .. $#arr)), "\n";
            # my $dist_sq = min(map { $get_dist->($_) } (0 .. $#arr));
            my $dist_sq = $M * $M + ( $N + $L )**2;
            my $dist    = sqrt($dist_sq);
            if ( int($dist) == $dist )
            {
                $count++;
            }

            # $distance_squares{$dist_sq} = 1;
        }
    }
}
continue
{
    print "Checked M=$M Count=$count\n";
    if ( $M == 99 )
    {
        if ( $count != 1975 )
        {
            die "Number of solutions for M == 99 is wrong.";
        }
    }
    else
    {
        if ( $count > 1_000_000 )
        {
            print "Final[M] = $M\n";
            exit(0);
        }
    }
    $M++;
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
