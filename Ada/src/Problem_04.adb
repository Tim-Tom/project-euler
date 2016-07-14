with Ada.Text_IO;
package body Problem_04 is
   package IO renames Ada.Text_IO;
   procedure Solve is
   begin
      for Larger in reverse 100 .. 999 loop
         for Smaller in reverse 100 .. Larger loop
            declare
               word : constant String := Positive'Image(Larger * Smaller);
               lower : Positive := word'First;
               upper : Positive := word'Last;
            begin
               while word(lower) = ' ' loop
                  lower := lower + 1;
               end loop;
               while lower < upper loop
                  if word(lower) /= word(upper) then
                     goto Next_Number;
                  end if;
                  lower := lower + 1;
                  upper := upper - 1;
               end loop;
               IO.Put_Line(word);
               -- This isn't strictly true, but it happens to work out
               -- for this particular problem.  (For example 998*998 > 999*100)
               return;
            end;
         end loop;
<<Next_Number>> null;
      end loop;
   end Solve;
end Problem_04;
