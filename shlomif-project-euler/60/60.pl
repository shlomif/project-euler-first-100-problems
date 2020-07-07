#!/usr/bin/perl

use strict;
use warnings;

use List::Util      (qw(sum));
use List::MoreUtils (qw(all));

my $limit = 100_000_000;

my $primes_bitmask = "";
my $primes_list    = "";

my $loop_to    = int( sqrt($limit) );
my $num_primes = 0;
for my $p ( 2 .. $loop_to )
{
    if ( vec( $primes_bitmask, $p, 1 ) == 0 )
    {
        vec( $primes_list, $num_primes++, 32 ) = $p;
        my $i    = $p * $p;
        my $step = +( $p == 2 ) ? 2 : ( $p << 1 );
        while ( $i < $limit )
        {
            vec( $primes_bitmask, $i, 1 ) = 1;
        }
        continue
        {
            $i += $step;
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

my $num_to_find = 5;

sub recurse
{
    my $indexes = shift;
    my $level   = @$indexes;

    my @p = ( map { vec( $primes_list, $_, 32 ) } @$indexes );

    if ( $level == $num_to_find )
    {
        # Let's check.
        print "Found: ", join( ",", @p ), " ; sum == ", sum(@p), "\n";

        return;
    }
    foreach my $idx ( $num_to_find - $level - 1 .. $indexes->[0] - 1 )
    {
        # 2 or 5 should be skipped because they never generate a pair
        if ( ( $idx == 0 ) || ( $idx == 2 ) )
        {
            next;
        }

        my $new_p = vec( $primes_list, $idx, 32 );

        if (
            all
            {
                ( !vec( $primes_bitmask, $new_p . $_, 1 ) )
                    && ( !vec( $primes_bitmask, $_ . $new_p, 1 ) )
            }
            @p
            )
        {
            recurse( [ $idx, @$indexes ] );
        }
    }

    return;
}

foreach my $max_idx ( 6 .. 10_000 )
{
    print "MaxIdx = $max_idx\n";
    recurse( [$max_idx] );
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
