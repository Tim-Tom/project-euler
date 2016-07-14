with Ada.Text_IO;
package body Problem_52 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      type Digit is new Natural range 0 .. 9;
      type Digit_Count is Array (Digit'Range) of Natural;
      function Verify(num : Positive) return Boolean is
         base : Digit_Count := (others => 0);
         multiplied : Positive := num;
         dividend  : Natural := num;
      begin
         while dividend > 0 loop
            declare
               remainder : constant Digit := Digit(dividend mod 10);
            begin
               base(remainder) := base(remainder) + 1;
               dividend := dividend / 10;
            end;
         end loop;
         for multiplier in 2 .. 6 loop
            declare
               temp : Digit_Count := (others => 0);
            begin
               multiplied := multiplied + num;
               dividend := multiplied;
               while dividend > 0 loop
                  declare
                     remainder : constant Digit := Digit(dividend mod 10);
                  begin
                     temp(remainder) := temp(remainder) + 1;
                     if temp(remainder) > base(remainder) then
                        return false;
                     end if;
                     dividend := dividend / 10;
                  end;
               end loop;
            end;
         end loop;
         return True;
      end Verify;
   begin
      for num in 100_000 .. 166_666 loop
         if Verify(num) then
            IO.Put_Line(Positive'Image(num));
            exit;
         end if;
      end loop;
   end Solve;
end Problem_52;
