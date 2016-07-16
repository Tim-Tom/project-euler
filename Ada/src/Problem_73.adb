with Ada.Text_IO;
package body Problem_73 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      max : constant := 12_000;
      -- Start with the first two numbers in the sequence (it's easy to know that because the first
      -- one after 0 is 1 / max). Then generate successive elements in the sequence by using the
      -- mediant formula and solving for the new c/d.
      a,b,c,d,k : Integer;
      -- Temporary variables.
      c2, d2 : Integer;
      count : Long_Integer := 0;
      counting : Boolean := false;
   begin
      a := 0;
      b := 1;
      c := 1;
      d := max;
      while c <= max loop
         if counting then
            exit when a = 1 and b = 2;
            count := count + 1;
         end if;
         if a = 1 and b = 3 then
            counting := true;
         end if;
         k := (max + b) / d;
         c2 := k * c - a;
         d2 := k * d - b;
         a := c;
         b := d;
         c := c2;
         d := d2;
      end loop;
      IO.Put_Line(Long_Integer'Image(count));
   end Solve;
end Problem_73;
