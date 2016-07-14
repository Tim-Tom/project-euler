with Ada.Integer_Text_IO;
with Ada.Text_IO;
with PrimeInstances;
package body Problem_12 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      package Integer_Primes renames PrimeInstances.Integer_Primes;
      sieve : constant Integer_Primes.Sieve := Integer_Primes.Generate_Sieve(15_000);
      -- We actually have the count one higher than the actual count because
      -- that's what we end up multiplying since '0' of the number is a choice.
      type Factor_Array is Array (sieve'Range) of Positive;
      function total_factors(factors: in Factor_Array) return Positive is
         permutations : Positive := 1;
      begin
         for index in factors'Range loop
            declare
               count : constant Natural := factors(index);
            begin
               permutations := permutations * count;
            end;
         end loop;
         return permutations;
      end total_factors;
      procedure generate_factors(num : in Positive; factors: out Factor_Array) is
         quotient : Positive := num;
      begin
         for index in Factor_Array'Range loop
            factors(index) := 1;
         end loop;
         for prime_index in sieve'Range loop
            declare
               prime : constant Positive := sieve(prime_index);
               count : Natural := 1;
            begin
               while quotient mod prime = 0 loop
                  count := count + 1;
                  quotient := quotient / prime;
               end loop;
               if count > factors(prime_index) then
                  factors(prime_index) := count;
               end if;
            end;
         end loop;
         null;
      end generate_factors;
      factors : Factor_Array;
      triangle : Positive := 1;
   begin
      for x in 2 .. sieve(sieve'Last) loop
         triangle := triangle + x;
         generate_factors(triangle, factors);
         if total_factors(factors) > 500 then
            I_IO.Put(triangle);
            IO.New_Line;
            exit;
         end if;
      end loop;
   end Solve;
end Problem_12;
