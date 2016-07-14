with Ada.Containers.Vectors;
package body PrimeUtilities is
   package Num_Vector is new Ada.Containers.Vectors(Index_Type => Positive, Element_Type => Num);
   function "<="  (Left, Right: in Virtual_List) return Boolean is
   begin
      return Left.Next_Composite <= Right.Next_Composite;
   end "<=";
   function Make_Generator(Max_Prime : Num := Num'Last) return Prime_Generator is
      gen : Prime_Generator;
   begin
      gen.Filters    := Virtual_List_Heap.Empty_Heap;
      gen.Last_Prime := 1;
      gen.Max_Prime  := Max_Prime;
      gen.Increment  := 2;
      gen.Done       := False;
      return gen;
   end Make_Generator;
   procedure Next_Prime(gen : in out Prime_Generator; prime : out Num) is
   begin
      if gen.Done then
         prime := 1;
      elsif gen.Last_Prime < 5 then
         -- Need to manually add 2,3, and 5 to seed our wheel
         if gen.Last_Prime = 1 then
            gen.Last_Prime := 2;
         elsif gen.Last_Prime = 2 then
            gen.Last_Prime := 3;
         elsif gen.Last_Prime = 3 then
            gen.Last_Prime := 5;
            if gen.Max_Prime >= 25 then
               declare
                  vlist : constant Virtual_List := (Next_Composite => 25,
                                                    Increment      => 10);
               begin
                  Virtual_List_Heap.Insert(gen.Filters, vlist);
               end;
            end if;
         end if;
         if gen.Last_Prime <= gen.Max_Prime then
            prime := gen.Last_Prime;
         else
            gen.Done := True;
            prime := 1;
         end if;
      else
         -- Normal operation.  Our numbers are generated using the fact that the
         -- only numbers that are not divisible by 2 and 3 are of the form
         -- 6n + 1 and 6n + 5.  Those can be found by alternatively incrementing
         -- by 4 and 2 from the previous number.
<<Next_Prime>>
         -- check if the next number we would generate is greater than the
         -- maximum we were given.  We have to do this through subtraction
         -- to ensure that we don't overflow the integer.
         if gen.Max_Prime - Num(gen.Increment) < gen.Last_Prime then
            gen.Done := True;
            prime := 1;
            return;
         end if;
         -- Generate the next possible prime.
         gen.Last_Prime := gen.Last_Prime + Num(gen.Increment);
         -- Swaps 4 and 2 which are our two possible incrementors
         gen.Increment := gen.Increment xor 6;
         -- Check against our filters
         if not Virtual_List_Heap.Is_Empty(gen.Filters) then
            declare
               vlist : Virtual_List := Virtual_List_Heap.Peek(gen.Filters);
            begin
               if gen.Last_Prime = vlist.Next_Composite then
                  -- Move all the primes whose virtual list heads are at the
                  -- current composite to the next element in their list.
                  loop
                     -- Make sure the next element in the virtual list is
                     -- in our range.
                     if gen.Max_Prime - vlist.Increment < vlist.Next_Composite then
                        -- IO.Put_Line(Num'Image(vlist.Next_Composite) & " + " & Num'Image(vlist.Increment) & " > " & Num'Image(gen.Max_Prime));
                        Virtual_List_Heap.Remove(gen.Filters);
                     else
                        vlist.Next_Composite := vlist.Next_Composite + vlist.Increment;
                        if vlist.Increment mod 4 = 0 then
                           vlist.Increment := vlist.Increment / 2;
                        else
                           vlist.Increment := vlist.Increment * 2;
                        end if;
                        Virtual_List_Heap.Replace_Head(gen.Filters, vlist);
                     end if;
                     if Virtual_List_Heap.Is_Empty(gen.Filters) then
                        vlist.Next_Composite := 1;
                     else
                        vlist := Virtual_List_Heap.Peek(gen.Filters);
                     end if;
                     exit when gen.Last_Prime /= vlist.Next_Composite;
                  end loop;
                  goto Next_Prime;
               end if;
            end;
         end if;
         -- It didn't match any of our filters, so it must be a prime!
         prime := gen.Last_Prime;
         -- Create a new virtual list for the prime.
         if gen.Last_Prime <= gen.Max_Prime / gen.Last_Prime then
            declare
               vlist : constant Virtual_List := (Next_Composite => gen.Last_Prime ** 2,
                                                 Increment      => gen.Last_Prime * Num(gen.Increment));
            begin
               Virtual_List_Heap.Insert(gen.Filters, vlist);
            end;
         end if;
      end if;
   end Next_Prime;
   function Generate_Sieve(Max_Prime : Num) return Sieve is
      primes : Num_Vector.Vector;
      gen : Prime_Generator := Make_Generator(Max_Prime);
      prime : Num;
   begin
      loop
         Next_Prime(gen, prime);
         exit when prime = 1;
         primes.Append(prime);
      end loop;
      declare
         s : Sieve(1 .. Positive(primes.Length));
      begin
         for index in s'Range loop
            s(index) := primes.Element(index);
         end loop;
         return s;
      end;
   end Generate_Sieve;
   function Generate_Prime_Factors(n : Num; primes : Sieve) return Prime_Factors is
      quotient : Num := n;
      num_factors : Natural := 0;
   begin
      for prime_index in primes'Range loop
         exit when primes(prime_index) > n;
         if n mod primes(prime_index) = 0 then
            num_factors := Natural'Succ(num_Factors);
         end if;
      end loop;
      declare
         factors : Prime_Factors (1 .. num_factors);
         factor_index : Positive := 1;
      begin
         for prime_index in primes'Range loop
            declare
               prime : constant Num := primes(prime_index);
               count : Natural := 0;
            begin
               if quotient mod prime = 0 then
                  loop
                     count := count + 1;
                     quotient := quotient / prime;
                     exit when quotient mod prime /= 0;
                  end loop;
                  factors(factor_index).prime := prime;
                  factors(factor_index).count := count;
                  exit when factor_index = factors'Last;
                  factor_index := factor_index + 1;
               end if;
            end;
         end loop;
         return factors;
      end;
   end Generate_Prime_Factors;
   function Count_Divisors(factors : Prime_Factors) return Positive is
      count : Positive := 1;
   begin
      for index in factors'Range loop
         count := count * (factors(index).count + 1);
      end loop;
      count := count - 1;
      return count;
   end Count_Divisors;
   function Generate_Proper_Divisors(factors : Prime_Factors) return Proper_Divisors is
      Num_Proper_Divisors : constant Positive := Count_Divisors(factors);
      divisors : Proper_Divisors(1 .. Num_Proper_Divisors);
      current_divisor : Positive := 1;
      procedure Generate_Multiplicative_Permutation(factor_index : Positive; current : Num) is
      begin
         if factor_index > factors'Last then
            if current_divisor <= divisors'Last then
               divisors(current_divisor) := current;
               current_divisor := current_divisor + 1;
            end if;
         else
            declare
               mutated : Num := current;
            begin
               Generate_Multiplicative_Permutation(factor_index + 1, mutated);
               for unused in 1 .. factors(factor_index).count loop
                  mutated := mutated * factors(factor_index).prime;
                  Generate_Multiplicative_Permutation(factor_index + 1, mutated);
               end loop;
            end;
         end if;
      end Generate_Multiplicative_Permutation;
   begin
      Generate_Multiplicative_Permutation(1, 1);
      return divisors;
   end Generate_Proper_Divisors;
   function Generate_Proper_Divisors(n : Num; primes : sieve) return Proper_Divisors is
   begin
      return Generate_Proper_Divisors(Generate_Prime_Factors(n, primes));
   end Generate_Proper_Divisors;
   function Generate_Proper_Divisors(n : Num) return Proper_Divisors is
   begin
      return Generate_Proper_Divisors(Generate_Prime_Factors(n, Generate_Sieve(n)));
   end Generate_Proper_Divisors;
end PrimeUtilities;
