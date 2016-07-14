with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Numerics.Elementary_Functions;
with PrimeInstances;
package body Problem_05 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   package Math renames Ada.Numerics.Elementary_Functions;
   procedure Solve is
      package Positive_Primes renames PrimeInstances.Positive_Primes;
      max_num : constant Positive := 20;
      max_num_float : constant Float := Float(max_num);
      max_multiple_prime : constant Positive := Positive(Float'Floor(Math.Sqrt(max_num_float)));
      gen : Positive_Primes.Prime_Generator := Positive_Primes.Make_Generator(20);
      prime : Positive;
      result : Positive := 1;
   begin
      loop
         Positive_Primes.Next_Prime(gen, prime);
         exit when prime = 1;
         if prime <= max_multiple_prime then
            result := result * (prime **Positive(Float'Floor(Math.Log(max_num_float, Base => Float(prime)))));
         else
            result := result * prime;
         end if;
      end loop;
      I_IO.Put(result);
      IO.New_Line;
   end Solve;
end Problem_05;
