use strict;
use warnings;

use 5.016;

use List::Util qw(sum);
use List::MoreUtils qw(any);

my @divisors_sums;
$divisors_sums[1] = 0;

my $MAX = 28_123;
foreach my $div ( 1 .. ( $MAX >> 1 ) )
{
    my $prod = ( $div << 1 );
    while ( $prod <= $MAX )
    {
        $divisors_sums[$prod] += $div;
    }
    continue
    {
        $prod += $div;
    }
}

# Memoized.
#
my $is_abundant_sum = '';

my @abundants;
foreach my $num ( 1 .. $MAX )
{
    if ( $divisors_sums[$num] > $num )
    {
        push @abundants, $num;
        foreach my $i (@abundants)
        {
            vec( $is_abundant_sum, $i + $num, 1 ) = 1;
        }
    }
}

say "Sum == ", sum( grep { !vec( $is_abundant_sum, $_, 1 ) } ( 1 .. $MAX ) );

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
