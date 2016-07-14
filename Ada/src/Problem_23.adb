with Ada.Integer_Text_IO;
with Ada.Text_IO;
with PrimeUtilities;
package body Problem_23 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      Maximum_Value : constant Integer := 28123;
      subtype Problem_Range is Integer range 1 .. Maximum_Value;
      package Primes is new PrimeUtilities(Num => Problem_Range);
      sieve : constant Primes.sieve := Primes.Generate_Sieve(Problem_Range'Last);
      is_abundant : Array (Problem_Range) of Boolean;
      function sum_divisors(num : in Problem_Range) return Natural is
         divisors : constant Primes.Proper_Divisors := Primes.Generate_Proper_Divisors(num, sieve);
         sum : Natural;
      begin
         sum := 0;
         for index in divisors'Range loop
            sum := sum + divisors(index);
         end loop;
         return sum;
      end sum_divisors;
      sum : Natural := 0;
   begin
      is_abundant(1) := False;
      for num in 2 .. Problem_Range'Last loop
         declare
            sum : constant Natural := sum_divisors(num);
         begin
            if sum > num then
               is_abundant(num) := True;
            else
               is_abundant(num) := False;
            end if;
         end;
      end loop;
      for num in Problem_Range'Range loop
         declare
            is_sum : Boolean := False;
         begin
            for subtrahend in 1 .. num / 2 loop
               if is_abundant(subtrahend) and is_abundant(num - subtrahend) then
                  is_sum := True;
                  exit;
               end if;
            end loop;
            if not is_sum then
               sum := sum + num;
            end if;
         end;
      end loop;
      I_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_23;
