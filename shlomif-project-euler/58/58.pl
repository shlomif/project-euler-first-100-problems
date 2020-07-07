#!/usr/bin/perl

use strict;
use warnings;

open my $primes_fh, '-|', 'primesieve', '-p1', '2', '1' . '0' x 18;
my $count10 = 0;
my $total   = 1;
my $n       = 1;
my $len     = 2;

my $last_prime = <$primes_fh>;
chomp($last_prime);
while (1)
{
    # We can exclude the squares
    for my $i ( 1 .. 3 )
    {
        $n += $len;

        while ( $last_prime < $n )
        {
            $last_prime = <$primes_fh>;
            chomp($last_prime);
        }
        if ( $last_prime == $n )
        {
            $count10 += 10;
        }
    }
    $n     += $len;
    $total += 4;

    if ( $count10 < $total )
    {
        print "Len = ", $len + 1, "\n";
        print "N = ", $n, "\n";
        exit;
    }
}
continue
{
    $len += 2;
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
