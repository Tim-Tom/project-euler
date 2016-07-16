use strict;
use warnings;

my ($cmd, $max) = @ARGV;

for my $i (1 .. $max) {
    system($cmd, $i);
}
