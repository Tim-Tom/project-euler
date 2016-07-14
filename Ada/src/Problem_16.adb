with Ada.Integer_Text_IO;
with Ada.Text_IO;
with BigInteger; use BigInteger;
package body Problem_16 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      Big : constant BigInteger.BigInt := BigInteger.Create(2)**1_000;
      Str : constant String := BigInteger.ToString(Big);
      Digit_Sum : Natural := 0;
   begin
      for index in Str'Range loop
         Digit_Sum := Digit_Sum + Character'Pos(Str(index)) - Character'Pos('0');
      end loop;
      I_IO.Put(Digit_Sum);
      IO.New_Line;
   end Solve;
end Problem_16;
