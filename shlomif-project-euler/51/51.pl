#!/usr/bin/perl

use strict;
use warnings;

my $limit = 1_000_000;

my $primes_bitmask = "";

my $loop_to = int( sqrt($limit) );
for my $p ( 2 .. $loop_to )
{
    if ( vec( $primes_bitmask, $p, 1 ) == 0 )
    {
        my $i = $p * $p;
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

NUM_LOOP:
for my $n ( 10 .. $limit )
{
    if ( $n !~ /1/ || $n =~ /1\z/ )
    {
        next NUM_LOOP;
    }
    my @found =
        ( grep { my $m = $n; $m =~ s/1/$_/g; !vec( $primes_bitmask, $m, 1 ) }
            ( 0 .. 9 ) );
    if ( @found >= 8 )
    {
        my $m = $n;
        $m =~ s/1/$found[0]/g;
        if ( $m !~ /\A0/ )
        {
            print "$m\n";
            exit;
        }
    }
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
