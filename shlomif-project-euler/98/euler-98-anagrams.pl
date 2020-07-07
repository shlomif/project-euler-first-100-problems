#!/usr/bin/perl

use strict;
use warnings;

use IO::All;

use Math::BigInt lib => 'GMP';
use List::Util qw(first max);
use List::MoreUtils qw(all any uniq notall);

require 5.010;

my @words = ( scalar( io->file("../words.txt")->slurp() ) =~ m{"([A-Z]+)"}g );

my %by_code;

foreach my $w (@words)
{
    my $code = join "", sort { $a cmp $b } split //, $w;
    push @{ $by_code{$code} }, $w;
}

sub iterate
{
    my ( $num_left, $vector, $so_far, $callback ) = @_;

    if ( $num_left == 0 )
    {
        $callback->($vector);
        return;
    }
    else
    {
        foreach my $next_digit ( grep { !exists( $so_far->{$_} ) } 0 .. 9 )
        {
            iterate(
                $num_left - 1,
                [ @$vector, $next_digit ],
                +{ %$so_far, $next_digit => 1 }, $callback
            );
        }
    }
}

sub is_square
{
    my $n = shift;

    my $root = int( $n->copy->bsqrt() );

    return ( $root * $root == $n );
}

# 1*1 = 1 ; 2*2 = 4; 3*3 = 9; 4*4 = 6; 5*5= 5; 6*6 = 6; 7*7 = 9; 8*8 = 4; 9*9=1;

my %which_squares_end_with_map = (
    1 => {},
    2 => {},
    3 => {},
);

foreach my $n ( 0 .. 999 )
{
    foreach my $num_digits ( 1 .. 3 )
    {
        $which_squares_end_with_map{$num_digits}
            { ( $n * $n % ( 10**$num_digits ) ) }++;
    }
}

my @first_three_digits_list =

    (
    map      { [ reverse split //, $_ ] }
        grep { !/(\d).*\1/ }
        map  { sprintf( "%03d", $_ ) }
        sort { $a <=> $b }
        keys( %{ $which_squares_end_with_map{3} } )
    );

my $max_n = 0;

foreach my $list ( grep { ( @{$_} >= 2 ) && ( length( $_->[0] ) >= 3 ) }
    values(%by_code) )
{
    print "Doing " . join( ",", @$list ) . "\n";
    my @keys = ( map { [ reverse split //, $_ ] } @$list );
    my %letters_to_indices;
    my $next_index = 0;
    my @index_keys = (
        map {
            [ map { $letters_to_indices{$_} //= ( $next_index++ ) } @$_ ]
        } @keys
    );

    my @reverse;

    foreach my $key_idx ( 0 .. 1 )
    {
        foreach my $letter_idx ( 0 .. $#{ $index_keys[$key_idx] } )
        {
            push @{ $reverse[ $index_keys[$key_idx][$letter_idx] ] },
                [ $key_idx, $letter_idx ];
        }
    }

    foreach my $first_three (@first_three_digits_list)
    {
    ANAGRAM:
        foreach my $anagram_first_three (@first_three_digits_list)
        {
            my @assignment = ( [@$first_three], [@$anagram_first_three] );

=begin commented

            if (notall { 1 == uniq
                    grep { defined($_) }
                    map { $assignment[$_->[0][$_->[1]] }
                    } @reverse[
                        @index_keys[0][0 .. $#$first_three ],
                        @index_keys[1][0 .. $#anagram_first_three ],
                    ]
            )
            {
                next ANAGRAM;
            }
=end commented

=cut

            my %m;

            foreach my $word_idx ( 0 .. 1 )
            {
                foreach my $letter_idx ( 0 .. $#{ $assignment[$word_idx] } )
                {
                    my $v = $assignment[$word_idx][$letter_idx];
                    my $k = $index_keys[$word_idx][$letter_idx];

                    if ( !exists( $m{$k} ) )
                    {
                        $m{$k} = $v;
                    }
                    elsif ( $m{$k} ne $v )
                    {
                        next ANAGRAM;
                    }
                }
            }

            if ( scalar( uniq values(%m) ) != scalar( keys(%m) ) )
            {
                next ANAGRAM;
            }

            my $iterate;

            $iterate = sub {
                my $map = shift;

                my $next_n = first { !exists( $map->{$_} ) }
                ( 0 .. $next_index - 1 );

                if ( defined($next_n) )
                {
                    my %r = reverse(%$map);
                    foreach my $digit ( grep { !exists( $r{$_} ) } ( 0 .. 9 ) )
                    {
                        $iterate->( { %$map, $next_n => $digit, } );
                    }
                }
                else
                {
                    my @digits = @{$map}{ 0 .. 9 };

                    if (   $digits[ $index_keys[0][-1] ]
                        && $digits[ $index_keys[1][-1] ] )
                    {
                        my @n = (
                            map {
                                Math::BigInt->new( join "",
                                    reverse @digits[@$_] )
                            } @index_keys
                        );

                        # print "Checking @n\n";
                        if ( all { is_square($_) } @n )
                        {
                            if ( $n[0] > $max_n )
                            {
                                $max_n = $n[0];
                                print "Max N = $max_n\n";
                            }
                            if ( $n[1] > $max_n )
                            {
                                $max_n = $n[1];
                                print "Max N = $max_n\n";
                            }
                        }
                    }

                    return;
                }
            };

            $iterate->( \%m );
        }
    }
}

print "Max = $max_n\n";

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
