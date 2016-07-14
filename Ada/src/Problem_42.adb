with Ada.Text_IO;
with Ada.Containers.Ordered_Sets;
package body Problem_42 is
   -- The nth term of the sequence of triangle numbers is given by t_n = 1/2n(n+1);
   -- so the first ten triangle numbers are:
   --   1, 3, 6, 10, 15, 21, 28, 36, 45, 55
   --
   -- By converting each letter in a word to a number corresponding to its
   -- alphabetical position and adding these values we form a word value. For
   -- example, the word value for SKY is 19 + 11 + 25 = 55 = t_10. If the word
   -- value is a triangle number then we shall call the word a triangle word.
   --
   -- Using words.txt (right click and 'Save Link/Target As...'), a 16K text
   -- file containing nearly two-thousand common English words, how many are
   -- triangle words?
   package IO renames Ada.Text_IO;
   package Triangle_Set is new Ada.Containers.Ordered_Sets(Element_Type => Positive);
   procedure Solve is
      input : IO.File_Type;
      triangles : Triangle_Set.Set;
      max_triangle : Positive;
      max_triangle_index : Positive;
      sum : Natural := 0;
      triangle_count : Natural := 0;
      procedure Ensure_Triangles_To(max : Positive) is
      begin
         while max_triangle < max loop
            max_triangle_index := max_triangle_index + 1;
            max_triangle := max_triangle_index * (max_triangle_index + 1) / 2;
            triangles.Insert(max_triangle);
         end loop;
      end;
   begin
      triangles.Insert(1);
      max_triangle := 1;
      max_triangle_index := 1;
      IO.Open(input, IO.In_File, "input/Problem_42.txt");
      while not IO.End_Of_File(input) loop
         declare
            c : character;
         begin
            IO.Get(input, c);
            sum := sum + Character'Pos(c) - Character'Pos('A') + 1;
            if IO.End_Of_Line(input) then
               Ensure_Triangles_To(sum);
               if triangles.Contains(sum) then
                  triangle_count := Natural'Succ(triangle_count);
               end if;
               sum := 0;
            end if;
         end;
      end loop;
      IO.Put_Line(Natural'Image(triangle_count));
   end Solve;
end Problem_42;
