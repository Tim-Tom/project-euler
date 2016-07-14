with Ada.Text_IO;
with Ada.Containers.Ordered_Maps;
with PrimeUtilities;

package body Problem_51 is
   package IO renames Ada.Text_IO;
   type Number_Range is new Integer range 0 .. 999_999_999;
   type Converted_Range is new Integer range 0 .. Integer(Number_Range'Last + 1)*11/10;
   type Magnitude is new Positive range 1 .. 9;
   type Family_Count is Record
      base_example : Number_Range;
      count        : Positive;
   end Record;
   package Family_Map is new Ada.Containers.Ordered_Maps(Key_Type => Converted_Range,
                                                         Element_Type => Family_Count);
   package Range_Primes is new PrimeUtilities(Num => Number_Range);
   procedure Solve is
      gen : Range_Primes.Prime_Generator := Range_Primes.Make_Generator;
      families : Family_Map.Map;
      prime : Number_Range;
      prime_magnitude : Magnitude := 1;
      function Get_Magnitude(num : Number_Range) return Magnitude is
      begin
         if num >= 100_000_000 then
            return 9;
         elsif num >= 10_000_000 then
            return 8;
         elsif num >= 1_000_000 then
            return 7;
         elsif num >= 100_000 then
            return 6;
         elsif num >= 10_000 then
            return 5;
         elsif num >= 1_000 then
            return 4;
         elsif num >= 100 then
            return 3;
         elsif num >= 10 then
            return 2;
         else
            return 1;
         end if;
      end;
    pragma Pure_Function(Get_Magnitude);
      Function Generate_Families(prime : Number_Range) return Number_Range is
         Function Gen_Families_Rec(number : Number_Range; so_far : Converted_Range; Keep : Number_Range) return Number_Range is
            found : Number_Range := 0;
         begin
            if number /= 0 then
               declare
                  quotient  : constant Number_Range := number / 10;
                  remainder : constant Number_Range := number mod 10;
               begin
                  found := Gen_Families_Rec(quotient, (so_far*11) + Converted_Range(remainder), keep);
                  if found /= 0 then
                     return found;
                  elsif keep = 11 or keep = remainder then
                     found := Gen_Families_Rec(quotient, so_far*11 + 10, remainder);
                     if found /= 0 then
                        return found;
                     end if;
                  end if;
               end;
            elsif keep /= 11 then
               declare
                  use Family_Map;
                  location : constant Family_Map.Cursor := families.Find(so_far);
                  element : Family_Count;
               begin
                  if location = Family_Map.No_Element then
                     element.base_example := prime;
                     element.count := 1;
                     families.Insert(so_far, element);
                  else
                     element := Family_Map.Element(location);
                     element.count := element.count + 1;
                     families.Replace_Element(location, element);
                     if element.count = 8 then
                        return element.base_example;
                     end if;
                  end if;
               end;
            end if;
            return 0;
         end Gen_Families_Rec;
      begin
         return Gen_Families_Rec(prime, 0, 11);
      end Generate_Families;
   begin
      loop
         Range_Primes.Next_Prime(gen, prime);
         exit when prime = 1;
         if prime_magnitude /= Get_Magnitude(prime) then
            prime_magnitude := Get_Magnitude(prime);
            families.Clear;
         end if;
         declare
            found : constant Number_Range := Generate_Families(prime);
         begin
            if found /= 0 then
               IO.Put_Line(Number_Range'Image(found));
               exit;
            end if;
         end;
      end loop;
   end Solve;
end Problem_51;
