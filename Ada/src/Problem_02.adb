with Ada.Text_IO;
with Ada.Long_Integer_Text_IO;
package body Problem_02 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      n   : Long_Integer;
      n_1 : Long_Integer := 1;
      n_2 : Long_Integer := 0;
      sum : Long_Integer := 0;
   begin
      loop
         n := n_1 + n_2;
         exit when n > 4_000_000;
         if n mod 2 = 0 then
            sum := sum + n;
         end if;
         n_2 := n_1;
         n_1 := n;
      end loop;
      Ada.Long_Integer_Text_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_02;
