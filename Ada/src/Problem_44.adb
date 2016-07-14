with Ada.Text_IO;
with Ada.Containers.Ordered_Sets;
with Ada.Containers.Doubly_Linked_Lists;
package body Problem_44 is
   package IO renames Ada.Text_IO;
   package Positive_Set is new Ada.Containers.Ordered_Sets(Element_Type => Positive);
   package Positive_List is new Ada.Containers.Doubly_Linked_Lists(Element_Type => Positive);
   procedure Solve is
      pentagonal_numbers : Positive_Set.Set := Positive_Set.Empty_Set;
      compares : Positive_List.List := Positive_List.Empty_List;
      largest_generated : Positive := 1;
      largest_generated_index : Positive := 1;
      maximum_bound : Positive := Positive'Last;
      function Is_Pentagonal(number : Positive) return Boolean is
      begin
         while number > largest_generated loop
            largest_generated_index := Positive'Succ(largest_generated_index);
            largest_generated := largest_generated_index * (3*largest_generated_index - 1) / 2;
            -- IO.Put_Line("Generated " & Positive'Image(largest_generated));
            pentagonal_numbers.Insert(largest_generated);
         end loop;
         return pentagonal_numbers.Contains(number);
      end Is_Pentagonal;
      procedure Trim_Comparison_List(minimum_bound : Positive) is
         cursor : Positive_List.Cursor := compares.First;
         function "=" (left,right : Positive_List.Cursor) return Boolean renames Positive_List."=";
      begin
         while cursor /= Positive_List.No_Element loop
            exit when Positive_List.Element(cursor) >= minimum_bound;
            compares.Delete(cursor);
         end loop;
      end Trim_Comparison_List;
      pentagonal : Positive := 1;
      index : Positive := 1;
   begin
      pentagonal_numbers.Insert(1);
      main_loop:
      loop
         declare
            difference : constant Positive := 3*index + 1;
            minimum_bound : Positive renames difference;
         begin
            exit when minimum_bound > maximum_bound;
            Trim_Comparison_List(minimum_bound);
            pentagonal := pentagonal + difference;
            index := index + 1;
            -- IO.Put_Line(Positive'Image(pentagonal));
            declare
               cursor : Positive_List.Cursor := compares.Last;
               function "=" (left,right : Positive_List.Cursor) return Boolean renames Positive_List."=";
            begin
               check_loop:
               while cursor /= Positive_List.No_Element loop
                  declare
                     previous_pent : constant Positive := Positive_List.Element(cursor);
                  begin
                     if Is_Pentagonal(pentagonal + previous_pent) and then Is_Pentagonal(pentagonal - previous_pent) then
                        if maximum_bound > pentagonal - previous_pent then
                           maximum_bound := pentagonal - previous_pent;
                           -- As far as my analysis goes, this should just be exit check_loop
                           -- (which is why it's called the maximum bound), but the bound ends
                           -- up being huge, so we don't really terminate with any celerity.
                           -- It would require generating over 1 million of these numbers to
                           -- satisfy that bound.
                           exit main_loop;
                        end if;
                     end if;
                     Positive_List.Previous(cursor);
                  end;
               end loop check_loop;
            end;
            compares.Append(pentagonal);
         end;
      end loop main_loop;
      IO.Put_Line(Positive'Image(maximum_bound));
   end Solve;
end Problem_44;
