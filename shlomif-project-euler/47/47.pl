use strict;
use warnings;

use List::MoreUtils (qw(all));

my %Cache = ( 1 => 0 );

sub num_distinct_factors_helper
{
    my ( $n, $start_from ) = @_;

    if ( not exists( $Cache{$n} ) )
    {
        my $d = $n;
        while ( $d % $start_from )
        {
            $start_from++;
        }
        while ( $d % $start_from == 0 )
        {
            $d /= $start_from;
        }
        $Cache{$n} = 1 + num_distinct_factors_helper( $d, $start_from + 1 );
    }
    return $Cache{$n};
}

sub num_distinct_factors
{
    return num_distinct_factors_helper( $_[0], 2 );
}

for my $n ( 14 .. 100_000 )
{
    print "$n\n" if ( $n % 1000 == 0 );
    if ( all { num_distinct_factors($_) >= 4 } ( $n .. $n + 2 ) )
    {
        print "n = $n\n";
        exit;
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
