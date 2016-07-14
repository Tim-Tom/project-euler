with Ada.Text_IO;
with Ada.Containers.Indefinite_Ordered_Maps;
with PrimeInstances;
with Ada.Numerics.Elementary_Functions;
package body Problem_39 is
   package IO renames Ada.Text_IO;
   package Math renames Ada.Numerics.Elementary_Functions;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   package Positive_Map is new Ada.Containers.Indefinite_Ordered_Maps(Key_Type     => Positive,
                                                                      Element_Type => Positive);
   procedure Solve is
      maximum : constant Positive := 1_000;
      max_f   : constant Float := Float(maximum);
      -- To generate max_uv, we set u or v to 1 in the formula and solve for the other one.
      max_u   : constant Positive := Positive((Math.Sqrt(2.0*max_f + 1.0) - 3.0) / 2.0);
      max_v   : constant Positive := Positive((Math.Sqrt(4.0*max_f + 1.0) - 3.0) / 4.0);
      -- This ends up super small.  On the order of max ** (1/4)
      primes : constant Positive_Primes.Sieve := Positive_Primes.Generate_Sieve(Positive(Math.Sqrt(Float(max_u))));
      counts : Positive_Map.Map;
      max_count : Positive := 1;
      max_number : Positive := 12; -- 3 + 4 + 5
      function Coprime(u,v : in Positive) return Boolean is
      begin
         for prime_index in primes'Range loop
            declare
               prime : constant Positive := primes(prime_index);
            begin
               if u mod prime = 0 and v mod prime = 0 then
                  return False;
               end if;
            end;
         end loop;
         return True;
      end CoPrime;
      procedure Add_Count(sum : in Positive) is
         use Positive_Map;
         location : constant Positive_Map.Cursor := counts.Find(sum);
      begin
         if location /= Positive_Map.No_Element then
            declare
               new_count : constant Positive := Positive_Map.Element(location) + 1;
            begin
               if new_count > max_count then
                  max_count := new_count;
                  max_number := sum;
               end if;
               counts.Replace_Element(location, new_count);
            end;
         else
            counts.Insert(sum, 1);
         end if;
      end;
   begin
      for u in 1 .. max_u loop
         -- Not primitive is u is odd
         if u mod 2 = 1 then
            V_Loop:
            for v in 1 .. max_v loop
               -- Not primitive unless the numbers are coprime.
               if Coprime(u, v) then
                  declare
                     sum : constant Positive := 2*(u**2 + 3*u*v + 2*v**2);
                  begin
                     if sum <= maximum then
                        declare
                           scaled_sum : Positive := sum;
                        begin
                           loop
                              Add_Count(scaled_sum);
                              scaled_sum := scaled_sum + sum;
                              exit when scaled_sum > maximum;
                           end loop;
                        end;
                     else
                        exit V_Loop;
                     end if;
                  end;
               end if;
            end loop V_Loop;
         end if;
      end loop;
      IO.Put_Line(Positive'Image(max_number));
   end Solve;
end Problem_39;
