with Ada.Integer_Text_IO;
with Ada.Text_IO;
with PrimeInstances;
package body Problem_12 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      -- Since we're building these up sequentially, we can also build up the list of
      -- prime factors sequentially. We could probably do this more cheaply by moving up
      -- through the numbers instead of down, but it would require a lot more memory just
      -- to save us from a loop and division (or require us to generate and store the
      -- result for every bynber in our range), so I'm not sure it would end up being a
      -- victory. We store factors in two ways. The first is a linked list of factors,
      -- basically what the previous number was and what factor we used to get there. The
      -- second is a raw list of factors and counts. As a result we end up iterating
      -- through a bunch of factors that are probably empty when we generate the count,
      -- but it's still blazingly fast. To keep our lists a little smaller instead of
      -- generating the sieve for our full triangle numbers, we use the fact that triangle
      -- numbers are of the form n*(n-1)/2 and sum up the prime factors of both of them.
      package Integer_Primes renames PrimeInstances.Integer_Primes;
      sieve : constant Integer_Primes.Sieve := Integer_Primes.Generate_Sieve(15_000);
      subtype sieve_index is Positive range sieve'First .. sieve'Last;
      type Factor_Array is Array (sieve_index) of Positive;
      type Factor_Record is record
         arr: Factor_Array;
         max_index : sieve_index;
      end record;
      type Factor_Pointer is record
         last: Positive;
         idx : sieve_index;
         valid : Boolean;
      end record;
      type Factor_List is Array (1 .. sieve(sieve'Last)) of Factor_Pointer;
      function total_factors(factors1, factors2: in Factor_Record) return Positive is
         permutations : Positive := 1;
         max_prime_index : sieve_index;
      begin
         if factors1.max_index > factors2.max_index then
            max_prime_index := factors1.max_index;
         else
            max_prime_index := factors2.max_index;
         end if;
         for index in Factor_Array'First .. max_prime_index loop
            permutations := permutations * (factors1.arr(index) + factors2.arr(index) - 1);
         end loop;
         return permutations;
      end total_factors;
      procedure generate_factors(num : in Positive; all_factors : in out Factor_List; factors : in out Factor_Record ) is
         index : Positive := num;
      begin
         for prime_index in sieve'First .. factors.max_index loop
            factors.arr(prime_index) := 1;
         end loop;
         factors.max_index := 1;
         if all_factors(num).valid = false then
            for prime_index in sieve'Range loop
               declare
                  prime : constant Positive := sieve(prime_index);
               begin
                  if num mod prime = 0 then
                     all_factors(num) := (idx => prime_index, last => num / prime, valid => true);
                     exit;
                  end if;
               end;
            end loop;
         end if;
         loop
            declare
               f : Factor_Pointer renames all_factors(index);
            begin
               factors.arr(f.idx) := factors.arr(f.idx) + 1;
               if f.idx > factors.max_index then
                  factors.max_index := f.idx;
               end if;
               index := f.last;
               exit when index = 1;
            end;
         end loop;
      end generate_factors;
      all_factors : Factor_List;
      factors1, factors2 : Factor_Record;
      even : Boolean := true;
   begin
      all_factors := (2 => (last => 1, idx => 1, valid => true), others => (last => 1, idx => 1, valid => false));
      factors1 := (max_index => 1, arr => (others => 1));
      factors2 := (max_index => 1, arr => (others => 1));
      for x in 2 .. sieve(sieve'Last) loop
         if even then
            generate_factors(x / 2, all_factors, factors2);
            even := false;
         else
            generate_factors(x, all_factors, factors1);
            even := true;
         end if;
         if total_factors(factors1, factors2) > 500 then
            I_IO.Put(x * (x - 1) / 2);
            IO.New_Line;
            exit;
         end if;
      end loop;
   end Solve;
end Problem_12;
