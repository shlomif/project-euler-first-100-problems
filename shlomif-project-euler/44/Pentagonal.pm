package Pentagonal;

use strict;
use warnings;

use Math::BigInt ":constant", lib => "GMP";

use base 'Exporter';

our @EXPORT = (qw(is_pentagonal));

sub new
{
    my $class = shift;
    my $self  = { 'i' => 1, 'n' => 1 };
    bless $self, $class;
    return $self;
}

sub from_i
{
    my $class = shift;
    my $i     = shift;
    my $n     = ( ( $i * ( 3 * $i - 1 ) ) / 2 );
    my $self  = { i => $i, n => $n };
    bless $self, $class;
    return $self;
}

sub inc
{
    my $self = shift;

    my $new = Pentagonal->new();

    $new->{i} = $self->{i} + 1;

    $new->{n} = $self->{n} + $self->{i} * 3 + 1;

    return $new;
}

sub register
{
    my ( $self, $hash_ref ) = @_;

    $hash_ref->{ $self->{n}->bstr() } = $self->{i}->bstr();
}

my $pent_max = Pentagonal->new();
my %pents_map;
$pent_max->register( \%pents_map );

sub is_pentagonal
{
    my $num = shift;

    while ( $num > $pent_max->{n} )
    {
        # Advance both pent_max and pent_max_idx
        $pent_max = $pent_max->inc();
        $pent_max->register( \%pents_map );
    }
    return exists( $pents_map{ $num->bstr() } );
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
