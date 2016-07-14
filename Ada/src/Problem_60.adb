with Ada.Text_IO;
with PrimeInstances;
with Ada.Containers.Vectors;
package body Problem_60 is
   package IO renames Ada.Text_IO;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   type PrimePair is record
      first, second : Positive;
   end record;
   type PrimeTriple is record
      first, second, third : Positive;
   end record;
   package Positive_Pair_Vectors is new Ada.Containers.Vectors(Index_Type => Positive,
                                                               Element_Type => PrimePair);
   package Positive_Triple_Vectors is new Ada.Containers.Vectors(Index_Type => Positive,
                                                                 Element_Type => PrimePair);
   function Binary_Search(sieve : Positive_Primes.Sieve; prime : Positive) return Natural is
      min, max : Natural;
   begin
      min := sieve'First;
      max := sieve'Last;
      loop
         declare
            mid : constant Positive := (min + max) / 2;
         begin
            if sieve(mid) < prime then
               min := mid + 1;
            else
               max := mid;
            end if;
            exit when min >= max;
         end;
      end loop;
      if (min /= max or else sieve(min) /= prime) then
         min := 0;
      end if;
      return min;
   end Binary_Search;

   function Binary_Search_Pair(pairs : Positive_Pair_Vectors.Vector; prime : Positive) return Positive_Pair_Vectors.Extended_Index is
      min, max : Positive_Pair_Vectors.Extended_Index;
   begin
      min := pairs.First_Index;
      max := pairs.Last_Index;
      loop
         declare
            mid : constant Positive := (min + max) / 2;
         begin
            if pairs.Element(mid).first < prime then
               min := mid + 1;
            else
               max := mid;
            end if;
            exit when min >= max;
         end;
      end loop;
      if (min /= max or else pairs.Element(min).first /= prime) then
         min := Positive_Pair_Vectors.No_Index;
      end if;
      return min;
   end Binary_Search_Pair;

   function Next_Matching_Pair(pairs : Positive_Pair_Vectors.Vector; fi, si : Positive) return Natural is
   begin
      return 0;
   end Next_Matching_Pair;

   function Scale(num : Positive) return Positive is
   begin
      if num < 10 then
         return 1;
      elsif num < 100 then
         return 2;
      elsif num < 1_000 then
         return 3;
      elsif num < 10_000 then
         return 4;
      elsif num < 100_000 then
         return 5;
      elsif num < 1_000_000 then
         return 6;
      elsif num < 10_000_000 then
         return 7;
      elsif num < 100_000_000 then
        return 8;
      else
         return 9;
      end if;
   end Scale;

   function ConcatPositive(left, right : Positive) return Positive is
      Scale_Multiply : constant Array(1 .. 9) of Positive := (10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000, 100_000_000, 1_000_000_000);
   begin
      return left * Scale_Multiply(Scale(right)) + right;
   end ConcatPositive;

   procedure Solve is
      max_prime : constant := 100_000_000;
      max_prime_scale : constant := 9;
      sieve : constant Positive_Primes.Sieve := Positive_Primes.Generate_Sieve(max_prime);
      count : Natural := 0;
      pairs : Positive_Pair_Vectors.Vector;
      triples : Positive_Triple_Vectors.Vector;
   begin
      for first_prime_index in sieve'First .. sieve'Last - 1 loop
         for second_prime_index in first_prime_index + 1 .. sieve'Last loop
            exit when Scale(sieve(first_prime_index)) + Scale(sieve(second_prime_index)) >= max_prime_scale;
            declare
               first : Positive renames sieve(first_prime_index);
               second : Positive renames sieve(second_prime_index);
               left : constant Positive := ConcatPositive(first, second);
               right : constant Positive := ConcatPositive(second, first);
            begin
               exit when left > max_prime or else right > max_prime;
               if Binary_Search(sieve, left) /= 0 and then Binary_Search(sieve, right) /= 0 then
                  declare
                     pair : constant PrimePair := (first, second);
                  begin
                     if count mod 750 = 0 then
                        IO.Put_Line("INSERT INTO dbo.PrimePairs ([First], [Second])");
                        IO.Put_Line("VALUES");
                     end if;
                     IO.Put("    (" & Positive'Image(pair.first) & "," &Positive'Image(pair.second) & ")");
                     if count mod 750 = 749 then
                        IO.Put_Line(";");
                        IO.New_Line;
                     else
                        IO.Put_Line(",");
                     end if;
                     count := count + 1;
                  end;
               end if;
            end;
         end loop;
      end loop;

      return;
      declare
         -- SELECT AB.First, AB.Second, AC.Second
         -- FROM Pairs as AB
         -- JOIN Pairs as AC ON AC.First  = AB.First
         -- JOIN Pairs as BC ON BC.First  = AB.Second
         --                 AND BC.Second = AC.Second
         si, ti : Positive_Pair_Vectors.Extended_Index;
      begin
         for fi in pairs.First_Index .. pairs.Last_Index loop
            si := Binary_Search_Pair(pairs, pairs.Element(fi).second);
            if si /= Positive_Pair_Vectors.No_Index then
               loop
                  null;
                  exit when si = pairs.Last_Index;
                  si := si + 1;
                  exit when pairs.Element(si).first /= pairs.Element(fi).second;
               end loop;
            end if;
         end loop;
      end;
      IO.Put_Line(Integer'Image(Integer(pairs.Length)));
      IO.Put_Line("The Answer");
   end Solve;
end Problem_60;
