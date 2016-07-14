use Modern::Perl;

my $numberline = '';

$numberline .= $_ foreach (1 .. 100_000);

my @distances = (0, 10);
sub digit_at
{
    my $index = shift;
    my $domain_index = 0;
    if ($index >= $distances[-1])
    {
        while($index >= $distances[-1])
        {
            my $next_index = scalar @distances;
            my $count = 10**$next_index - 10**($next_index - 1);
            $distances[$next_index] = $count*$next_index + $distances[-1];
        }
        say join(", ", @distances);
        $domain_index = $#distances - 1;
    }
    else
    {
        for my $domain (0 .. @distances)
        {
            last if $distances[$domain] > $index;
            $domain_index = $domain;
        }
    }
    if ($domain_index == 0)
    {
        return $index;
    }
    else
    {
        $index -= $distances[$domain_index];
        my $stride = $domain_index + 1;
        my ($number, $digit) = (int($index / $stride), $index % $stride);
        my $real_number = 10**$domain_index + $number;
        return substr($real_number, $digit, 1);
    }
}

foreach my $base (0 .. (length $numberline) - 1)
{
    my $index = $base + 1;
    my ($left, $right) = (digit_at($index), substr($numberline, $base, 1));
    if ($left ne $right)
    {
        say '          V';
        say substr($numberline, $base - 10, 21);
        die "$index: $left vs. $right" if $left ne $right;
    }
}
