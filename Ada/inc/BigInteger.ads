with Ada.Containers.Vectors;
package BigInteger is
   type BigInt is private;
   function Create(l : in Long_Long_Integer) return BigInt;
   function Create(s : in String) return BigInt;
   -- Two Big Ints
   function "+"  (Left, Right: in BigInt) return BigInt;
   function "-"  (Left, Right: in BigInt) return BigInt;
   function "*"  (Left, Right: in BigInt) return BigInt;
   function "**" (Left: in BigInt; Right: in Natural) return BigInt;
   function Magnitude(bi : in BigInt) return Positive;
   function ToString(bi : in BigInt) return String;
private
   package Int_Vector is new Ada.Containers.Vectors(Index_Type => Positive, Element_Type => Long_Long_Integer);
   type BigInt is record
      bits : Int_Vector.Vector;
      negative : Boolean;
   end record;
end BigInteger;
