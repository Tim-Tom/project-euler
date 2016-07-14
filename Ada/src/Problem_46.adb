with Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Numerics.Long_Elementary_Functions;
with PrimeInstances;
package body Problem_46 is
   package IO renames Ada.Text_IO;
   package Math renames Ada.Numerics.Long_Elementary_Functions;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   package Positive_Vector is new Ada.Containers.Vectors(Index_Type => Positive,
                                                         Element_Type => Positive);
   procedure Solve is
      gen : Positive_Primes.Prime_Generator := Positive_Primes.Make_Generator;
      primes : Positive_Vector.Vector := Positive_Vector.Empty_Vector;
      prime, composite : Positive;
      function goldbach_composite(composite : Positive) return Boolean is
         use Positive_Vector;
         prime_cursor : Cursor := primes.First;
      begin
         while prime_cursor /= No_Element loop
            declare
               root : constant Long_Float := Math.Sqrt(Long_Float(composite - Element(prime_cursor))/2.0);
            begin
               if root = Long_Float'floor(root) then
                  return True;
               end if;
            end;
            Positive_Vector.Next(prime_cursor);
         end loop;
         return False;
      end;
   begin
      -- initialize virtual lists
      Positive_Primes.Next_Prime(gen, prime); -- skip 2.  It's an ugly prime for this problem
      Positive_Primes.Next_Prime(gen, prime);
      composite := 3;
      main_loop:
      loop
         while composite < prime loop
            exit main_loop when not goldbach_composite(composite);
            composite := composite + 2;
         end loop;
         if composite = prime then
            composite := composite + 2;
         end if;
         primes.Append(prime);
         Positive_Primes.Next_Prime(gen, prime);
      end loop main_loop;
      IO.Put_Line(Positive'Image(composite));
   end Solve;
end Problem_46;
