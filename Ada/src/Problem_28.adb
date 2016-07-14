with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_28 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      sum : Positive := 1;
      last : Positive := 1;
   begin
      for row in 2 .. 1_001 loop
         declare
            adder : constant Positive := (row - 1)*2;
         begin
            sum := 4*last + (1 + 2 + 3 + 4)*adder;
            last := last + 4*adder;
         end;
      end loop;
      I_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_28;
