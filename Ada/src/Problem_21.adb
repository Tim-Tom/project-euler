with Ada.Integer_Text_IO;
with Ada.Text_IO;
with PrimeUtilities;
package body Problem_21 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      subtype subset is Integer range 1 .. 10_000;
      package Subset_Primes is new PrimeUtilities(Num => subset);
      sieve : constant Subset_Primes.sieve := Subset_Primes.Generate_Sieve(subset'Last);
      d : Array (2 .. subset'Last) of Integer;
      sum : Integer := 0;
      procedure sum_divisors(num : in subset; sum : out Natural) is
         divisors : constant Subset_Primes.Proper_Divisors := Subset_Primes.Generate_Proper_Divisors(num, sieve);
      begin
         sum := 0;
         for index in divisors'Range loop
            sum := sum + divisors(index);
         end loop;
      end sum_divisors;
   begin
      for n in d'Range loop
         sum_divisors(n, d(n));
      end loop;
      for n in d'Range loop
         if (d(n) <= d'Last and d(n) >= d'First) and then d(d(n)) = n then
            sum := sum + n;
         end if;
      end loop;
      I_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_21;
