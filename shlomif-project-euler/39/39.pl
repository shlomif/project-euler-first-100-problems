#!/usr/bin/perl

use strict;
use warnings;

my %p_counts;

for my $bb ( 2 .. 500 )
{
A_LOOP:
    for my $aa ( 1 .. $bb )
    {
        my $sq = $bb * $bb + $aa * $aa;
        my $cc = int( sqrt($sq) );
        my $p  = $aa + $bb + $cc;
        if ( $p >= 1000 )
        {
            last A_LOOP;
        }
        elsif ( $cc * $cc == $sq )
        {
            $p_counts{$p}++;
        }
    }
}

print map { "$_ => $p_counts{$_}\n" }
    sort { $p_counts{$a} <=> $p_counts{$b} } keys(%p_counts);

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
