use strict;
use warnings;

my $Limit   = 1_000_000;
my @factors = ( (0) x $Limit );
my $count   = 0;
for my $i ( 2 .. $Limit )
{
    if ( $factors[$i] == 0 )
    {
        # i is prime.
        $count = 0;
        my $val = $i;
        while ( $val < $Limit )
        {
            $factors[$val]++;
            $val += $i;
        }
    }
    elsif ( $factors[$i] == 4 )
    {
        if ( ++$count == 4 )
        {
            print "Found " . ( $i - 3 ) . "\n";
            exit;
        }
    }
    else
    {
        $count = 0;
    }
}
