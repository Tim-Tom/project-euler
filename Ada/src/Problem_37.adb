with Ada.Text_IO;
with Ada.Integer_Text_IO;
with PrimeInstances;
with Ada.Containers.Ordered_Sets;

package body Problem_37 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   package Integer_Primes renames PrimeInstances.Integer_Primes;
   package Integer_Set is new Ada.Containers.Ordered_Sets(Integer);
   procedure Solve is
      gen : Integer_Primes.Prime_Generator := Integer_Primes.Make_Generator;
      primes : Integer_Set.Set;
      count : Natural := 0;
      sum : Integer := 0;
      prime : Integer;
   begin
      Integer_Primes.Next_Prime(gen, prime); primes.Insert(prime); -- 2
      Integer_Primes.Next_Prime(gen, prime); primes.Insert(prime); -- 3
      Integer_Primes.Next_Prime(gen, prime); primes.Insert(prime); -- 5
      Integer_Primes.Next_Prime(gen, prime); primes.Insert(prime); -- 7
      loop
         Integer_Primes.Next_Prime(gen, prime);
         exit when prime = 1;
         primes.Insert(prime);
         declare
            divisor : Integer := 10;
            All_Prime : Boolean := True;
         begin
            while divisor < prime loop
               if not primes.Contains(prime / divisor) or else not primes.Contains(prime mod divisor) then
                  All_Prime := False;
                  exit;
               end if;
               divisor := divisor * 10;
            end loop;
            if All_Prime then
               sum := sum + prime;
               count := count + 1;
               exit when count = 11;
            end if;
         end;
      end loop;
      I_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_37;
