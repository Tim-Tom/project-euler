with Ada.Text_IO;
with Ada.Containers.Ordered_Maps;
package body Problem_14 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      type Collatz_Count is new Positive;
      package Integer_Map is new Ada.Containers.Ordered_Maps(Key_Type => Long_Long_Integer, Element_Type => Collatz_Count);
      table : Integer_Map.Map;
      function Next(current : in Long_Long_Integer) return Long_Long_Integer is
      begin
         if current mod 2 = 0 then -- even
            return current / 2;
         else
            return 3*current + 1;
         end if;
      end Next;
      function Collatz(start : in Long_Long_Integer) return Collatz_Count is
      begin
         if not table.Contains(start) then
            table.Insert(start, 1 + Collatz(Next(start)));
         end if;
         return table.Element(start);
      end;
      Max : Collatz_Count := 1;
      Max_Pos : Long_Long_Integer := 1;
   begin
      table.Insert(1, 1);
      for index in Long_Long_Integer(2) .. Long_Long_Integer(1_000_000) loop
         declare
            n : constant Collatz_Count := Collatz(index);
         begin
            if n > max then
               Max := n;
               Max_Pos := index;
            end if;
         end;
      end loop;
      IO.Put_Line(Long_Long_Integer'Image(Max_Pos) & " with a chain of " & Collatz_Count'Image(Max));
   end Solve;
end Problem_14;
