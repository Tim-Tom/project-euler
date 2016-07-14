with Ada.Text_IO;
with Ada.Integer_Text_IO;
package body Problem_32 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   subtype Digit is Integer range 1 .. 9;
   remaining : Array(Digit) of Boolean;
   type Part_Name is (Multiplicand_Tens_Digit, Multiplicand_Units_Digit,
                  Multiplier_Hundreds_Digit, Multiplier_Tens_Digit, Multiplier_Units_Digit);
   parts : Array(Part_Name) of Digit;
   sum : Integer := 0;
   procedure Permute(part : Part_Name) is
   begin
      for d in Digit'Range loop
         if remaining(d) then
            remaining(d) := False;
            parts(part) := d;
            if part = Multiplier_Units_Digit then
               declare
                  multiplicand : constant Integer := 10*parts(Multiplicand_Tens_Digit) + parts(Multiplicand_Units_Digit);
                  multiplier : constant Integer := 100*parts(Multiplier_Hundreds_Digit) + 10*parts(Multiplier_Tens_Digit) + parts(Multiplier_Units_Digit);
                  product : constant Integer := multiplicand*multiplier;
                  product_thousands : constant Natural := product / 1000;
                  product_hundreds : constant Natural := (product / 100) mod 10;
                  product_tens : constant Natural := (product / 10) mod 10;
                  product_ones  : constant Natural := product mod 10;
               begin
                  if product < 10_000 and product_thousands > 0 and product_hundreds > 0 and product_tens > 0 and product_ones > 0 then
                     if remaining(product_thousands) and remaining(product_hundreds) and
                        remaining(product_tens) and  remaining(product_ones) then
                        if product_thousands /= product_hundreds and product_thousands /= product_tens and product_thousands /= product_ones and
                          product_hundreds /= product_tens and product_hundreds /= product_ones and
                          product_tens /= product_ones then
                           sum := sum + product;
                        end if;
                     end if;
                  end if;
               end;
            else
               Permute(Part_Name'Succ(part));
            end if;
            remaining(d) := True;
         end if;
      end loop;
   end Permute;
   procedure Solve is
   begin
      for d in Digit'Range loop
         remaining(d) := True;
      end loop;
      Permute(Multiplicand_Tens_Digit);
      I_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_32;
