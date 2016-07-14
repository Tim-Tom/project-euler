with Ada.Text_IO;
package body Problem_68 is
   package IO renames Ada.Text_IO;

   -- They want 16 digit strings, so we know that every solution will
   -- have a 10 on the outside edge of one of the flanges, so we can
   -- always start there.
   
   subtype Digit is Positive range 1 .. 10;
   subtype Position is Positive range 1 .. 10;

   taken : Array (Digit) of Boolean := (10 => True, others => False);
   -- 1 + 2 + 3
   -- 4 + 3 + 5
   -- 6 + 5 + 7
   -- 8 + 7 + 9
   -- 10 + 9 + 2
   values : Array (Position) of Digit;
   flanges : constant Array(1 .. 5) of Position := (1, 4, 6, 8, 10);
   output_order : constant Array (1 .. 15) of Positive := (1, 2, 3, 4, 3, 5, 6, 5, 7, 8, 7, 9, 10, 9, 2);
   result : String(1 .. 16);
   sum : Positive;
   
   procedure MakeResult is
      min : Position := 1;
      flange : Positive := 1;
      result_index : Positive := 1;
      new_result : String(1 .. 16);
   begin
      for i in flanges'Range loop
         if values(flanges(i)) < values(min) then
            flange := i;
            min := flanges(i);
         end if;
      end loop;
      flange := flange * 3;
      for i in flange .. output_order'Last loop
         if values(output_order(i)) = 10 then
            new_result(result_index) := '1';
            new_result(result_index + 1) := '0';
            result_index := result_index + 2;
         else
            new_result(result_index) := Character'Val(Character'Pos('0') + values(output_order(i)));
            result_index := result_index + 1;
         end if;
      end loop;
      for i in 1 .. flange - 1 loop
         if values(output_order(i)) = 10 then
            new_result(result_index) := '1';
            new_result(result_index + 1) := '0';
            result_index := result_index + 2;
         else
            new_result(result_index) := Character'Val(Character'Pos('0') + values(output_order(i)));
            result_index := result_index + 1;
         end if;
      end loop;
      if result < new_result then
         result := new_result;
      end if;
   end MakeResult;

   procedure SolveTenth is
      num : constant Integer := sum - values(9) - values(2);
   begin
      if (num > 0 and num < 10) and then not taken(num) then
         values(10) := num;
         taken(num) := True;
         MakeResult;
         taken(num) := False;
      end if;
   end SolveTenth;

   procedure SolveNinth is
      num : constant Integer := sum - values(8) - values(7);
   begin
      if (num > 0 and num < 10) and then not taken(num) then
         values(9) := num;
         taken(num) := True;
         SolveTenth;
         taken(num) := False;
      end if;
   end SolveNinth;

   procedure SolveEighth is
   begin
      for num in taken'Range loop
         if not taken(num) then
            values(8) := num;
            taken(num) := True;
            SolveNinth;
            taken(num) := False;
         end if;
      end loop;
   end SolveEighth;

   procedure SolveSeventh is
      num : constant Integer := sum - values(6) - values(5);
   begin
      if (num > 0 and num < 10) and then not taken(num) then
         values(7) := num;
         taken(num) := True;
         SolveEighth;
         taken(num) := False;
      end if;
   end SolveSeventh;

   procedure SolveSixth is
   begin
      for num in taken'Range loop
         if not taken(num) then
            values(6) := num;
            taken(num) := True;
            SolveSeventh;
            taken(num) := False;
         end if;
      end loop;
   end SolveSixth;

   procedure SolveFifth is
      num : constant Integer := sum - values(3) - values(4);
   begin
      if (num > 0 and num < 10) and then not taken(num) then
         values(5) := num;
         taken(num) := True;
         SolveSixth;
         taken(num) := False;
      end if;
   end SolveFifth;

   procedure SolveFourth is
   begin
      for num in taken'Range loop
         if not taken(num) then
            values(4) := num;
            taken(num) := True;
            SolveFifth;
            taken(num) := False;
         end if;
      end loop;
   end SolveFourth;

   procedure SolveThird is
   begin
      for num in taken'Range loop
         if not taken(num) then
            values(3) := num;
            taken(num) := True;
            sum := values(1) + values(2) + values(3);
            SolveFourth;
            taken(num) := False;
         end if;
      end loop;
   end SolveThird;

   procedure SolveSecond is
   begin
      for num in taken'Range loop
         if not taken(num) then
            values(2) := num;
            taken(num) := True;
            SolveThird;
            taken(num) := False;
         end if;
      end loop;
   end SolveSecond;

   procedure Solve is
   begin
      values(1) := 10;
      SolveSecond;
      IO.Put_Line(result);
   end Solve;
end Problem_68;
