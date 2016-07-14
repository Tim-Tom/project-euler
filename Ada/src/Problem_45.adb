with Ada.Text_IO;
package body Problem_45 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      -- Hexagonal numbers are a subset of the triangle numbers so if
      -- it's a hexagonal number, it's also a triangle number.

      -- The problem description has us start at a non-unitary index.
      hexagonal_lead : Positive := 40_755;
      hexagonal_index : Positive := 143;
      pentagonal_lead : Positive := hexagonal_lead;
      pentagonal_index : Positive := 165;
      procedure Next_Hex is
      begin
         hexagonal_lead := hexagonal_lead + 4*hexagonal_index + 1;
         hexagonal_index := hexagonal_index + 1;
      end Next_Hex;
      procedure Next_Pent is
      begin
         pentagonal_lead := pentagonal_lead + 3*pentagonal_index + 1;
         pentagonal_index := pentagonal_index + 1;
      end Next_Pent;
   begin
      Next_Hex;
      Next_Pent;
      loop
         if hexagonal_lead > pentagonal_lead then
            Next_Pent;
         elsif hexagonal_lead < pentagonal_lead then
            Next_Hex;
         else
            exit;
         end if;
      end loop;
      IO.Put_Line(Positive'Image(hexagonal_lead));
   end Solve;
end Problem_45;
