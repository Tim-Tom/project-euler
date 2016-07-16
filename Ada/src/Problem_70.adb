with Ada.Text_IO;
with PrimeUtilities;

package body Problem_70 is
   package IO renames Ada.Text_IO;
   subtype Ten_Million is Integer range 1 .. 9_999_999;
   package Ten_Million_Primes is new PrimeUtilities(Ten_Million);
   type Digit_Count is Array(Character range '0' .. '9') of Natural;
   procedure Solve is
      sieve : constant Ten_Million_Primes.Sieve := Ten_Million_Primes.Generate_Sieve(Ten_Million'Last / 2);
      best : Ten_Million := 1;
      best_ratio : Long_Float := 0.0;
      function Convert(num : Ten_Million) return Digit_Count is
         str : constant String := Ten_Million'Image(num);
         counts : Digit_Count := (others => 0);
      begin
         for i in 2 .. str'Last loop
            counts(str(i)) := counts(str(i)) + 1;
         end loop;
         return counts;
      end Convert;
      procedure Check(num, euler : Ten_Million; ratio : Long_Float) is
         num_c : constant Digit_Count := Convert(num);
         euler_c : constant Digit_Count := Convert(euler);
      begin
         for c in num_c'Range loop
            if num_c(c) /= euler_c(c) then
               return;
            end if;
         end loop;
         best := num;
         best_ratio := ratio;
      end Check;
      procedure Solve_Recursive(min_index : Positive; start_ratio : Long_Float; start_euler, so_far : Ten_Million) is
         prime : Ten_Million;
         total : Ten_Million;
         euler : Ten_Million;
         ratio : Long_Float;
      begin
         for prime_index in min_index .. sieve'Last loop
            prime := sieve(prime_index);
            exit when Ten_Million'Last / prime < so_far;
            total := so_far * prime;
            euler := start_euler * (prime - 1);
            ratio := start_ratio * (1.0 - 1.0 / Long_Float(prime));
            exit when ratio < 0.1;
            loop
               if ratio > best_ratio then
                  Check(total, euler, ratio);
               end if;
               Solve_Recursive(prime_index + 1, ratio, euler, total);
               exit when Ten_Million'Last / prime < total;
               total := total * prime;
               euler := euler * prime;
            end loop;
         end loop;
      end Solve_Recursive;
   begin
      Solve_Recursive(sieve'First, 1.0, 1, 1);
      IO.Put_Line(Integer'Image(best));
   end Solve;

end Problem_70;
