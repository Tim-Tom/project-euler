private with Ada.Containers.Vectors;

generic
   type Element_Type is private;

   with function "<=" (Left, Right : in Element_Type) return Boolean is <>;
package Heap is
   pragma Remote_Types;

   type Heap is private;

   Empty_Heap : constant Heap;

   procedure Insert(hp       : in out Heap;
                    element  : in Element_Type);
   procedure Remove(hp       : in out Heap);
   procedure Remove(hp       : in out Heap;
                    element  : out Element_Type);

   procedure Replace_Head(hp      : in out Heap;
                          Element : in Element_Type);

   function  Is_Empty(hp : in Heap) return Boolean;
   function  Peek(hp : in Heap) return Element_Type;

private
   pragma inline(Is_Empty);
   pragma inline(Peek);
   package Underlying_Vector is new Ada.Containers.Vectors(Index_Type  => Positive,
                                                           Element_Type => Element_Type);
   type Heap is Record
      vector : Underlying_Vector.Vector;
   end Record;
   Empty_Heap : constant Heap := (vector => Underlying_Vector.Empty_Vector);
end Heap;
