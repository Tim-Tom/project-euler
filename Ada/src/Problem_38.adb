with Ada.Text_IO;
with Ada.Integer_Text_IO;
package body Problem_38 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      subtype Digit is Integer range 1 .. 9;
      type Seen_Array is Array(Digit) of Boolean;
      seen : Seen_Array;
      current_number : Integer;
      function Check_2(num : Integer) return Boolean is
         seen2         : Seen_Array := seen;
         num_times_two : Integer := num*2;
         good          : Boolean := True;
      begin
         while num_times_two > 0 loop
            declare
               d : constant Integer := num_times_two mod 10;
            begin
               num_times_two := num_times_two / 10;
               if d = 0 or else seen2(d) then
                  good := False;
                  exit;
               end if;
               seen2(d) := True;
            end;
         end loop;
         return good;
      end Check_2;
   begin
      for index in seen'Range loop
         seen(index) := False;
      end loop;
      seen(9) := True;
      -- If we do better than their sample, it has to come from a 4 digit
      -- number. It has to start with a 9 and the most that the second digit can
      -- be is a 4 because otherwise it would make the 18 that *2 makes into a
      -- 19 which isn't kosher.  We know that the first number we get to is the
      -- best because the first thing we hit is the *1 which is just a copy of
      -- our number.
      for hundreds in reverse 2 .. 4 loop
         seen(hundreds) := True;
         current_number := 9000 + hundreds*100;
         for tens in reverse 2 .. 7 loop
            if not seen(tens) then
               seen(tens) := True;
               current_number := current_number + tens*10;
               for ones in reverse 2 .. 7 loop
                  if not seen(ones) then
                     seen(ones) := True;
                     current_number := current_number + ones;
                     if Check_2(current_number) then
                        goto Have_Solution;
                     end if;
                     current_number := current_number - ones;
                     seen(ones) := False;
                  end if;
               end loop;
               current_number := current_number - tens*10;
               seen(tens) := False;
            end if;
         end loop;
         seen(hundreds) := False;
      end loop;
<<Have_Solution>>
      I_IO.Put(current_number);
      IO.New_Line;
   end Solve;
end Problem_38;
