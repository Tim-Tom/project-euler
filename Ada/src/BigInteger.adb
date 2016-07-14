-- with Ada.Containers.Vectors;
-- with Ada.Text_IO;
with Ada.Long_Long_Integer_Text_IO;
with Ada.Strings;
with Ada.Strings.Bounded;
with Ada.Containers; use Ada.Containers;
-- Note that this package currently only handles positive numbers.
package body BigInteger is
   use BigInteger.Int_Vector;
   -- Sadly we can't use this in our type because the compiler doesn't support
   -- modular types greater than 2**32.  We have chosen a power of ten for now
   -- because it allows us to give a base 10 printed representation without
   -- needing to implement division.
   Base : constant Long_Long_Integer := 1_000_000_000_000_000_000;
   -- Used in multiplication to split the number into two halves
   Half_Base : constant Long_Long_Integer := 1_000_000_000;
   function Create(l : in Long_Long_Integer) return BigInt is
      bi : BigInt;
      num : Long_Long_Integer := l;
   begin
      -- The given Long_Long_Integer can be larger than our base, so we need
      -- to normalize it.
      if num >= Base then
         bi.bits.append(num mod Base);
         num := num / Base;
      end if;
      bi.bits.append(num);
      return bi;
   end Create;
   function Create(s : in String) return BigInt is
      bi : BigInt := Create(0);
      multiplier : BigInt := Create(1);
   begin
      for index in reverse s'Range loop
         declare
            c : constant Character := s(index);
         begin
            case c is
            when '0' .. '9' =>
               declare
                  value : constant Long_Long_Integer := Character'Pos(c) - Character'Pos('0');
               begin
                  bi := bi + multiplier * Create(value);
                  if index > 0 then
                     multiplier := multiplier * Create(10);
                  end if;
               end;
            when others =>
               null;
            end case;
         end;
      end loop;
      return bi;
   end Create;
   function "+" (Left, Right: in BigInt) return BigInt is
      result : BigInt;
      carry  : Long_Long_Integer := 0;
   begin
      -- Normalize the input such that |left.bits| >= |right.bits|
      if Right.bits.Length > Left.bits.Length then
         return Right + Left;
      end if;
      result.bits := Int_Vector.Empty_Vector;
      result.negative := False;
      -- Sum all the bits that the numbers have in common.
      for index in 1 .. Integer(Right.bits.Length) loop
         carry := carry + Left.bits.Element(index) + Right.bits.Element(index);
         if carry >= Base then
            result.bits.Append(carry - Base);
            carry := 1;
         else
            result.bits.Append(carry);
            carry := 0;
         end if;
      end loop;
      -- Append all the bits that the left number has that the right number
      -- does not (remembering to continue the carry)
      for index in Integer(Right.bits.Length + 1) .. Integer(Left.bits.Length) loop
         carry := carry + Left.bits.Element(index);
         if carry >= Base then
            result.bits.append(carry - Base);
            carry := 1;
         else
            result.bits.append(carry);
            carry := 0;
         end if;
      end loop;
      -- Finally remember to add an extra '1' to the result if we ended up with
      -- a carry bit.
      if carry /= 0 then
         result.bits.append(carry);
      end if;
      return result;
   end "+";
   function "-" (Left, Right: in BigInt) return BigInt is
      result : BigInt;
      carry_in : Long_Long_Integer := 0;
   begin
      -- Currently always assuming |left| >= |right|
      result.bits := Int_Vector.Empty_Vector;
      result.negative := False;
      -- Subtract all the bits they have in common
      for index in 1 .. Integer(Right.bits.Length) loop
         carry_in := Left.bits.Element(index) - Right.bits.Element(index) - carry_in;
         if carry_in < 0 then
            result.bits.Append(Base + carry_in);
            carry_in := 1;
         else
            result.bits.Append(carry_in);
            carry_in := 0;
         end if;
      end loop;
      -- Subtract the carry from any remaining bits in Left as neccessary
      for index in Integer(Right.bits.Length + 1) .. Integer(Left.bits.Length) loop
         carry_in := Left.bits.Element(index) - carry_in;
         if carry_in < 0 then
            result.bits.Append(Base + carry_in);
            carry_in := 1;
         else
            result.bits.Append(carry_in);
            carry_in := 0;
         end if;
      end loop;
      -- Handle left over carry bit
      -- Todo: We don't handle this right now
      return result;
   end "-";
   function "*" (Left, Right: in BigInt) return BigInt is
      result : BigInt;
      Intermediate : Long_Long_Integer;
      Temporary : Long_Long_Integer;
      carry : Long_Long_Integer := 0;
      double_carry : Boolean;
   begin
      -- Normalize the input such that |left.bits| >= |right.bits|
      if Right.bits.Length > Left.bits.Length then
         return Right * Left;
      end if;
      result.bits := Int_Vector.Empty_Vector;
      result.negative := False;
      -- Multiplication is done by splitting the Left and Right base units into
      -- two half-base units representing the upper and lower bits of the
      -- number.  These portions are then multiplied pairwise
      for left_index in 1 .. Integer(Left.bits.Length) loop
         if Left.bits.Element(left_index) = 0 then
            goto Next_Left;
         end if;
         declare
            Left_Lower : constant Long_Long_Integer := Left.bits.Element(left_index) mod Half_Base;
            Left_Upper : constant Long_Long_Integer := Left.bits.Element(left_index) / Half_Base;
         begin
            for right_index in 1 .. Integer(Right.bits.Length) loop
               if Right.bits.Element(right_index) = 0 then
                  goto Next_Right;
               end if;
               declare
                  Right_Lower : constant Long_Long_Integer := Right.bits.Element(right_index) mod Half_Base;
                  Right_Upper : constant Long_Long_Integer := Right.bits.Element(right_index) / Half_Base;
                  result_index : constant Integer := left_index + right_index - 1;
               begin
                  double_carry := False;
                  if Integer(result.bits.Length) > result_index then
                     carry := result.bits.Element(result_index + 1);
                     intermediate := result.bits.Element(result_index);
                  elsif Integer(result.bits.Length) >= result_index then
                     carry := 0;
                     intermediate := result.bits.Element(result_index);
                  else
                     carry := 0;
                     intermediate := 0;
                     while Integer(result.bits.Length) < result_index loop
                        result.bits.Append(0);
                     end loop;
                  end if;
                  -- Left_Lower * Right_Lower
                  Intermediate := Intermediate + Left_Lower * Right_Lower;
                  if Intermediate >= Base then
                     Intermediate := Intermediate - Base;
                     carry := carry + 1;
                     if carry = Base then
                        carry := 0;
                        double_carry := True;
                     end if;
                  end if;
                  -- Left_Lower * Right_Upper
                  Temporary := Left_Lower * Right_Upper;
                  if Temporary >= Half_Base then
                     Intermediate := Intermediate + (Temporary mod Half_Base) * Half_Base;
                     carry := carry + (Temporary / Half_Base);
                     if carry >= Base then
                        carry := carry - Base;
                        double_carry := True;
                     end if;
                  else
                     Intermediate := Intermediate + Temporary * Half_Base;
                  end if;
                  if Intermediate >= Base then
                     Intermediate := Intermediate - Base;
                     carry := carry + 1;
                     if carry = Base then
                        carry := 0;
                        double_carry := True;
                     end if;
                  end if;
                  -- Left_Upper * Right_Lower
                  Temporary := Left_Upper * Right_Lower;
                  if Temporary >= Half_Base then
                     Intermediate := Intermediate + (Temporary mod Half_Base) * Half_Base;
                     carry := carry + (Temporary / Half_Base);
                     if carry >= Base then
                        carry := carry - Base;
                        double_carry := True;
                     end if;
                  else
                     Intermediate := Intermediate + Temporary * Half_Base;
                  end if;
                  if Intermediate >= Base then
                     Intermediate := Intermediate - Base;
                     carry := carry + 1;
                     if carry = Base then
                        carry := 0;
                        double_carry := True;
                     end if;
                  end if;
                  result.bits.Replace_Element(result_index, Intermediate);
                  -- Left_Upper * Right_Upper
                  carry := carry + Left_Upper * Right_Upper;
                  if double_carry then
                     if Integer(result.bits.Length) >= result_index + 2 then
                        result.bits.Replace_Element(result_index + 2,
                                                    result.bits.Element(result_index + 2) + 1);
                     else
                        result.bits.Append(1);
                     end if;
                     -- If we have a double carry, we know we had at least
                     -- result_index + 1 elements in our vector because
                     -- otherwise we wouldn't have overflown the carry capacity.
                     result.bits.Replace_Element(result_index + 1, carry);
                  elsif carry > 0 then
                     if Integer(result.bits.Length ) > result_index then
                        result.bits.Replace_Element(result_index + 1, carry);
                     else
                        result.bits.Append(carry);
                     end if;
                  end if;
               end;
               <<Next_Right>>
               null;
            end loop;
         end;
         <<Next_Left>>
         null;
      end loop;
      return result;
   end "*";
   function "**"(Left : in BigInt; Right: in Natural) return BigInt is
      result : BigInt := Create(1);
      current_base : BigInt := Left;
      current_exponent : Long_Long_Integer := Long_Long_Integer(Right);
   begin
      while current_exponent > 0 loop
         if current_exponent mod 2 = 0 then
            current_base := current_base * current_base;
            current_exponent := current_exponent / 2;
         else
            result := result * current_base;
            current_exponent := current_exponent - 1;
         end if;
      end loop;
      return result;
   end;

   function Magnitude(bi : in BigInt) return Positive is
      function Log10(n : Long_Long_Integer) return Positive is
      begin
         if    n >= 100_000_000_000_000_000 then
            return 18;
         elsif n >=  10_000_000_000_000_000 then
            return 17;
         elsif n >=   1_000_000_000_000_000 then
            return 16;
         elsif n >=     100_000_000_000_000 then
            return 15;
         elsif n >=      10_000_000_000_000 then
            return 14;
         elsif n >=       1_000_000_000_000 then
            return 13;
         elsif n >=         100_000_000_000 then
            return 12;
         elsif n >=          10_000_000_000 then
            return 11;
         elsif n >=           1_000_000_000 then
            return 10;
         elsif n >=             100_000_000 then
            return 9;
         elsif n >=              10_000_000 then
            return 8;
         elsif n >=               1_000_000 then
            return 7;
         elsif n >=                 100_000 then
            return 6;
         elsif n >=                  10_000 then
            return 5;
         elsif n >=                   1_000 then
            return 4;
         elsif n >=                     100 then
            return 3;
         elsif n >=                      10 then
            return 2;
         else
            return 1;
         end if;
      end Log10;
      mag : constant Positive := Log10(bi.bits.Last_Element) + Natural(bi.bits.Length - 1) * 18;
   begin
      return mag;
   end Magnitude;

   function ToString(bi : in BigInt) return String is
   begin
      if bi.bits.Length > 0 then
         declare
            package Bounded is new Ada.Strings.Bounded.Generic_Bounded_Length(Integer(bi.bits.Length) * 18);
            bs : Bounded.Bounded_String := Bounded.Null_Bounded_String;
            temporary : String (1 .. 18);
         begin
            Ada.Long_Long_Integer_Text_IO.Put(temporary, bi.bits.Element(Integer(bi.bits.Length)));
            Bounded.Append(bs, temporary);
            Bounded.Trim(bs, Ada.Strings.Left);
            for index in reverse 1 .. Integer(bi.bits.Length - 1) loop
               Ada.Long_Long_Integer_Text_IO.Put(temporary, bi.bits.Element(index));
               for ch_in in temporary'Range loop
                  if temporary(ch_in) = ' ' then
                     temporary(ch_in) := '0';
                  else
                     exit;
                  end if;
               end loop;
               Bounded.Append(bs, temporary);
            end loop;
            return Bounded.To_String(bs);
         end;
      else
         return "0";
      end if;
   end;
end BigInteger;

