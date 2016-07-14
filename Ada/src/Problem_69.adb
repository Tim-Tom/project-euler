with Ada.Text_IO;
with PrimeUtilities;

package body Problem_69 is
   package IO renames Ada.Text_IO;
   subtype One_Million is Integer range 1 .. 1_000_000;
   best : One_Million := 1;
   best_ratio : Float := 1.0;
   package Million_Primes is new PrimeUtilities(One_Million);
   procedure Solve is
      sieve : constant Million_Primes.Sieve := Million_Primes.Generate_Sieve(One_Million'Last);
   begin
      for num in 2 .. One_Million'Last loop
         declare
            totient : Float := 1.0;
            ratio : Float;
            factors : constant Million_Primes.Prime_Factors := Million_Primes.Generate_Prime_Factors(num, sieve);
         begin
            for i in factors'Range loop
               totient := totient * (1.0 - 1.0 / Float(factors(i).prime));
            end loop;
            ratio := 1.0 / totient;
            if ratio > best_ratio then
               best := num;
               best_ratio := ratio;
            end if;
         end;
      end loop;
      IO.Put_Line(Integer'Image(best) & " Ratio: " & Float'Image(best_ratio));
   end Solve;
end Problem_69;
