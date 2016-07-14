with Ada.Text_IO;
with PrimeInstances;
package body Problem_41 is
   package IO renames Ada.Text_IO;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   type Prime_Magnitude is new Positive range 1 .. 9;
   procedure Solve is
      gen : Positive_Primes.Prime_Generator := Positive_Primes.Make_Generator(Max_Prime => 7_654_321);
      function Is_Pandigital_Prime(prime : Positive; magnitude : Prime_Magnitude) return Boolean is
         type Used_Array is Array (1 .. magnitude) of Boolean;
         used : Used_Array := (others => False);
         all_used : constant Used_Array := (others => True);
         quotient  : Natural := Prime;
         remainder : Natural range 0 .. 9;
      begin
         while quotient /= 0 loop
            remainder := quotient mod 10;
            quotient  := quotient  /  10;
            if (remainder = 0 or remainder > Positive(magnitude)) or else used(Prime_Magnitude(remainder)) then
               return False;
            else
               used(Prime_Magnitude(remainder)) := True;
            end if;
            exit when quotient = 0;
         end loop;
         return used = all_used;
      end Is_Pandigital_Prime;
      prime : Positive;
      next_power_of_ten : Positive := 10;
      magnitude : Prime_Magnitude := 1;
      biggest : Positive := 1;
   begin
      loop
         Positive_Primes.Next_Prime(gen, prime);
         exit when prime = 1;
         if prime >= next_power_of_ten then
            next_power_of_ten := next_power_of_ten * 10;
            magnitude := Prime_Magnitude'Succ(magnitude);
         end if;
         if Is_Pandigital_Prime(prime, magnitude) then
            biggest := prime;
         end if;
      end loop;
      IO.Put_Line(Positive'Image(biggest));
   end Solve;
end Problem_41;
