with Ada.Text_IO;
with Ada.Long_Long_Integer_Text_IO;
with PrimeInstances;
package body Problem_15 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      package Positive_Primes renames PrimeInstances.Positive_Primes;
      primes : constant Positive_Primes.Sieve := Positive_Primes.Generate_Sieve(40);
      type Factor_Array is Array (2 .. primes(primes'Last)) of Natural;
      function Factor_Factorial(num : in Integer) return Factor_Array is
         result : Factor_Array;
      begin
         for index in result'Range loop
            result(index) := 0;
         end loop;
         for const_number in 2 .. num loop
            declare
               number : Positive := const_number;
            begin
               for index in primes'Range loop
                  declare
                     prime : constant Positive := primes(index);
                  begin
                     while number mod prime = 0 loop
                        result(prime) := result(prime) + 1;
                        number := number / prime;
                     end loop;
                  end;
               end loop;
            end;
         end loop;
         return result;
      end Factor_Factorial;
      factor_40 : Factor_Array := Factor_Factorial(40);
      factor_20 : constant Factor_Array := Factor_Factorial(20);
      result : Long_Long_Integer := 1;
   begin
      for index in Factor_Array'Range loop
         factor_40(index) := factor_40(index) - 2*factor_20(index);
         if factor_40(index) > 0 then
            result := result * Long_Long_Integer(index**factor_40(index));
         end if;
      end loop;
      -- This problem is 40!/(20!20!).  I was too lazy to either write division for my bignums or write the routines
      -- that would factorize the numbers and cancel common factors.
      Ada.Long_Long_Integer_Text_IO.Put(result);
      IO.New_Line;
   end Solve;
end Problem_15;
