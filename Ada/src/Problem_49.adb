with Ada.Text_IO;
with PrimeInstances;
package body Problem_49 is
   package IO renames Ada.Text_IO;
   type Four_Digit is new Integer range 1_000 .. 9_999;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   procedure Solve is
      Is_Prime : Array (Four_Digit) of Boolean := (others => False);
      prime : Positive;
      type Permute_Array is Array(Positive range <>) of Four_Digit;
      function Permute(num : Four_Digit) return Permute_Array is
         type Digit_Count is Array(0 .. 9) of Natural;
         d : Digit_Count := (others => 0);
         count : Positive := 4*3*2;
      begin
         declare
            quotient : Natural := Natural(num);
            remainder : Natural := 0;
            function fact(num : Natural) return Positive is
               result : Positive := 1;
            begin
               for n in 1 .. num loop
                  result := result * n;
               end loop;
               return result;
            end;
         begin
            while(quotient > 0) loop
               remainder := quotient mod 10;
               quotient  := quotient  /  10;
               d(remainder) := d(remainder) + 1;
            end loop;
            for digit in d'Range loop
               count := count / fact(d(digit));
            end loop;
            if d(0) = 1 then
               count := count - count / 4;
            elsif d(0) = 2 then
               count := count / 2;
            elsif d(0) = 3 then
               count := count / 4;
            end if;
         end;
         declare
            result : Permute_Array(1 .. count);
            num_array : Array(1 .. 4) of Natural;
            index : Positive := 1;
            possible : Natural;
            function Combine return Natural is
               result : Natural := 0;
            begin
               for index in num_array'Range loop
                  result := 10*result + num_array(index);
               end loop;
               return result;
            end Combine;
         begin
            for digit in d'Range loop
               while d(digit) > 0 loop
                  num_array(index) := digit;
                  index := index + 1;
                  d(digit) := d(digit) - 1;
               end loop;
            end loop;
            possible := Combine;
            if possible > 1000 then
               result(1) := Four_Digit(possible);
               index := 2;
            else
               index := 1;
            end if;
            main_loop:
            loop
               declare
                  k : Positive := num_array'Last - 1;
                  l : Positive := num_array'Last;
               begin
                  -- Find the largest index k such that a[k] < a[k + 1]. If no such index exists, the permutation is the last permutation.
                  loop
                     exit when num_array(k) < num_array(k + 1);
                     exit main_loop when k = 1;
                     k := k - 1;
                  end loop;
                  -- Find the largest index l such that a[k] < a[l]. Since k + 1 is such an index, l is well defined and satisfies k < l.
                  loop
                     exit when num_array(k) < num_array(l);
                     l := l - 1;
                  end loop;
                  -- Swap a[k] with a[l].
                  declare
                     temp : Natural := num_array(k);
                  begin
                     num_array(k) := num_array(l);
                     num_array(l) := temp;
                     -- Reverse the sequence from a[k + 1] up to and including the final element a[n].;
                     for index in 1 .. (num_array'Last - k) / 2 loop
                        temp := num_array(k + index);
                        num_array(k + index) := num_array(num_array'Last + 1 - index);
                        num_array(num_array'Last + 1 - index) := temp;
                     end loop;
                  end;
                  possible := Combine;
                  if possible > 1000 then
                     result(index) := Four_Digit(possible);
                     exit when index = count;
                     index := index + 1;
                  end if;
               end;
            end loop main_loop;
            return result;
         end;
      end Permute;
      pragma Pure_Function(Permute);
   begin
      declare
         gen : Positive_Primes.Prime_Generator := Positive_Primes.Make_Generator(9_999);
      begin
         loop
            Positive_Primes.Next_Prime(gen, prime);
            exit when prime >= 1_000;
         end loop;
         while prime /= 1 loop
            Is_Prime(Four_Digit(prime)) := True;
            Positive_Primes.Next_Prime(gen, prime);
         end loop;
      end;
      Prime_Loop:
      for num in Four_Digit(1_000) .. 9_999 loop
         if not Is_Prime(num) or num = 1487 then
            goto Next_Prime;
         end if;
         declare
            rotations : Array (1 .. 24) of Four_Digit;
            permutations : constant Permute_Array := Permute(num);
            count : Natural := 0;
         begin
            for permute_index in permutations'Range loop
               declare
                  permutation : constant Four_Digit := permutations(permute_index);
               begin
                  if Is_Prime(permutation) then
                     if permutation < num then
                        goto Next_Prime;
                     end if;
                     count := count + 1;
                     rotations(count) := permutation;
                  end if;
               end;
            end loop;
            if count >= 3 then
               for base in 1 .. count - 2 loop
                  for mid in base + 1.. count - 1 loop
                     for top in mid + 1 .. count loop
                        if rotations(base) + rotations(top) = 2*rotations(mid) then
                           IO.Put_Line(Four_Digit'Image(rotations(base)) & Four_Digit'Image(rotations(mid)) & Four_Digit'Image(rotations(top)));
                           exit Prime_Loop;
                        end if;
                     end loop;
                  end loop;
               end loop;
            end if;
         end;
         <<Next_Prime>>
         null;
      end loop Prime_Loop;
   end Solve;
end Problem_49;
