with Ada.Text_IO;
with PrimeInstances;
with Ada.Containers.Vectors;
package body Problem_47 is
   package IO renames Ada.Text_IO;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   package Positive_Vectors is new Ada.Containers.Vectors(Index_Type => Positive,
                                                          Element_Type => Positive);
   procedure Solve is
      gen : Positive_Primes.Prime_Generator := Positive_Primes.Make_Generator;
      searching : constant := 4;
      next_prime : Positive;
      primes : Positive_Vectors.Vector := Positive_Vectors.Empty_Vector;
      function Num_Factors(num : Positive) return Natural is
         factor_count : Natural := 0;
         function "=" (left,right : Positive_Vectors.Cursor) return Boolean renames Positive_Vectors."=";
         prime_cursor : Positive_Vectors.Cursor := primes.First;
      begin
         while prime_cursor /= Positive_Vectors.No_Element loop
            declare
               prime : constant Positive := Positive_Vectors.Element(prime_cursor);
            begin
               Positive_Vectors.Next(prime_cursor);
               exit when prime > num;
               if num mod prime = 0 then
                  factor_count := Natural'Succ(factor_count);
               end if;
            end;
         end loop;
         return factor_count;
      end;
   begin
      loop
         Positive_Primes.Next_Prime(gen, next_prime);
         primes.Append(next_prime);
         exit when next_prime > 644;
      end loop;
      composite_search:
      for composite_base in 161 .. 1_000_000 loop
         declare
            composite : constant Positive := composite_base * searching;
         begin
            while composite > next_prime loop
               Positive_Primes.Next_Prime(gen, next_prime);
               primes.Append(next_prime);
            end loop;
            if Num_Factors(composite) = searching then
               declare
                  prime_count : Positive := 1;
                  smallest : Positive := composite;
               begin
                  for comp in reverse composite - (searching - 1) .. composite - 1 loop
                     if Num_Factors(comp) = searching then
                        prime_count := prime_count + 1;
                        smallest := comp;
                     else
                        exit;
                     end if;
                  end loop;
                  for comp in composite + 1 .. composite + (searching - 1) loop
                     if Num_Factors(comp) = searching then
                        prime_count := prime_count + 1;
                        if prime_count = searching then
                           IO.Put_Line(Positive'Image(smallest));
                           exit composite_search;
                        end if;
                     else
                        exit;
                     end if;
                  end loop;
               end;
            end if;
         end;
      end loop composite_search;
   end Solve;
end Problem_47;
