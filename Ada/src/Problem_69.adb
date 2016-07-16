with Ada.Text_IO;
with PrimeUtilities;

package body Problem_69 is
   package IO renames Ada.Text_IO;
   subtype One_Million is Integer range 1 .. 1_000_000;
   best : One_Million := 1;
   package Million_Primes is new PrimeUtilities(One_Million);
   procedure Solve is
      prime : One_Million;
      gen : Million_Primes.Prime_Generator := Million_Primes.Make_Generator(One_Million'Last);
   begin
      -- The Euler number can be calculated by multiplying together the percent of the numbers that
      -- each prime factor of the number will remove.  Since we're scaling by the number itself
      -- getting bigger numbers will not help us, just a larger percent of numbers filtered.  Each
      -- prime factor will filter out 1/p of the numbers in the number line, leaving p-1/p
      -- remaining. So the smaller the primes we can pick, the larger the percent of numbers we will
      -- filter out. And since we're picking the smallest primes, we know we could never pick more
      -- larger primes and end up with a smaller end target (because we could replace the larger
      -- prime with a smaller prime, get a better ratio). As a result we can just multiply from the
      -- smallest prime number upwards until we get above our maximum ratio.
      loop
         Million_Primes.Next_Prime(gen, prime);
         exit when prime = 1;
         exit when One_Million'Last / prime < best;
         best := best * prime;
      end loop;
      IO.Put_Line(Integer'Image(best));
   end Solve;
end Problem_69;
