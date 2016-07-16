with Ada.Text_IO;
with PrimeUtilities;

package body Problem_72 is
   package IO renames Ada.Text_IO;
   subtype One_Million is Long_Integer range 1 .. 1_000_000;
   package Million_Primes is new PrimeUtilities(One_Million);
   -- From Farey Sequence Wikipedia Page:
   -- Using the fact that |F1| = 2, we can derive an expression for the length of F_n:
   -- | F_n | = 1 + ∑(m = 1, n) φ(m).
   procedure Solve is
      count : Long_Integer := 0;
      sieve : constant Million_Primes.Sieve := Million_Primes.Generate_Sieve(One_Million'Last);
      procedure Solve_Recursive(min_index : Positive; start_euler, so_far : One_Million) is
         prime : One_Million;
         total : One_Million;
         euler : One_Million;
      begin
         for prime_index in min_index .. sieve'Last loop
            prime := sieve(prime_index);
            exit when One_Million'Last / prime < so_far;
            total := so_far * prime;
            euler := start_euler * (prime - 1);
            count := count + euler;
            loop
               Solve_Recursive(prime_index + 1, euler, total);
               exit when One_Million'Last / prime < total;
               total := total * prime;
               euler := euler * prime;
               count := count + euler;
            end loop;
         end loop;
      end Solve_Recursive;
   begin
      Solve_Recursive(sieve'First, 1, 1);
      IO.Put_Line(Long_Integer'Image(count));
   end Solve;
end Problem_72;
