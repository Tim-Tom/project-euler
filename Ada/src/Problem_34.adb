with Ada.Text_IO;
with Ada.Integer_Text_IO;
package body Problem_34 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   function Factorial(n: Integer) return Integer is
      product : Integer := 1;
   begin
      for i in 2 .. n loop
         product := product * i;
      end loop;
      return product;
   end Factorial;
   procedure Solve is
      subtype Digit is Integer range 0 .. 9;
      facts : constant Array(Digit) of Integer := (Factorial(0), Factorial(1),
                                                   Factorial(2), Factorial(3),
                                                   Factorial(4), Factorial(5),
                                                   Factorial(6), Factorial(7),
                                                   Factorial(8), Factorial(9));
      function Fact_Sum(n : Integer) return Integer is
         part_n : Integer := n;
         modulo : Digit;
         sum : Integer := 0;
      begin
         loop
            modulo := part_n mod 10;
            part_n := part_n / 10;
            sum := sum + Factorial(modulo);
            exit when part_n = 0;
         end loop;
         return sum;
      end Fact_Sum;
      total_sum : Integer := 0;
   begin
      for num in 3 .. 7*facts(9) loop
         declare
            sum : constant Integer := fact_sum(num);
         begin
            if sum = num then
               total_sum := total_sum + num;
            end if;
         end;
      end loop;
      I_IO.Put(total_sum);
      IO.New_Line;
   end Solve;
end Problem_34;
