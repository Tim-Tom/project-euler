with Ada.Integer_Text_IO;
with Ada.Text_IO;
with PrimeInstances;
package body Problem_27 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      subtype Parameter is Integer range -999 .. 999;
      subtype Output is Integer range -(Parameter'Last**2) .. Parameter'Last**2;
      package Integer_Primes renames PrimeInstances.Integer_Primes;
      primes : constant Integer_Primes.Sieve := Integer_Primes.Generate_Sieve(79*79 + 999*79 + 999);
      function Is_Prime(n : Integer) return Boolean is
         subtype Sieve_Index is Positive range primes'Range;
         lower    : Sieve_Index := primes'First;
         upper    : Sieve_Index := primes'Last;
         midPoint : Sieve_Index;
      begin
         if n <= 1 then
            return False;
         end if;
         -- Basic binary search
         while lower <= upper loop
            midPoint := (lower + upper) / 2;
            if n = primes(midPoint) then
               return True;
            elsif n < primes(midPoint) then
               upper := midPoint - 1;
            else
               lower := midPoint + 1;
            end if;
         end loop;
         return False;
      end Is_Prime;
      function doQuad(n : Natural; a,b : parameter) return Integer is
      begin
         return n*n + a*n + b;
      end doQuad;
      highest_count : Natural := 0;
      best_output : Output;
   begin
      for a in Parameter'Range loop
         for prime_index in primes'Range loop
            exit when primes(prime_index) > Parameter'Last;
            declare
               b : constant Parameter := Parameter(primes(prime_index));
               n : Natural := 0;
            begin
               while Is_Prime(doQuad(n, a, b)) loop
                  n := n + 1;
               end loop;
               if n > highest_count then
                  highest_count := n;
                  best_output := a * b;
               end if;
            end;
         end loop;
      end loop;
      I_IO.Put(best_output);
      IO.New_Line;
   end Solve;
end Problem_27;
