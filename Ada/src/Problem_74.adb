with Ada.Text_IO;
package body Problem_74 is
   package IO renames Ada.Text_IO;
   factorial_cache : constant Array(0 .. 9) of Integer := (1, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880);
   type count is new Integer range -1 .. 127;
   for count'size use 8;
   type count_cache_array is Array(Positive range <>) of count;
   max : constant := 999_999;
   cache_size : constant := 362_880 * 6;
   count_cache : count_cache_array(1 .. cache_size) := (169 => 3, 871 => 2, 872 => 2, 1454 => 3, 363_601 => 3, 45_361 => 2, 45362 => 2,  others => -1);
   sixty_count : Integer := 0;
   -- Dynamic programming brute force.  Make a 2 megabyte array of counts with sentinal value (-1)
   -- for values we haven't seen before. Then just go through all the numbers and get their
   -- count. We were told in the problem description that the the longest chain is 60, so we know
   -- our stack won't die under the recursion.
   procedure Solve is
      function next(num : Positive) return Positive is
         f : Natural := 0;
         r : Natural range 0 .. 9;
         d : Positive := num;
      begin
         loop
            r := d mod 10;
            f := f + factorial_cache(r);
            exit when d < 10;
            d := d / 10;
         end loop;
         return f;
      end next;
      function fill(num : Positive) return count is
         next_num : constant Positive := next(num);
      begin
         if count_cache(num) = -1 then
            if next_num = num then
               count_cache(num) := 1;
            else
               count_cache(num) := 0;
               count_cache(num) := fill(next_num) + 1;
            end if;
         end if;
         return count_cache(num);
      end fill;
   begin
      for n in 2 .. max loop
         if fill(n) = 60 then
            sixty_count := sixty_count + 1;
         end if;
      end loop;
      IO.Put_Line(Integer'Image(sixty_count));
   end Solve;
end Problem_74;
