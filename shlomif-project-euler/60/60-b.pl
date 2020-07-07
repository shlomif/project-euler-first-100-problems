#!/usr/bin/perl

use strict;
use warnings;

use IO::All qw/ io /;

use List::Util      (qw(sum));
use List::MoreUtils (qw(all));

my $limit = 100_000;

my $primes_bitmask = "";
my $primes_list    = "";
my $num_primes     = 0;

if ( !-e "$limit.bitmask" )
{
    my $loop_to = int( sqrt($limit) );

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

    io->file("$limit.bitmask")->binmode(1)->print($primes_bitmask);
    io->file("$limit.list")->binmode(1)->print($primes_list);
}
else
{
    $primes_bitmask = io->file("$limit.bitmask")->binmode(1)->all;
    $primes_list    = io->file("$limit.list")->binmode(1)->all;
    $num_primes     = ( length($primes_list) >> 2 );
}

my $num_to_find = 5;

my @sets      = ( map { +{} } ( 0 .. $num_to_find ) );
my $objective = $sets[$num_to_find];

# Skip 2
for my $i ( 1 .. 10_000 )
{
    # Skip 5
    next if ( $i == 2 );

    if ( $i % 100 == 0 )
    {
        print "Reached $i\n";
    }

    my $new_p = vec( $primes_list, $i, 32 );

    for my $order ( reverse( 2 .. ( $num_to_find - 1 ) ) )
    {
        foreach my $set ( keys( %{ $sets[$order] } ) )
        {
            my @p = split( /,/, $set );
            if (
                all
                {
                    ( !vec( $primes_bitmask, $new_p . $_, 1 ) )
                        && ( !vec( $primes_bitmask, $_ . $new_p, 1 ) )
                }
                @p
                )
            {
                push @p, $new_p;
                $sets[ $order + 1 ]->{ join( ",", @p ) } = sum(@p);
            }
        }
    }

    if ( keys(%$objective) )
    {
        print map { "$_ => $objective->{$_}\n" }
            sort  { $objective->{$a} <=> $objective->{$b} }
            keys(%$objective);
    }

    for my $prev ( 1 .. $i - 1 )
    {
        next if ( $prev == 2 );

        my $p = vec( $primes_list, $prev, 32 );

        if (   ( !vec( $primes_bitmask, $new_p . $p, 1 ) )
            && ( !vec( $primes_bitmask, $p . $new_p, 1 ) ) )
        {
            $sets[2]{"$p,$new_p"} = sum( $p, $new_p );
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
