with Ada.Integer_Text_IO;
with Ada.Text_IO;
with PrimeInstances;
package body Problem_07 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      package Integer_Primes renames PrimeInstances.Integer_Primes;
      Sieve : constant Integer_Primes.Sieve := Integer_Primes.Generate_Sieve(110_000);
   begin
      I_IO.Put(Sieve(10_001));
      IO.New_Line;
      null;
   end Solve;
end Problem_07;
