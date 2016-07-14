with Ada.Text_IO;
with PrimeInstances;
package body Problem_53 is
   package IO renames Ada.Text_IO;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   procedure Solve is
      sieve : constant Positive_Primes.Sieve := Positive_Primes.Generate_Sieve(100);
      type Prime_Count is Array (sieve'Range) of Natural;
      factorials : Array (1 .. 100) of Prime_Count;
      procedure Factorize(num : Positive) is
         quotient  : Positive := num;
         remainder : Natural := 0;
      begin
         if num = 1 then
            for index in Prime_Count'Range loop
               factorials(num)(index) := 0;
            end loop;
         else
            factorials(num) := factorials(num - 1);
         end if;
         for index in sieve'Range loop
            declare
               prime : constant Positive := sieve(index);
            begin
               exit when quotient < prime;
               loop
                  remainder := quotient mod prime;
                  exit when remainder /= 0;
                  factorials(num)(index) := factorials(num)(index) + 1;
                  quotient := quotient / prime;
               end loop;
            end;
         end loop;
      end Factorize;
      procedure Subtract(result : in out Prime_Count; subtrahend : in Prime_Count) is
      begin
         for index in result'Range loop
            result(index) := result(index) - subtrahend(index);
         end loop;
      end Subtract;
      function Meets_Criteria(num : in Prime_Count) return Boolean is
         product : Positive := 1;
      begin
         for index in num'Range loop
            for count in 1 .. num(index) loop
               product := product * sieve(index);
               if product > 1_000_000 then
                  return True;
               end if;
            end loop;
         end loop;
         return False;
      end Meets_Criteria;
      function Binary_Search(n : Positive) return Positive is
         min, max : Natural;
      begin
         min := n / 2;
         max := n;
         loop
            declare
               mid : constant Positive := (min + max) / 2;
               num : Prime_Count := factorials(n);
            begin
               Subtract(num, factorials(mid));
               Subtract(num, factorials(n - mid));
               if Meets_Criteria(num) then
                  min := mid + 1;
               else
                  max := mid - 1;
               end if;
            end;
            exit when min > max;
         end loop;
         return min;
      end Binary_Search;
      Criteria_Count : Natural := 0;
   begin
      for index in factorials'Range loop
         Factorize(index);
      end loop;
      for n in 23 .. 100 loop
         declare
            max : constant Positive := Binary_Search(n);
         begin
            Criteria_Count := Criteria_Count + 2*max - n + 1;
         end;
      end loop;
      IO.Put_Line(Natural'Image(Criteria_Count));
   end Solve;
end Problem_53;
