with Ada.Text_IO;
with BigInteger;
package body Problem_56 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      function Digit_Sum(bi : BigInteger.BigInt) return Positive is
         str : constant String := BigInteger.ToString(bi);
         sum : Natural := 0;
      begin
         for index in str'Range loop
            sum := sum + Character'Pos(str(index)) - Character'Pos('0');
         end loop;
         return sum;
      end Digit_Sum;
      max_sum : Positive := 1;
   begin
      for a in 2 .. 100 loop
         declare
            multiplier : constant BigInteger.BigInt := BigInteger.Create(Long_Long_Integer(a));
            result : BigInteger.BigInt := multiplier;
            function "*"(left, right : BigInteger.BigInt) return BigInteger.BigInt renames BigInteger."*";
            sum : Positive := Digit_Sum(result);
         begin
            if sum > max_sum then
               max_sum := sum;
            end if;
            for b in 2 .. 100 loop
               result := result * multiplier;
               sum := Digit_Sum(result);
               if sum > max_sum then
                  max_sum := sum;
               end if;
            end loop;
         end;
      end loop;
      IO.Put_Line(Positive'Image(max_sum));
   end Solve;
end Problem_56;
