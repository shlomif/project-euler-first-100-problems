#!/usr/bin/perl

use strict;
use warnings;

use integer;
use IO::Handle;

use Data::Dumper;

use List::Util qw(reduce sum);
STDOUT->autoflush(1);

my @Cache = ( undef, [] );

sub factorize_helper
{
    my ( $n, $start_from ) = @_;

    my $limit = int( sqrt($n) );

    if ( !defined( $Cache[$n] ) )
    {
        my $d = $n;
        while ( $d % $start_from )
        {
            if ( ++$start_from > $limit )
            {
                return $Cache[$n] = [ [ $n, 1 ] ];
            }
        }

        $d /= $start_from;

        my @n_factors =
            ( map { [@$_] } @{ factorize_helper( $d, $start_from ) } );

        if ( @n_factors && $n_factors[0][0] == $start_from )
        {
            $n_factors[0][1]++;
        }
        else
        {
            unshift @n_factors, ( [ $start_from, 1 ] );
        }

        $Cache[$n] = \@n_factors;
    }
    return $Cache[$n];
}

sub factorize
{
    my ($n) = @_;
    return factorize_helper( $n, 2 );
}

use vars qw($a $b);

sub next_amicable
{
    my $n = shift;

    my $factors = factorize($n);

    return (
        reduce { $a * $b }
        map {
            my ( $base, $e ) = @$_;
            sum( map { $base**$_ } ( 0 .. $e ) )
        } @$factors
    ) - $n;
}

print "next_amicable(28) = ",  next_amicable(28),  "\n";
print "next_amicable(220) = ", next_amicable(220), "\n";
print "next_amicable(284) = ", next_amicable(284), "\n";

my $found_n;
my $found_chain_len = 0;
N_LOOP:
for my $n ( 2 .. 1_000_000 )
{
    if ( ( $n & ( 16 * 1024 - 1 ) ) == 0 )
    {
        print "Reached $n\n";
    }

    # print "Checking $n\n";
    my $chain_len = 1;
    my $m         = $n;

    my %found = ( $n => 1 );

    while ( ( $m = next_amicable($m) ) != 1 )
    {
        $chain_len++;
        if ( ( $m > 1_000_000 ) || ( $m < $n ) )
        {
            next N_LOOP;
        }
        if ( $m == $n )
        {
            if ( $chain_len > $found_chain_len )
            {
                $found_chain_len = $chain_len;
                $found_n         = $n;
                print "Found [$found_n] with Chain len $found_chain_len\n";
            }
            next N_LOOP;
        }
        elsif ( $found{$m} )
        {
            next N_LOOP;
        }
    }
    continue
    {
        $found{$m} = 1;
    }

}
print "Final: Found [$found_n] with Chain len $found_chain_len\n";

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
