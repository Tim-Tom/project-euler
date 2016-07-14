with Ada.Text_IO;
with BigInteger;
package body Problem_55 is
   package IO renames Ada.Text_IO;
   type Lychrel is (Unknown, True, False);
   Is_Lychrel_Cache : Array (Long_Long_Integer range 1 .. 10_000) of Lychrel := (others => Unknown);
   function Reverse_String(input : string) return String is
      result : string(input'Range);
   begin
      for i in input'range loop
         result(result'Last - i + input'First) := input(i);
      end loop;
      return result;
   end Reverse_String;
   function Is_Lychrel(num : Integer) return Boolean is
      function "+"(left, right : BigInteger.BigInt) return BigInteger.BigInt renames BigInteger."+";
      function Check_Lychrel(num : BigInteger.BigInt; count : Positive) return Lychrel is
         procedure Reverse_Big_Int(reversed : out BigInteger.BigInt; same : out Boolean) is
            str : constant String := BigInteger.ToString(num);
            rev : constant String := Reverse_String(str);
         begin
            if str = rev then
               same := True;
            else
               same := False;
               reversed := BigInteger.Create(rev);
            end if;
         end;
         reversed : BigInteger.BigInt;
         same : Boolean;
      begin
         if count = 50 then
            return False;
         else
            Reverse_Big_Int(reversed, same);
            if same then
               return True;
            else
               return Check_Lychrel(reversed + num, count + 1);
            end if;
         end if;
      end Check_Lychrel;
      function Check_Lychrel(num : Long_Long_Integer; count : Natural) return Lychrel is
         function Reverse_Num return Long_Long_Integer is
            part : Long_Long_Integer := num;
            reversed : Long_Long_Integer := 0;
         begin
            while part > 0 loop
               reversed := reversed * 10 + (part mod 10);
               part := part / 10;
            end loop;
            return reversed;
         end;
         function Insert_Cache(result : Lychrel) return Lychrel is
         begin
            if num <= Is_Lychrel_Cache'Last then
               Is_Lychrel_Cache(num) := result;
            end if;
            return result;
         end Insert_Cache;
      begin
         if num <= Is_Lychrel_Cache'Last and then Is_Lychrel_Cache(num) /= Unknown then
            return Is_Lychrel_Cache(num);
         elsif count = 50 then
            return Insert_Cache(False);
         else
            declare
               reversed : constant Long_Long_Integer := Reverse_Num;
            begin
               if count > 1 and reversed = num then
                  return True;
               elsif Long_Long_Integer'Last - num > reversed then
                     return Insert_Cache(Check_Lychrel(num + reversed, count + 1));
               else
                  return Check_Lychrel(BigInteger.Create(num) + BigInteger.Create(reversed), count + 1);
               end if;
            end;
         end if;
      end Check_Lychrel;
   begin
      case(Check_Lychrel(Long_Long_Integer(num), 0)) is
         when True =>
            return True;
         when False =>
            return False;
         when Others =>
            raise Constraint_Error;
      end case;
   end Is_Lychrel;
   procedure Solve is
      count : Natural := 0;
   begin
      for num in 1 .. 10_000 loop
         if Is_Lychrel(num) then
            count := count + 1;
         else
            null;
         end if;
      end loop;
      IO.Put(Natural'Image(count));
   end Solve;
end Problem_55;
