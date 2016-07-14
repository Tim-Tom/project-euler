with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_18 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      num_rows : constant Positive := 15;
      cache : Array (1 .. num_rows) of Natural;
      input : IO.File_Type;
   begin
      for item in cache'Range loop
         cache(item) := 0;
      end loop;
      IO.Open(input, IO.In_File, "input/Problem_18.txt");
      for row in 1 .. num_rows loop
         declare
            current_row : Array (1 .. row) of Natural;
         begin
            -- Read in line
            for column in 1 .. row loop
               I_IO.Get(input, current_row(column), 0);
            end loop;
            -- If we go backwards through the row, it allows us to perform the
            -- replacement in memory instead of requiring a backup copy of the
            -- cache.
            for column in reverse 1 .. row loop
               declare
                  max     : Natural := 0;
                  from_right : constant Natural := cache(column) + current_row(column);
               begin
                  -- coming from left
                  if column > 1 then
                     max := cache(column - 1) + current_row(column);
                  end if;
                  -- coming from right
                  if from_right > max then
                     max := from_right;
                  end if;
                  cache(column) := max;
               end;
            end loop;
         end;
      end loop;
      declare
         max : Natural := 0;
      begin
         for item in cache'Range loop
            if cache(item) > max then
               max := cache(item);
            end if;
         end loop;
         I_IO.Put(max);
         IO.New_Line;
      end;
   end Solve;
end Problem_18;
