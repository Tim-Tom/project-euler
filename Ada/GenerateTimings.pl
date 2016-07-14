use strict;
use warnings;

sub RunProblem($);

my @problems;
if (@ARGV) {
  @problems = @ARGV;
}
else {
  @problems = sort { $a <=> $b } map {/(\d+)/;$1} <inc/Problem_*.ads>;
}

foreach my $problem (@problems) {
  my $average;
  foreach my $run (1 .. 10) {
    $average += RunProblem($problem);
  }
  $average /= 10.0;
  printf "Problem $problem: %.2f ms\n", $average;
}

sub RunProblem($) {
  my $problem = shift;
  my ($time, ) = grep { /Total elapsed time: \d+ ms/} qx(e:\\Programming\\Scratch\\ProgramTimer\\Release\\ProgramTimer.exe ProjectEuler.exe $problem);
  ($time,) = $time =~ /(\d+)/;
  return $time;
}
