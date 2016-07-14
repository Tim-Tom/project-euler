with Ada.Text_IO;
with Ada.Containers.Vectors;
package body Problem_40 is
   package IO renames Ada.Text_IO;
   package Natural_Vector is new Ada.Containers.Vectors(Index_Type => Natural, Element_Type => Natural);
   procedure Solve is
      bases : Natural_Vector.Vector;
      procedure Digit_At(location: in Positive; digit : out Character) is
         domain : Natural := 0;
      begin
         if location > bases.Last_Element then
            loop
               declare
                  next_domain : constant Natural := Natural(bases.Last_Index) + 1;
                  count       : constant Positive := 10**next_domain - 10**(next_domain - 1);
               begin
                  bases.Append(count * next_domain + bases.Last_Element);
                  exit when location <= bases.Last_Element;
               end;
            end loop;
            domain := bases.Last_Index - 1;
         else
            declare
               use Natural_Vector;
               cursor : Natural_Vector.Cursor := bases.First;
            begin
               while cursor /= Natural_Vector.No_Element loop
                  exit when Natural_Vector.Element(cursor) > location;
                  domain := Natural_Vector.To_Index(cursor);
                  Natural_Vector.Next(cursor);
               end loop;
            end;
         end if;
         if domain = 0 then
            digit := Character'Val(location + Character'Pos('0'));
         else
            declare
               bounded_number : constant Natural := location - bases.Element(domain);
               stride         : constant Natural := domain + 1;
               position       : constant Natural := domain - bounded_number mod stride;
               number         : constant Natural := 10**domain + (bounded_number / stride);
               digit_num      : constant Natural := (number / 10**position) mod 10;
            begin
               digit := Character'Val(digit_num + Character'Pos('0'));
            end;
         end if;
      end Digit_At;
      type Positive_Array is Array(Positive range <>) of Positive;
      locations : constant Positive_Array := (1, 10, 100, 1_000, 10_000, 100_000, 1_000_000);
      result : String(locations'Range);
   begin
      bases.Append(0);
      bases.Append(10);
      for index in locations'Range loop
         Digit_At(locations(index), result(index));
      end loop;
      IO.Put_Line(result);
   end Solve;
end Problem_40;
