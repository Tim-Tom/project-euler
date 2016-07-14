with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_17 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      type Length_Array is Array(Positive range <>) of Positive;
      first_twenty_length : constant Length_Array := (3, 3, 5, 4, 4, 3, 5, 5, 4, 3, 6, 6, 8, 8, 7, 7, 9, 8, 8);
      tens_length         : constant Length_Array := (6, 6, 5, 5, 5, 7, 6, 6);
      and_length          : constant Positive := 3;
      hundred_length      : constant Positive := 7; -- Length("hundred")
      thousand_length     : constant Positive := 8; -- Length("thousand")
      count               : Natural := 0;
      function Get_Length(number : in Natural) return Natural is
         hundreds  : constant natural := number / 100;
         tens      : constant natural := (number mod 100) / 10;
         ones      : natural := (number mod 10);
         length : Natural := 0;
      begin
         if hundreds > 0 then
            length := first_twenty_length(hundreds) + hundred_length;
            if tens > 0 or ones > 0 then
               length := length + and_length;
            end if;
         end if;
         if tens >= 2 then
            length := length + tens_length(tens - 1);
         elsif tens = 1 then
            ones := ones + 10;
         end if;
         if ones > 0 then
            length := length + first_twenty_length(ones);
         end if;
         return length;
      end;
   begin
      for number in 1 .. 1000 loop
         declare
            thousands : constant natural := number / 1000;
         begin
            if thousands > 0 then
               count := count + thousand_length + Get_Length(number / 1000);
            end if;
            count := count + Get_Length(number mod 1000);
            null;
         end;
      end loop;
      I_IO.Put(count);
      IO.New_Line;
   end Solve;
end Problem_17;
