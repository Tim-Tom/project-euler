use strict;
use warnings;

use Time::HiRes qw(gettimeofday tv_interval);

use v5.16;

my ($cmd, $max) = @ARGV;

for my $i (1 .. $max) {
    my $time = [gettimeofday];
    system qq('$cmd' '$i' >/dev/null 2>/dev/null);
    my $elapsed = tv_interval($time, [gettimeofday]);
    say "$i: $elapsed";
}
