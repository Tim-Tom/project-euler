package Rational is
   type Rat is private;
   function Create(num : in Long_Long_Integer; den : in Long_Long_Integer) return Rat;
   function Numerator(r : in Rat) return Long_Long_Integer;
   function Denomonator(r : in Rat) return Long_Long_Integer;

   function "+"  (left, right: in Rat) return Rat;
   function "-"  (left, right: in Rat) return Rat;
   function "*"  (left, right: in Rat) return Rat;
   function Inverse(r : in Rat) return Rat;
   function Normalize(r : in Rat) return Rat;

   procedure Inverse(r : in out Rat);
   procedure Add(left : in out Rat; right : in Rat);
   procedure Subtract(left : in out Rat; right : in Rat);
   procedure Multiply(left : in out Rat; right : in Rat);
   procedure Normalize(r : in out Rat);

   function ToString(r : in Rat) return String;
private
   type Rat is record
      numerator   : Long_Long_Integer;
      denomonator : Long_Long_Integer;
   end record;
end Rational;
