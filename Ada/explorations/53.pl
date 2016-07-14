use Modern::Perl;
use English qw(ARRAY_BASE);

#  min := 1;
#  max := N; {array size: var A : array [1..N] of integer}
#  repeat
#    mid := (min+max) div 2;
#    if x > A[mid] then
#      min := mid + 1;
#    else
#      max := mid - 1;
#  until (A[mid] = x) or (min > max);
my $len = 1000;
my $ARRAY_BASE = 1;

for my $position (1 .. $len)
{
    my @nums;
    push(@nums, map {1} 1 .. $position);
    push(@nums, map {0} $position + 1 .. $len);
    my ($min, $max) = (1, $len);
    my $tests = 0;
    while(1)
    {
        my $mid = int(($min + $max) / 2);
        if (!$nums[$mid]) {
            $max = $mid - 1;
        }
        else {
            $min = $mid + 1;
        }
        $tests++;
        last if $min > $max;
    }
    say "$min in $tests tests";
}
