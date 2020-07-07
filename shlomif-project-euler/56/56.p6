# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

my $max = 0;
for 2 .. 99 -> $a
{
    my $aa = $a;
    for 1 .. 99 -> $b
    {
        my $s = [+] "$aa".comb();
        if $s > $max
        {
            $max = $s;
        }
        $aa *= $a;
    }
}
say $max;
