with Ada.Integer_Text_IO;
with Ada.Text_IO;
with BigInteger; use BigInteger;
package body Problem_20 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      product : BigInt := BigInteger.Create(2);
   begin
      for i in 3 .. Long_Long_Integer(100) loop
         product := product * BigInteger.Create(i);
      end loop;
      declare
         Str : constant String := BigInteger.ToString(product);
         Digit_Sum : Natural := 0;
      begin
         for index in Str'Range loop
            Digit_Sum := Digit_Sum + Character'Pos(Str(index)) - Character'Pos('0');
         end loop;
         I_IO.Put(Digit_Sum);
         IO.New_Line;
      end;
   end Solve;
end Problem_20;
