#!/usr/bin/perl

use strict;
use warnings;

my $max = -1;
INT_LOOP:
for my $int ( 9, 91 .. 99, 911 .. 999, 9111 .. 9999 )
{

    if ( $int =~ /0/ )
    {
        next INT_LOOP;
    }

    my $n   = 1;
    my $pan = "";
    while ( length($pan) < 9 )
    {
        $pan .= $int * $n++;
    }
    if ( length($pan) == 9 )
    {
        if ( join( "", sort { $a <=> $b } split( //, $pan ) ) eq "123456789" )
        {
            # $pan is a pan-digital number.
            if ( $pan > $max )
            {
                $max = $pan;
            }
        }
    }
}
print "max = $max\n";

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
