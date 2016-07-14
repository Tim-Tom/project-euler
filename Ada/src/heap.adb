with Ada.Containers; use Ada.Containers;
package body Heap is
   subtype index is Underlying_Vector.Extended_Index;
   procedure Insert(hp       : in out Heap;
                    element  : in Element_Type) is
   begin
      hp.vector.Append(element);
      declare
         current_loc : index := hp.vector.Last_Index;
      begin
         while current_loc > 1 loop
            declare
               parent_loc : constant index := current_loc / 2;
               parent : constant Element_Type := hp.vector.Element(current_loc / 2);
            begin
               exit when parent <= element;
               hp.vector.Swap(current_loc, parent_loc);
               current_loc := parent_loc;
            end;
         end loop;
      end;
   end Insert;
   procedure Remove(hp       : in out Heap) is
      element  : Element_Type;
   begin
      Remove(hp, element);
   end Remove;
   procedure Remove(hp       : in out Heap;
                    element  : out Element_Type) is
   begin
      if hp.vector.Is_Empty then
         raise Constraint_Error;
      end if;
      element := hp.vector.First_Element;
      if hp.vector.Length > 1 then
         hp.vector.Swap(hp.vector.First, hp.vector.Last);
         hp.vector.Delete_Last;
         declare
            parent_loc : index := hp.vector.First_Index;
            parent     : constant Element_Type := hp.vector.First_Element;
            begin
               loop
                  declare
                     left  : constant index := 2*parent_loc;
                     right : constant index := 2*parent_loc + 1;
                     smallest : index := parent_loc;
                  begin
                     if left <= hp.vector.Last_Index and then
                        hp.vector.Element(left) <= parent then
                        smallest := left;
                     end if;
                     if right <= hp.vector.Last_Index and then
                       hp.vector.Element(right) <= hp.vector.Element(smallest) then
                        smallest := right;
                     end if;
                     exit when smallest = parent_loc;
                     hp.vector.Swap(parent_loc, smallest);
                     parent_loc := smallest;
                  end;
               end loop;
            end;
         else
            hp.vector.Delete_Last;
      end if;
   end Remove;

   procedure Replace_Head(hp      : in out Heap;
                          element : in Element_Type) is
      current_loc : index;
   begin
      if hp.vector.Is_Empty then
         raise Constraint_Error;
      end if;
      current_loc := hp.vector.First_Index;
      hp.vector.Replace_Element(current_loc, element);
      while current_loc * 2 <= hp.vector.Last_Index loop
         declare
            min_child_loc : index := current_loc * 2;
         begin
            if min_child_loc < hp.vector.Last_Index then
               if hp.vector.Element(min_child_loc + 1) <=
                 hp.vector.Element(min_child_loc) then
                  min_child_loc := min_child_loc + 1;
               end if;
            end if;
            exit when element <= hp.vector.Element(min_child_loc);
            hp.vector.Swap(current_loc, min_child_loc);
            current_loc := min_child_loc;
         end;
      end loop;
   end Replace_Head;

   function Is_Empty(hp : in Heap) return Boolean is
   begin
      return hp.vector.Is_Empty;
   end Is_Empty;

   function Peek(hp : in Heap) return Element_Type is
   begin
      if hp.vector.Is_Empty then
         raise Constraint_Error;
      end if;
      return hp.vector.First_Element;
   end Peek;
end Heap;
