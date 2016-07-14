with Ada.Text_IO;
with Ada.Integer_Text_IO;
package body Problem_31 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   Type Two_Pounds is new Integer range 0 .. 200;
   type Coin is new Integer range 1 .. 7;
   denominations : constant Array(Coin) of Two_Pounds := (200, 100, 50, 20, 10, 5, 2);
   procedure Solve is
      function Count_From(amount : Two_Pounds; index : coin) return Integer is
         sum : Integer := 0;
      begin
         if amount = 0 then
            return 1;
         end if;
         declare
            max_usage : constant Two_Pounds := amount / denominations(index);
         begin
            for used in 0 .. max_usage loop
               if index = Coin'Last then
                  -- remainder is all ones
                  sum := sum + 1;
               else
                  sum := sum + Count_From(amount - used*denominations(index), index + 1);
               end if;
            end loop;
         end;
         return sum;
      end Count_From;
   begin
      I_IO.Put(Count_From(Two_Pounds'Last, 1));
      IO.New_Line;
   end Solve;
end Problem_31;
