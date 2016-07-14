with Ada.Text_IO;
with PrimeInstances;

package body Problem_58 is
   -- 1 3 5 7 9 13 17 21 25 31 37 43 49 ...
   --  2 2 2 2 4  4  4  4  6  6  6  6  8...
   package IO renames Ada.Text_IO;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   procedure Solve is
      increment  : Positive := 2;
      last       : Positive := 1;
      primes     : Natural  := 0;
      count      : Positive := 1;
      gen        : Positive_Primes.Prime_Generator := Positive_Primes.Make_Generator;
      next_prime : Positive;
      function Is_Prime(num : Positive) return Boolean is
      begin
         while num > next_prime loop
            Positive_Primes.Next_Prime(gen, next_prime);
         end loop;
         if next_prime = 1 then
            raise Constraint_Error;
         end if;
         return num = next_prime;
      end Is_Prime;
   begin
      Positive_Primes.Next_Prime(gen, next_prime);
      loop
         for count in 1 .. 4 loop
            last := last + increment;
            if Is_Prime(last) then
               primes := primes + 1;
            end if;
         end loop;
         count := count + 4;
         increment := increment + 2;
         exit when 10*primes < count;
      end loop;
      IO.Put_Line(Positive'Image(increment / 2));
   end Solve;
end Problem_58;
