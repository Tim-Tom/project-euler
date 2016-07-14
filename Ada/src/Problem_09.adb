with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_09 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      Squares : Array (1 .. 1000) of Positive;
   begin
      for index in Squares'Range loop
         Squares(index) := index * index;
      end loop;
      for a in 1 .. 332 loop
         for b in a + 1 .. 1000 - a loop
            declare
               c : constant Positive := 1000 - b - a;
            begin
               exit when c <= b;
               if Squares(a) + Squares(b) = Squares(c) then
                  I_IO.put(a*b*c);
                  IO.New_Line;
               end if;
            end;
         end loop;
      end loop;
   end Solve;
end Problem_09;
