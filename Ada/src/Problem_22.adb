with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Strings.Bounded;
package body Problem_22 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      package bs is new Ada.Strings.Bounded.Generic_Bounded_Length(12);
      use bs;
      package bs_vector is new Ada.Containers.Vectors(Positive, bs.Bounded_String);
      package bs_sort is new bs_vector.Generic_Sorting;
      input : IO.File_Type;
      names : bs_vector.Vector;
      total : Natural := 0;
      function Sum_Letters(bounded : in bs.Bounded_String) return Positive is
         sum : Natural := 0;
         function Letter_Value(ch : in Character) return Positive is
         begin
            return Character'Pos(ch) - Character'Pos('A') + 1;
         end Letter_Value;
      begin
         for index in 1 .. bs.Length(bounded) loop
            sum := sum + Letter_Value(bs.Element(bounded, index));
         end loop;
         return sum;
      end;
      procedure Iterate_Names(Position : bs_vector.Cursor) is
      begin
         total := total + bs_vector.To_Index(Position) * Sum_Letters(bs_vector.Element(Position));
      end;
   begin
      IO.Open(input, IO.In_File, "names.txt");
      while not IO.End_Of_File(input) loop
         declare
            line : constant String := IO.Get_Line(input);
         begin
            names.Append(bs.To_Bounded_String(line));
         end;
      end loop;
      bs_sort.Sort(names);
      bs_vector.Iterate(names, Iterate_Names'Access);
      I_IO.Put(total);
      IO.New_Line;
   end Solve;
end Problem_22;
