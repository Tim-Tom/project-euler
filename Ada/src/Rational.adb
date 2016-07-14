package body Rational is
   function gcd(a_in, b_in : Long_Long_Integer) return Long_Long_Integer is
      a : Long_Long_Integer := a_in;
      b : Long_Long_Integer := b_in;
   begin
      if a = 0 then
         return b;
      end if;
      while b /= 0 loop
         if a > b then
            a := a - b;
         else
            b := b - a;
         end if;
      end loop;
      return a;
   end gcd;
   function Create(num : in Long_Long_Integer; den : in Long_Long_Integer) return Rat is
      r : Rat;
   begin
      r.numerator := num;
      r.denomonator := den;
      return r;
   end;
   function "+"  (left, right: in Rat) return Rat is
      result : Rat := left;
   begin
      Add(result, right);
      return result;
   end "+";
   function "-"  (left, right: in Rat) return Rat is
      result : Rat := left;
   begin
      Subtract(result, right);
      return result;
   end "-";
   function "*"  (left, right: in Rat) return Rat is
      result : Rat := left;
   begin
      Multiply(result, right);
      return result;
   end "*";
   function Inverse(r : in Rat) return Rat is
      result : Rat := r;
   begin
      Inverse(result);
      return result;
   end Inverse;
   procedure Inverse(r : in out Rat) is
      temp : constant Long_Long_Integer := r.numerator;
   begin
      r.numerator   := r.denomonator;
      r.denomonator := temp;
   end Inverse;
   procedure Add(left : in out Rat; right : in Rat) is
   begin
      left.numerator   := left.numerator * right.denomonator + right.numerator * left.denomonator;
      left.denomonator := left.denomonator * right.denomonator;
   end Add;
   procedure Subtract(left : in out Rat; right : in Rat) is
   begin
      left.numerator   := left.numerator * right.denomonator - right.numerator * left.denomonator;
      left.denomonator := left.denomonator * right.denomonator;
   end Subtract;
   procedure Multiply(left : in out Rat; right : in Rat) is
   begin
      left.numerator   := left.numerator * right.numerator;
      left.denomonator := left.denomonator * right.denomonator;
   end Multiply;
   function Numerator(r : in Rat) return Long_Long_Integer is
   begin
      return r.numerator;
   end Numerator;
   function Denomonator(r : in Rat) return Long_Long_Integer is
   begin
      return r.denomonator;
   end Denomonator;
   function Normalize(r : in Rat) return Rat is
      result : Rat := r;
   begin
      Normalize(result);
      return result;
   end;
   procedure Normalize(r : in out Rat) is
      g : constant Long_Long_Integer := gcd(r.numerator, r.denomonator);
   begin
      r.numerator   := r.numerator / g;
      r.denomonator := r.denomonator / g;
   end;
   function ToString(r : in Rat) return String is
   begin
      return Long_Long_Integer'Image(r.numerator) & " / " & Long_Long_Integer'Image(r.denomonator);
   end;
end Rational;

