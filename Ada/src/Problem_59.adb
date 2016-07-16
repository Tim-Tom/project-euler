with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Containers.Vectors;

package body Problem_59 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   package Character_Vector is new Ada.Containers.Vectors(Index_Type => Positive,
                                                          Element_Type => Character);
   procedure Solve is
      function Count_Input return Natural is
         input : IO.File_Type;
         count : Natural := 0;
         unused : Integer := 0;
      begin
         IO.Open(input, IO.In_File, "input/Problem_59.txt");
         while not IO.End_Of_File(input) loop
            I_IO.Get(input, unused);
            count := count + 1;
         end loop;
         IO.Close(input);
         return count;
      end;
      Length : constant Natural := Count_Input;
      type Byte is mod 2**8;
      type Text_Array is Array (1 .. Length) of Byte;
      type Key_Array is Array (1 .. 3) of Byte;
      encrypted : Text_Array;
      -- decrypted : Text_Array;
      procedure Read_Input(result : out Text_Array) is
         input : IO.File_Type;
      begin
         IO.Open(input, IO.In_File, "input/Problem_59.txt");
         for index in result'Range loop
            I_IO.Get(input, Natural(result(index)));
         end loop;
         IO.Close(input);
      end Read_Input;
      function Is_Valid(b : Byte) return Boolean is
      begin
         return (b >= 10 and then b <= 13) or else (b >= 32 and then b <= 126);
      end Is_Valid;
      pragma Pure_Function(Is_Valid);
      function Validate(encrypted : Text_Array; key: in Byte; offset : in Natural) return Boolean is
         index : Positive range Text_Array'Range := Text_Array'First + offset;
      begin
         loop
            if not Is_Valid(encrypted(index) xor key) then
               return False;
            end if;
            exit when index + Key_Array'Length > Text_Array'Last;
            index := index + Key_Array'Length;
         end loop;
         return True;
      end Validate;
      procedure Decrypt(encrypted : Text_Array; key : in Key_Array ; decrypted : out Text_Array) is
         current_key : Positive := key'First;
      begin
         for index in encrypted'Range loop
            decrypted(index) := encrypted(index) xor key(current_key);
            current_key := current_key + 1;
            if current_key > 3 then
               current_key := 1;
            end if;
         end loop;
      end Decrypt;
      valid_Characters : Array (Key_Array'Range) of Character_Vector.Vector;
      possible_solutions : Natural := 1;
   begin
      IO.Put_Line("GOD");
      return;
      Read_Input(encrypted);
      for ch in Character range 'a' .. 'z' loop
         for index in valid_Characters'Range loop
            if Validate(encrypted, Character'Pos(ch), index - 1) then
               valid_Characters(index).Append(ch);
            end if;
         end loop;
      end loop;
      for valid_Vector of valid_Characters loop
         possible_solutions := possible_solutions * Natural(valid_Vector.Length);
      end loop;
      if possible_solutions = 0 then
         IO.Put_Line("Unable to encounter a solution in printable ASCII");
         return;
      end if;
      declare
         solutions : Array (1 .. possible_solutions) of Text_Array;
      begin
         declare
            solution_index : Positive := solutions'First;
            key : Key_Array;
         begin
            for fst of valid_Characters(1) loop
               key(1) := Character'Pos(fst);
               for snd of valid_Characters(2) loop
                  key(2) := Character'Pos(snd);
                  for thd of valid_Characters(3) loop
                     key(3) := Character'Pos(thd);
                     Decrypt(encrypted, key, solutions(solution_index));
                     solution_index := solution_index + 1;
                  end loop;
               end loop;
            end loop;
         end;
         for solution_index in solutions'Range loop
            declare
               solution : Text_Array renames solutions(solution_index);
               combined : String(solution'Range);
            begin
               for index in solution'Range loop
                  combined(index) := Character'Val(solutions(solution_index)(index));
               end loop;
               IO.Put_Line(combined);
            end;
         end loop;
      end;
      IO.Put_Line("The Answer");
   end Solve;
end Problem_59;
