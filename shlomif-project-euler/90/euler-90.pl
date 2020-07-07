#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw/ sum /;
use List::MoreUtils ();

my $max_digit = 9;

my $loop_limit = $max_digit - 6;

my %die_combs = (
    1 => [qw(0 1 2 3 4 5 6 7 8 9)],
    2 => [qw(1 0 2 3 4 5 6 7 8 9)],
);

my @digits_map = (qw(0 1 2 3 4 5 69 7 8 96));

my %found = ();

sub get_regex
{
    my ( $die_num, $indices ) = @_;

    return '['
        . join( "",
        sort { $a cmp $b } @digits_map[ @{ $die_combs{$die_num} }[@$indices] ] )
        . ']';
}

sub recurse_die1
{
    my ($indices) = @_;

    if ( @$indices == 6 )
    {
        return recurse_die2( get_regex( 1, $indices ), [0] );
    }

    foreach my $next_idx ( $indices->[-1] + 1 .. ( $loop_limit + @$indices ) )
    {
        recurse_die1( [ @$indices, $next_idx ] );
    }

    return;
}

sub recurse_die2
{
    my ( $reg_comp1, $indices ) = @_;

    if ( @$indices == 6 )
    {
        my $reg_comp2 = get_regex( 2, $indices );

        my $re = qr/\A(?:$reg_comp1$reg_comp2)|(?:$reg_comp2$reg_comp1)\z/;

        if ( List::MoreUtils::all { /$re/ } qw(01 04 09 16 25 36 49 64 81) )
        {
            $found{ join( "", sort { $a cmp $b } ( $reg_comp1, $reg_comp2 ) )
            }++;
        }
        return;
    }

    foreach my $next_idx ( $indices->[-1] + 1 .. ( $loop_limit + @$indices ) )
    {
        recurse_die2( $reg_comp1, [ @$indices, $next_idx ] );
    }

    return;
}

recurse_die1( [0] );

print map { "$_\n" } keys(%found);
print sum( values(%found) ), "\n";

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
