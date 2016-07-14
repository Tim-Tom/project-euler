with Ada.Text_IO;
with Ada.Integer_Text_IO;
package body Problem_36 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   function Is_Palindrome(s : String) return Boolean is
      left  : Integer := s'First;
      right : Integer := s'Last;
   begin
      while left <= right loop
         if s(left) /= s(right) then
            return False;
         end if;
         left  := Integer'Succ(left);
         right := Integer'Pred(right);
      end loop;
      return True;
   end Is_Palindrome;
   function Decimal(num : Integer) return String is
      function Dec_Mag(num : Integer) return Integer is
      begin
         if num >= 1_000_000 then
            return 7;
         elsif num >= 100_000 then
            return 6;
         elsif num >= 10_000 then
            return 5;
         elsif num >= 1_000 then
            return 4;
         elsif num >= 100 then
            return 3;
         elsif num >= 10 then
            return 2;
         else
            return 1;
         end if;
      end Dec_Mag;
      s : String (1 .. Dec_Mag(num));
      n : Integer := Num;
   begin
      for index in reverse s'Range loop
         s(index) := Character'Val(Character'Pos('0') + (n mod 10));
         n := n / 10;
      end loop;
      return s;
   end Decimal;
   function Binary(num: Integer) return String is
      function Bin_Mag(num : Integer) return Integer is
      begin
         if num >= 2**17 then
            return 17;
         elsif num >= 2**16 then
            return 16;
         elsif num >= 2**15 then
            return 15;
         elsif num >= 2**14 then
            return 14;
         elsif num >= 2**13 then
            return 13;
         elsif num >= 2**12 then
            return 12;
         elsif num >= 2**11 then
            return 11;
         elsif num >= 2**10 then
            return 10;
         elsif num >= 2**9 then
            return 9;
         elsif num >= 2**8 then
            return 8;
         elsif num >= 2**7 then
            return 7;
         elsif num >= 2**6 then
            return 6;
         elsif num >= 2**5 then
            return 5;
         elsif num >= 2**4 then
            return 4;
         elsif num >= 2**3 then
            return 3;
         elsif num >= 2**2 then
            return 2;
         elsif num >= 2**1 then
            return 1;
         else
            return 0;
         end if;
      end Bin_Mag;
      s : String(1 .. Bin_Mag(num) + 1);
      n : Integer := num;
   begin
      for index in reverse s'Range loop
         s(index) := Character'Val(Character'Pos('0') + (n mod 2));
         n := n / 2;
      end loop;
      return s;
   end Binary;
   procedure Solve is
      num : Integer := 1;
      sum : Integer := 0;
   begin
      while num < 1_000_000 loop
         if Is_Palindrome(Decimal(num)) and Is_Palindrome(Binary(num)) then
            sum := sum + num;
         end if;
         num := num + 2;
      end loop;
      I_IO.Put(sum);
      IO.New_Line;
   end Solve;
end Problem_36;
