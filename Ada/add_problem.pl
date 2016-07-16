use strict;
use warnings;

use v5.14;

my $max = $ARGV[0] // die;

foreach my $number (1 .. $max)
{
    my $padded = sprintf('%02d', $number);
    unless(-f "inc/Problem_${padded}.ads")
    {
        open(my $spec, '>', "inc/Problem_${padded}.ads") or die;
        print $spec <<"END_SPEC";
package Problem_${padded} is
   procedure Solve;
end Problem_${padded};
END_SPEC
    }
    unless (-f "src/Problem_${padded}.adb")
    {
        open(my $body, '>', "src/Problem_${padded}.adb") or die;
        print $body <<"END_BODY";
with Ada.Text_IO;
package body Problem_${padded} is
   package IO renames Ada.Text_IO;
   procedure Solve is
   begin
      IO.Put_Line("The Answer");
   end Solve;
end Problem_${padded};
END_BODY
    }
}

open(my $main, '>', "src/ProjectEuler.adb") or die;
print $main <<END_INCLUDES;
with Ada.Text_IO;
with Ada.Command_Line;
END_INCLUDES
for my $n (1 .. $max)
{
    my $padded = sprintf('%02d', $n);
    print $main "with Problem_${padded};\n";
}
print $main <<END_START_METHOD;
procedure ProjectEuler is
   package IO renames Ada.Text_IO;
   choice : constant String := Ada.Command_Line.Argument(1);
begin
   if choice = "1" then
      IO.Put("01: "); Problem_01.Solve;
END_START_METHOD
for my $n (2 .. $max)
{
    my $padded = sprintf('%02d', $n);
    print $main qq(   elsif choice = "$n" then\n      IO.Put("$padded: "); Problem_${padded}.Solve;\n);
}
print $main <<END_END_METHOD;
   else
      IO.Put_Line("Unknown choice: " & choice);
   end if;
end ProjectEuler;
END_END_METHOD
