with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_19 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      type Day_Of_Week is mod 7;
      type Year is new Positive range 1900 .. 2010;
      current_day : Day_Of_Week := 1;
      count : Natural := 0;
      type Month_Count_Array is Array (1 .. 12) of Day_Of_Week;
      Normal_Days_In_Month : aliased constant Month_Count_Array := (3, 0, 3, 2, 3, 2, 3, 3, 2, 3, 2, 3);
      Leap_Days_In_Month : aliased constant Month_Count_Array := (3, 1, 3, 2, 3, 2, 3, 3, 2, 3, 2, 3);
      Current_Days_In_Month : access constant Month_Count_Array;
      procedure New_Year(current_year : in Year) is
      begin
         if (current_year mod 4 = 0 and  current_year mod 100 /= 0) or (current_year mod 400 = 0) then
            Current_Days_In_Month := Leap_Days_In_Month'Access;
         else
            Current_Days_In_Month := Normal_Days_In_Month'Access;
         end if;
      end;
   begin
      for current_year in year'Range loop
         New_Year(current_year);
         for month in 1 .. 12 loop
            if current_day = 0 and current_year /= 1900 then
               count := count + 1;
            end if;
            current_day := current_day + Current_Days_In_Month(month);
         end loop;
      end loop;
      I_IO.Put(count);
      IO.New_Line;
   end Solve;
end Problem_19;
