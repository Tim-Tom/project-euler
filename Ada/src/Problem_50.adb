with Ada.Text_IO;
with PrimeInstances;

package body Problem_50 is
   package IO renames Ada.Text_IO;
   package Positive_Primes renames PrimeInstances.Positive_Primes;
   procedure Solve is
      sieve : constant Positive_Primes.Sieve := Positive_Primes.Generate_Sieve(1_000_000);
      is_Prime : Array(2 .. sieve(sieve'Last)) of Boolean := (others => false);
      start_value : Natural := 0;
      max_length : Natural := 0;
   begin
      for index in sieve'Range loop
         is_Prime(sieve(index)) := true;
         if start_value + sieve(index) < is_Prime'Last then
            start_value := start_value + sieve(index);
            max_length := index;
         end if;
      end loop;
      -- Start at the longest length we can and scale down. This allows us to
      -- immediately break when we encounter a valid construct.
      search:
      for length in reverse 1 .. max_length loop
         declare
            value : Natural := start_value;
         begin
            for index in length .. sieve'Last loop
               if index /= length then
                  value := value - sieve(index - length) + sieve(index);
               end if;
               exit when value > is_Prime'Last;
               if is_Prime(value) then
                  IO.Put(Natural'Image(value));
                  declare
                     first : Boolean := true;
                  begin
                     for join_index in index - length + 1 .. index loop
                        if first then
                           IO.Put(" =");
                           first := false;
                        else
                           IO.Put(" +");
                        end if;
                        IO.Put(Natural'Image(sieve(join_index)));
                     end loop;
                  end;
                  IO.New_Line;
                  exit search;
               end if;
            end loop;
         end;
         start_value := start_value - sieve(length);
      end loop search;
   end Solve;
end Problem_50;
