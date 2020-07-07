package main;

use strict;
use warnings;

my @primes = `primesieve -p1 2 10000`;
chomp(@primes);

my @cache;

sub get_combinations
{
    my ( $prefix, $start_from_max_prime_idx, $sum, $out_combinations_ref ) = @_;

    my $combinations = [];

    if ( $sum == 0 )
    {
        push @$combinations, [];
    }
    elsif ( defined( $cache[$sum][$start_from_max_prime_idx] ) )
    {
        $combinations = $cache[$sum][$start_from_max_prime_idx];
    }
    else
    {
    MAX_PRIME:
        foreach my $max_prime_idx ( $start_from_max_prime_idx .. $#primes )
        {
            my $max_prime = $primes[$max_prime_idx];

            if ( $max_prime > $sum )
            {
                last MAX_PRIME;
            }

            get_combinations(
                [$max_prime],      $max_prime_idx,
                $sum - $max_prime, $combinations
            );
        }

        $cache[$sum][$start_from_max_prime_idx] = $combinations;
    }

    push @$out_combinations_ref, ( map { [ @$prefix, @$_ ] } @$combinations );

    return;
}

sub get_num_primes_combinations
{
    my $n = shift;

    my @combinations;

MAX_PRIME:
    foreach my $max_prime_idx ( 0 .. $#primes )
    {
        my $max_prime = $primes[$max_prime_idx];

        if ( $max_prime > $n )
        {
            last MAX_PRIME;
        }
        get_combinations( [$max_prime], $max_prime_idx, $n - $max_prime,
            \@combinations );
    }
    return scalar(@combinations);
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
