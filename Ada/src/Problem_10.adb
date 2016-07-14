with Ada.Long_Long_Integer_Text_IO;
with Ada.Text_IO;
with PrimeInstances;
package body Problem_10 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Long_Long_Integer_Text_IO;
   procedure Solve is
      package Integer_Primes renames PrimeInstances.Integer_Primes;
      gen : Integer_Primes.Prime_Generator := Integer_Primes.Make_Generator(2_000_000);
      sum : Long_Long_Integer := 0;
      prime : Integer;
   begin
      loop
         Integer_Primes.Next_Prime(gen, prime);
         exit when prime = 1;
         sum := sum + Long_Long_Integer(prime);
      end loop;
      I_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_10;
