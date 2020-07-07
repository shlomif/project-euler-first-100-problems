#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);
use lib '.';
use Euler80 ();

sub square_root_digits_sum
{
    my $n = shift;

    my $result    = Euler80::square_root($n);
    my $first_100 = substr( "$result", 0, 100 );
    return sum( split //, $first_100 );
}

my %squares   = ( map { ( $_ * $_ ) => 1 } ( 1 .. 100 ) );
my $total_sum = 0;

for my $n ( 1 .. 100 )
{
    print "Reached $n\n";
    if ( !exists( $squares{$n} ) )
    {
        $total_sum += square_root_digits_sum($n);
    }
    print "Total sum = $total_sum\n";
}
print $total_sum, "\n";

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
