with Ada.Text_IO;
--with PrimeUtilities;

package body Problem_69 is
   package IO renames Ada.Text_IO;
   subtype One_Million is Integer range 1 .. 10;
   best : One_Million := 1;
   best_ratio : Float := 1.0;
--   package Million_Primes is new PrimeUtilities(One_Million);
   procedure Solve is
      -- sieve : Million_Primes.Sieve := Million_Primes.Genmerate_Sieve(One_Million'Last);
   begin
      for num in 2 .. One_Million'Last loop
         declare
            totient : Positive := 1;
            ratio : Float;
         begin
            for div in 2 .. num - 1 loop
               if num mod div /= 0 then
                  IO.Put_Line(Integer'Image(num) & " is relatively prime to " & Integer'Image(div));
                  totient := totient + 1;
               end if;
            end loop;
            ratio := Float(num) / Float(totient);
            if ratio > best_ratio then
               best := num;
               best_ratio := ratio;
            end if;
         end;
      end loop;
      IO.Put_Line(Integer'Image(best) & " Ratio: " & Float'Image(best_ratio));
   end Solve;
end Problem_69;
