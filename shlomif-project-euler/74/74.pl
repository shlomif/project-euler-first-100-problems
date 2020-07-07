#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(reduce);
use Math::GMP;

my @factorials = (1);
while ( $#factorials != 9 )
{
    push @factorials, Math::GMP->new( $factorials[-1] * @factorials );
}

# print join(",", @factorials), "\n";

my @num_chains;

my %cache = ();

sub find_for_n
{
    my ( $n, $pos, $c ) = @_;

    my $n_str = $n . "";

    if ( exists( $c->{$n_str} ) )
    {
        # It's a loop.
        return [ 0, $c->{$n_str} ];
    }
    elsif ( exists( $cache{$n_str} ) )
    {
        return [ $cache{$n_str}, $pos ];
    }
    else
    {
        my ( $ret, $recurse_pos ) = @{
            find_for_n(
                ( reduce { $a + $b } @factorials[ split //, $n_str ] ),
                $pos + 1, { %{$c}, $n_str => $pos },
            )
        };

        if ( !exists( $cache{$n_str} ) )
        {
            $cache{$n_str} = $ret + 1;
        }
        return [ $ret + 1, $pos ];
    }
}

foreach my $n ( 1 .. 999_999 )
{
    if ( $n % 10_000 == 0 )
    {
        print "N = $n \n";

        foreach my $i ( 0 .. $#num_chains )
        {
            if ( defined( $num_chains[$i] ) )
            {
                print "num_chains[$i] = $num_chains[$i]\n";
            }
        }
        print "N = $n \n";
    }

    # print "$n = " , $c{$i . ""} . "\n";
    $num_chains[ find_for_n( $n, 0, {} )->[0] ]++;
}

foreach my $i ( 0 .. $#num_chains )
{
    if ( defined( $num_chains[$i] ) )
    {
        print "num_chains[$i] = $num_chains[$i]\n";
    }
}

1;

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
