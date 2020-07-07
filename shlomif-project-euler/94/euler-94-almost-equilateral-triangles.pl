#!/usr/bin/perl

use strict;
use warnings;

use Math::BigInt lib => "GMP", ":constant";
use IO::Handle;

STDOUT->autoflush(1);

# There are two types of almost-equilateral triangles:
# 1. $n, $n, $n-1
# 2. $n, $n, $n+1

# For No. 1 we need a triangle for whose ($n-1) * sqrt($n^2 - (($n-1)/2)^2) is
# integral.
#
# For No. 2 we need a triangle for whose ($n+1) * sqrt($n^2 - (($n+1)/2)^2) is
# integral.
#

# For No. 1, for "n" we need s = (3n-1)/2
# area = sqrt{ (3n-1) / 2 * (n-1) / 2 * (n-1) / 2 * (n+1) / 2 }
#      = 1/4 * (n-1) * sqrt { (3n-1)(n+1) }

# Let's do m = n+1, then we get 1/4 * (m-2) * sqrt { (3m-4)m }

# For No. 2, for "n" we need s = (3n+1)/2
# area = sqrt{ (3n+1) /2 * (n+1) / 2 * (n+1) / 2 * (n-1) / 2 }
#      = 1/4 * (n+1) * sqrt { (3n+1)(n-1) }

=begin Hello

foreach my $n (1 .. 1_000_000_000)
{
    my $v = sqrt((3*$n+1)*($n-1));

    if (int($v) == $v)
    {
        print "$n\n";
    }
}

See:

http://www.research.att.com/~njas/sequences/?q=1%2C5%2C65%2C901%2C12545&sort=0&fmt=0&language=english&go=Search

http://www.research.att.com/~njas/sequences/?q=1%2C17%2C241%2C3361%2C46817%2C652081&sort=0&fmt=0&language=english&go=Search

=end Hello

=cut

my $sum = 0;
for my $n1 (
    split( /,\s*/, q{17, 241, 3361, 46817, 652081, 9082321, 126500417} ) )
{
    print "$sum\n";
    $sum += Math::BigInt->new($n1) * 3 - 1;
}

for my $n2 ( split( /,\s*/, q{5, 65, 901, 12545, 174725, 2433601, 33895685} ) )
{
    print "$sum\n";
    $sum += Math::BigInt->new($n2) * 3 + 1;
}

print "$sum\n";

#    my $v = (($n-1) * sqrt($n**2 - (($n-1)/2)**2));
#    if (int($v) == $v)
#    {
#        print $n, "\n";
#    }

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
