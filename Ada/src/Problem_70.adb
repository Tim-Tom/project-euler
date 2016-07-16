with Ada.Text_IO;
with PrimeUtilities;

package body Problem_70 is
   package IO renames Ada.Text_IO;
   subtype Ten_Million is Integer range 1 .. 9_999_999;
   package Ten_Million_Primes is new PrimeUtilities(Ten_Million);
   type Long_Sieve is Array (Positive range <>) of Long_Float;
   type Digit_Count is Array(Character range '0' .. '9') of Natural;
   Max_Double : constant := Long_Float(Ten_Million'Last);
   
   function Make_Long_Float_Sieve return Long_Sieve is
      old_sieve : constant Ten_Million_Primes.Sieve := Ten_Million_Primes.Generate_Sieve(Ten_Million'Last / 2);
      new_sieve : Long_Sieve(1 .. old_sieve'Last);
   begin
      for i in new_sieve'Range loop
         new_sieve(i) := Long_Float(old_sieve(i));
      end loop;
      return new_sieve;
   end Make_Long_Float_Sieve;
   
   procedure Solve is
      sieve : constant Long_Sieve := Make_Long_Float_Sieve;
      best : Ten_Million := 1;
      best_ratio : Long_Float := 0.0;
      function Convert(num : Long_Float) return Digit_Count is
         num_cnv : constant Ten_Million := Ten_Million(Long_Float'Rounding(num));
         str : constant String := Ten_Million'Image(num_cnv);
         counts : Digit_Count := (others => 0);
      begin
         for i in 2 .. str'Last loop
            counts(str(i)) := counts(str(i)) + 1;
         end loop;
         return counts;
      end Convert;
      procedure Check(num, ratio : Long_Float) is
         euler : constant Long_Float := num * ratio;
         num_c : constant Digit_Count := Convert(num);
         euler_c : constant Digit_Count := Convert(euler);
      begin
         for c in num_c'Range loop
            if num_c(c) /= euler_c(c) then
               return;
            end if;
         end loop;
         best := Ten_Million(Long_Float'Rounding(num));
         best_ratio := ratio;
      end Check;
      procedure Solve_Recursive(min_index : Positive; start_ratio : Long_Float; So_Far : Long_Float) is
         prime : Long_Float;
         total : Long_Float;
         ratio : Long_Float;
      begin
         for prime_index in min_index .. sieve'Last loop
            prime := sieve(prime_index);
            total := So_Far * prime;
            ratio := start_ratio * ((prime - 1.0) / prime);
            exit when total > Max_Double or ratio < 0.1;
            loop
               if ratio > best_ratio then
                  Check(total, ratio);
               end if;
               Solve_Recursive(prime_index + 1, ratio, total);
               total := total * prime;
               exit when total > Max_Double;
            end loop;
         end loop;
      end Solve_Recursive;
   begin
      Solve_Recursive(sieve'First, 1.0, 1.0);
      IO.Put_Line(Integer'Image(best));
   end Solve;

end Problem_70;
