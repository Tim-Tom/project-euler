with Ada.Text_IO;
package body Problem_43 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      subtype Digit is Natural range 0 .. 9;
      type Pandigital_Index is new Positive range 1 .. 10;
      Type Pandigital_Number is Array (Pandigital_Index) of Digit;
      sum : Long_Long_Integer := 0;
      number : Pandigital_Number;
      chosen : Array (Digit) of Boolean := (others => False);
      Primes : constant Array(Pandigital_Index) of Positive := (1,1,1,2,3,5,7,11,13,17);
      function Make_Number return Long_Long_Integer is
         result : Long_Long_Integer := 0;
      begin
         for index in number'Range loop
            result := result*10 + Long_Long_Integer(number(index));
         end loop;
         return result;
      end;
      procedure Permute(index : Pandigital_Index) is
      begin
         if index <= 3 then
            for d in Digit'Range loop
               if not chosen(d) then
                  number(index) := d;
                  chosen(d) := True;
                  Permute(Pandigital_Index'Succ(index));
                  chosen(d) := False;
               end if;
            end loop;
         else
            declare
               so_far : constant Positive := number(index - 2)*100 + number(index - 1)*10;
            begin
               for d in Digit'Range loop
                  if not chosen(d) and (so_far + d) mod Primes(index) = 0 then
                     number(index) := d;
                     if index = Pandigital_Index'Last then
                        sum := sum + Make_Number;
                     else
                        chosen(d) := True;
                        Permute(Pandigital_Index'Succ(index));
                        chosen(d) := False;
                     end if;
                  end if;
               end loop;
            end;
         end if;
      end Permute;
   begin
      Permute(Pandigital_Index'First);
      IO.Put_Line(Long_Long_Integer'Image(sum));
   end Solve;
end Problem_43;
