#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);

my $max;

sub process_combination
{
    my ( $c, $allocated ) = @_;

    # print join(",", @$c), "\n";

    my @gon = ( [ @{$c}[ 5, 0, 1 ] ] );

    my $sum = sum( @{ $gon[0] } );

    foreach my $idx ( 1 .. 4 )
    {
        my @n     = @{$c}[ $idx, ( $idx + 1 ) % 5 ];
        my $outer = $sum - sum(@n);

        if ( ( $outer <= 0 ) or exists( $allocated->{$outer} ) )
        {
            return;
        }
        $allocated->{$outer} = 1;
        push @gon, [ $outer, @n ];
    }

    my ($idx) = sort { $gon[$a][0] <=> $gon[$b][0] } ( 0 .. 4 );

    my $string =
        join( "", map { @$_ } @gon[ map { ( $idx + $_ ) % 5 } ( 0 .. 4 ) ] );

    if ( length($string) == 16 )
    {
        $max ||= $string;

        if ( $string gt $max )
        {
            $max = $string;
            print "New Max $max\n";
        }
    }
}

sub create_combination
{
    my ( $num_left, $combination, $allocated_numbers ) = @_;

    if ( $num_left == 0 )
    {
        process_combination( $combination, $allocated_numbers );
    }
    else
    {
        foreach my $next_num ( grep { !exists( $allocated_numbers->{$_} ) }
            1 .. 10 )
        {
            create_combination(
                $num_left - 1,
                [ @$combination, $next_num ],
                { %{$allocated_numbers}, $next_num => 1 },
            );
        }
    }
}

create_combination( 6, [], {} );

print "Max == $max\n";

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
