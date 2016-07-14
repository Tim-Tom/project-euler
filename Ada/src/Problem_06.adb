with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_06 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      function Sum_Square(max : Integer) return Integer is
         Sum : Integer := 0;
      begin
         for number in 1 .. max loop
            Sum := Sum + number * number;
         end loop;
         return Sum;
      end Sum_Square;
      function Square_Sum(max : Integer) return Integer is
         Sum : Integer := 0;
      begin
         for number in 1 .. max loop
            Sum := Sum + number;
         end Loop;
         return Sum*Sum;
      end Square_Sum;
   begin
      I_IO.Put(Square_Sum(100) - Sum_Square(100));
      IO.New_Line;
   end Solve;
end Problem_06;
