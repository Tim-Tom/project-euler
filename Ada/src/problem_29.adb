with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Containers.Ordered_Sets;
package body Problem_29 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   package Positive_Set is new Ada.Containers.Ordered_Sets(Positive);
   subtype Parameter is Integer range 2 .. 100;
   type Special_Array is Array(Parameter) of Boolean;
   Is_Special : Special_Array;
   count : Natural := 0;
   procedure Check_If_Special(a : Parameter) is
      set : Positive_Set.Set;
      procedure Add_To_Set(exponent : Positive) is
         number : constant Integer := a**exponent;
         current_exponent : Positive := exponent*2;
         current_number : Integer := number**2;
         Last_Index : Parameter := Parameter'First;
      begin
         Is_Special(number) := True;
         while current_number <= Parameter'Last loop
            Add_To_Set(current_exponent);
            if not set.Contains(current_exponent) then
               set.Insert(current_exponent);
            end if;
            current_exponent := current_exponent + exponent;
            current_number := current_number * number;
            Last_Index := Last_Index + 1;
         end loop;
         for unused in Last_Index .. Parameter'Last loop
            if not set.Contains(current_exponent) then
               set.Insert(current_exponent);
            end if;
            current_exponent := current_exponent + exponent;
         end loop;
      end Add_To_Set;
   begin
      if Is_Special(a) then
         -- Already handled
         return;
      end if;
      if Integer(a)**2 <= Parameter'Last then
         Add_To_Set(1);
         count := count + Natural(set.Length);
      end if;
   end Check_If_Special;
   procedure Solve is
   begin
      for index in Is_Special'Range loop
         Is_Special(index) := False;
      end loop;
      for a in Parameter'Range loop
         Check_If_Special(a);
         if not Is_Special(a) then
            count := count + Parameter'Last - Parameter'First + 1;
         end if;
      end loop;
      I_IO.Put(count);
      IO.New_Line;
   end Solve;
end Problem_29;
