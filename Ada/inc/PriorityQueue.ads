private with Ada.Containers.Red_Black_Trees;
private with Ada.Finalization;
private with Ada.Streams;

generic
   type Priority (<>) is private;
   type Element_Type (<>) is private;

   with function "<" (Left, Right : Priority) return Boolean is <>;
   with function "=" (Left, Right : Priority) return Boolean is <>;
package PriorityQueue is
   pragma Preelaborate;
   pragma Remote_Types;

   type Queue is tagged private;
   pragma Preelaborable_Initialization (Queue);

   type Cursor is private;
   pragma Preelaborable_Initialization (Cursor);

   Empty_Queue : constant Set;

   No_Element : constant Cursor;

   function Is_Empty (Container : Set) return Boolean;
end PriorityQueue;
