with Ada.Text_IO;
package body Problem_48 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      type Unsigned is mod 2**32;
      function modular_pow(base, exponent, modulus : Unsigned) return Unsigned is
         result : Unsigned := 1;
         base_mod : Unsigned := base;
         exponent_mod : Unsigned := exponent;
      begin
         while exponent_mod > 0 loop
            if (exponent_mod and 1) = 1 then
               result := (result * base_mod) mod modulus;
            end if;
            exponent_mod := exponent_mod / 2;
            base_mod := (base_mod**2) mod modulus;
         end loop;
         return result;
      end modular_pow;
      sum : Unsigned := 0;
   begin
      for num in 1 .. Unsigned(1_000) loop
         sum := (sum + modular_pow(num, num, 1_000_000_000)) mod 1_000_000_000;
      end loop;
      IO.Put_Line(Unsigned'Image(sum));
   end Solve;
end Problem_48;
