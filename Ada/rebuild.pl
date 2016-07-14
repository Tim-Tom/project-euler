use strict;
use warnings;

use FileHandle;

my $input = FileHandle->new('src/ProjectEuler.adb', 'r') or die "Unable to open file 'src/ProjectEuler.adb' for read: $!";

my $output;
my $problem = 'unknown';
while(<$input>)
{
    if (/[pP]rocedure\s+(Problem_\d+)/)
    {
        $problem = $1;
        my $spec = FileHandle->new("inc/${problem}.ads", 'w') or die "Unable to open file 'inc/${problem}.ads' for write: $!";
        print $spec <<"END_SPEC";
package $problem is
   procedure $problem;
end $problem;
END_SPEC
        close $spec;
        $output = FileHandle->new("src/${problem}.adb", 'w') or die "Unable to open file 'src/${problem}.adb' for write: $!";
        print $output <<"END_BODY";
with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Long_Integer_Text_IO;
with Ada.Long_Long_Integer_Text_IO;
with Ada.Numerics.Long_Long_Elementary_Functions; use Ada.Numerics.Long_Long_Elementary_Functions;
with PrimeUtilities;
with BigInteger; use BigInteger;
with Ada.Containers.Ordered_Maps;
with Ada.Containers.Vectors;
with Ada.Command_Line;
with Ada.Strings.Bounded;
package body $problem is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
END_BODY
    }
    if ($problem ne 'unknown')
    {
        print $output $_;
    }
    if (/end $problem;/)
    {
        print $output "end $problem;";
        $problem = 'unknown';
        close $output;
        $output = undef;
    }
}
