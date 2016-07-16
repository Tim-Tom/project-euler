with Ada.Text_IO;
package body Problem_71 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      -- This problem is obviously pertaining to mediants, stern-brocot trees, and farey sequences.
      -- Specifically since we're doing constrained sequences, we're dealing with farey and we
      -- basically want to keep taking the mediant between two numbers over and over again until we
      -- get a denominator larger than our target.
      max : constant Integer := 1_000_000;
      a : Integer := 0;
      b : Integer := 1;
      c : constant Integer := 1;
      d : constant Integer := 3;
   begin
      while max - d > b loop
         a := a + c;
         b := b + d;
      end loop;
      IO.Put_Line(Integer'Image(a) & " / " & Integer'Image(b));
   end Solve;
end Problem_71;
