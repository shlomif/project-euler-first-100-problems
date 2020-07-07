#!/usr/bin/perl

use strict;
use warnings;

use List::Util (qw(sum));

my $limit = 1_000_000;

my $primes_bitmask = "";
my $primes_list    = "";

my $loop_to    = int( sqrt($limit) );
my $num_primes = 0;
for my $p ( 2 .. $loop_to )
{
    if ( vec( $primes_bitmask, $p, 1 ) == 0 )
    {
        vec( $primes_list, $num_primes++, 32 ) = $p;
        my $i = $p + $p;
        while ( $i < $limit )
        {
            vec( $primes_bitmask, $i, 1 ) = 1;
        }
        continue
        {
            $i += $p;
        }
    }
}

for my $p ( $loop_to .. $limit )
{
    if ( vec( $primes_bitmask, $p, 1 ) == 0 )
    {
        vec( $primes_list, $num_primes++, 32 ) = $p;
    }
}
print "$num_primes\n";

my $max_sum;
my $max_count = 21;
for (
    my $start_idx = 0 ;
    $start_idx < $num_primes - $max_count ;
    $start_idx++
    )
{
END_LOOP:
    for (
        my $end_idx = $start_idx + $max_count ;
        $end_idx < $num_primes ;
        $end_idx++
        )
    {
        my $sum = sum( map { vec( $primes_list, $_, 32 ) }
                ( $start_idx .. $end_idx ) );

        if ( $sum > $limit )
        {
            last END_LOOP;
        }
        if ( vec( $primes_bitmask, $sum, 1 ) == 0 )
        {
            $max_count = $end_idx - $start_idx + 1;
            $max_sum   = $sum;
            print "Found MaxCount = $max_count ; MaxSum = $max_sum ;\n";
        }
    }
}

print "Found MaxCount = $max_count ; MaxSum = $max_sum ;\n";

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
