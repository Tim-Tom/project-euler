with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_01 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      sum : Integer := 0;
   begin
      for i in 1 .. 999 loop
         if i mod 3 = 0 or i mod 5 = 0 then
            sum := sum + i;
         end if;
      end loop;
      I_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_01;
