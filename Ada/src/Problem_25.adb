with Ada.Text_IO;
with BigInteger; use BigInteger;
package body Problem_25 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      term : Positive := 3;
      n   : BigInt := BigInteger.Create(2);
      n_1 : BigInt := BigInteger.Create(1);
      n_2 : BigInt := BigInteger.Create(1);
   begin
      while Magnitude(n) < 1_000 loop
         term := term + 1;
         n_2 := n_1;
         n_1 := n;
         n := n_1 + n_2;
      end loop;
      IO.Put_Line(Positive'Image(term));
   end Solve;
end Problem_25;
