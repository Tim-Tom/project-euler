use strict;
use warnings;
my $longest = 0;
while(<>)
{
    chomp;
    if ($longest < length $_)
    {
        print "$_\n";
        $longest = length $_;
    }
}
print "$longest\n";
