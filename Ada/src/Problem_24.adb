with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_24 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      subtype digit is Natural range 0 .. 9;
      chosen : Array (digit) of Boolean;
      unchosen : digit := 9;
      remaining : Natural := 1_000_000;
      function Factorial(n : in Natural) return Natural is
         result : Natural := 1;
      begin
         for num in 2 .. n loop
            result := result * num;
         end loop;
         return result;
      end Factorial;
   begin
      for index in chosen'Range loop
         chosen(index) := False;
      end loop;
      while remaining > 0 and unchosen > 0 loop
         declare
            subPermutations : constant Natural := factorial(unchosen);
            choice : digit := remaining / subPermutations;
         begin
            remaining := remaining mod subPermutations;
            for index in chosen'Range loop
               if not chosen(index) then
                  if choice = 0 then
                     chosen(index) := True;
                     I_IO.Put(index, 1);
                     unchosen := unchosen - 1;
                     exit;
                  end if;
                  choice := choice - 1;
               end if;
            end loop;
         end;
      end loop;
      for index in chosen'Range loop
         exit when unchosen = 0;
         if not chosen(index) then
            I_IO.Put(index, 1);
            unchosen := unchosen - 1;
         end if;
      end loop;
      IO.New_Line;
   end Solve;
end Problem_24;
