with Ada.Text_IO;
with PrimeUtilities;
package body Problem_26 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      type one_thousand is new Integer range 1 .. 1_000;
      package Primes is new PrimeUtilities(one_thousand);
      type cycle is new Integer range 0 .. 999;
      type last_seen is new Integer range -1 .. 1_000;
      type memoizer is Array(cycle) of last_seen;
      gen : Primes.Prime_Generator := Primes.Make_Generator(1_000);
      prime : one_thousand;
      prime_cycle : cycle;
      best_cycle : cycle := 1;
      best_prime : one_thousand := 3;
      seen : memoizer;
      procedure find_cycle_length(prime : one_thousand; cycle_length : out cycle) is
         num : cycle := 1;
         current_count : last_seen := 0;
      begin
         for index in 0 .. cycle(prime - 1) loop
            seen(index) := -1;
         end loop;
         while seen(num) = -1 loop
            seen(num) := current_count;
            current_count := current_count + 1;
            num := cycle(Integer(num)*10 mod Integer(prime));
         end loop;
         cycle_length := cycle(current_count - seen(num));
      end find_cycle_length;
   begin
      loop
         Primes.Next_Prime(gen, prime);
         exit when prime = 1;
         find_cycle_length(prime, prime_cycle);
         if prime_cycle > best_cycle then
            best_cycle := prime_cycle;
            best_prime := prime;
         end if;
      end loop;
      IO.Put_Line(one_thousand'Image(best_prime));
   end Solve;
end Problem_26;
