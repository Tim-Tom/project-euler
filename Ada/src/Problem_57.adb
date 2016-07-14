with Ada.Text_IO;
with BigInteger;
package body Problem_57 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      use BigInteger;
      -- The numerator and denomonatoir of an infinite continued fraction
      -- is given by the recurrance relations
      -- h_n = a_n*h_n-1 + h_n-2
      -- k_n = a_n*k_n-1 + h_n-2
      limit : constant := 1_000;
      h_2 : BigInt := Create(1);
      h_1 : BigInt := Create(3);
      h   : BigInt;
      k_2 : BigInt := Create(1);
      k_1 : BigInt := Create(2);
      k   : BigInt;
      two : constant BigInt := Create(2);
      count : Natural := 0;
   begin
      for i in 2 .. limit loop
         h := two * h_1 + h_2;
         k := two * k_1 + k_2;
         if Magnitude(h) > Magnitude(k) then
            count := count + 1;
         end if;
         h_2 := h_1;
         h_1 := h;
         k_2 := k_1;
         k_1 := k;
      end loop;
      IO.Put_Line(Natural'Image(count));
   end Solve;
end Problem_57;
