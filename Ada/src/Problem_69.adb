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
      loop
         Million_Primes.Next_Prime(gen, prime);
         exit when prime = 1;
         exit when One_Million'Last / prime < best;
         best := best * prime;
      end loop;
      IO.Put_Line(Integer'Image(best));
   end Solve;
end Problem_69;
