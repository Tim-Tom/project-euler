with Ada.Text_IO;
with Ada.Long_Long_Integer_Text_IO;
with Ada.Numerics.Long_Long_Elementary_Functions; use Ada.Numerics.Long_Long_Elementary_Functions;
with PrimeInstances;
package body Problem_03 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      function Largest_Prime_Factor(number : in Long_Long_Integer) return Long_Long_Integer is
         package Long_Long_Primes renames PrimeInstances.Long_Long_Primes;
         square_root : constant Long_Long_Integer := Long_Long_Integer(Sqrt(Long_Long_Float(number)));
         sieve : constant Long_Long_Primes.Sieve := Long_Long_Primes.Generate_Sieve(square_root);
         quotient : Long_Long_Integer := number;
         largest  : Long_Long_Integer := 1;
      begin
         for index in sieve'Range loop
            declare
               prime : constant Long_Long_Integer := sieve(index);
            begin
               while quotient mod prime = 0 loop
                  quotient := quotient / prime;
                  largest := prime;
               end loop;
            end;
         end loop;
         if quotient /= 1 then
            return quotient;
         else
            return largest;
         end if;
      end Largest_Prime_Factor;
   begin
      Ada.Long_Long_Integer_Text_IO.Put(Largest_Prime_Factor(600_851_475_143));
      IO.New_Line;
   end Solve;
end Problem_03;
