#!/usr/bin/perl

use strict;
use warnings;

use IO::All qw/ io /;
use List::Util qw(sum);

sub is_triangle
{
    my $n = shift() * 2;

    my $i = int( sqrt($n) );

    if ( $i * $i == $n )
    {
        return 0;
    }
    else
    {
        return ( $n == $i * ( $i + 1 ) );
    }
}

my $text = io->file("./words.txt")->all();

my @words = ( $text =~ m{([A-Z]+)}g );
print scalar(
    grep {
        is_triangle( sum( map { ord($_) - ord('A') + 1 } split //, $_ ) )
    } @words
    ),
    "\n";

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