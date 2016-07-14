with Ada.Text_IO;
package body Problem_64 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      function GCD (A, B : Integer) return Integer is
         m : Integer := A;
         n : Integer := B;
         temp : Integer;
      begin
         while N /= 0 loop
            temp := m;
            m := n;
            n := temp mod n;
         end loop;
         return m;
      end GCD;

      First_Top, First_Bottom : Positive;
      Square_Increment : Positive := 5;
      Next_Square : Positive := 4;
      Current_Square_Base : Positive := 1;
      Period : Natural;
      Top, Bottom : Integer;
      Odd_Count : Integer := 0;
   begin
      for n in 2 .. 100_000 loop
--      for n in 23 .. 23 loop
         Period := 0;
         if n = Next_Square then
            Next_Square := Next_Square + Square_Increment;
            Current_Square_Base := Current_Square_Base + 1;
            Square_Increment := Square_Increment + 2;
         else
            Top := 1;
            Bottom := Current_Square_Base;
            loop
               declare
                  Bottom_Prime : constant Natural := n - Bottom*Bottom;
                  g : constant Natural := GCD(Top, Bottom_Prime);
                  Bottom_Star : constant Natural := Bottom_Prime / g;
                  Top_Star : constant Natural := Top / g;
                  Top_Raw : constant Natural := Top_Star * (Current_Square_Base + Bottom);
                  Next_Bottom : constant Natural := Current_Square_Base - (Top_Raw mod Bottom_Star);
                  Next_Top : constant Natural := Bottom_Star;
               begin
--                    IO.Put_Line("Bottom_Prime: " & Integer'Image(Bottom_Prime));
--                    IO.Put_Line("g: " & Integer'Image(g));
--                    IO.Put_Line("Bottom_Star: " & Integer'Image(Bottom_Star));
--                    IO.Put_Line("Top_Star: " & Integer'Image(Top_Star));
--                    IO.Put_Line("Top_Raw: " & Integer'Image(Top_Raw));
--                    IO.Put_Line("Next_Bottom: " & Integer'Image(Next_Bottom));
--                    IO.Put_Line("Next_Top: " & Integer'Image(Next_Top));
--                    IO.Put_Line(Integer'Image(Top) & ", " & Integer'Image(Bottom) & " -> " & Integer'Image(Next_Top) & ", " & Integer'Image(Next_Bottom));
                  Top := Next_Top;
                  Bottom := Next_Bottom;
                  if Period = 0 then
                     First_Top := Top;
                     First_Bottom := Bottom;
                  elsif (First_Top = Top and then First_Bottom = Bottom) then
                     exit;
                  end if;
                  Period := Period + 1;
               end;
            end loop;
         end if;
         if Period mod 2 = 1 then
            Odd_Count := Odd_Count + 1;
         end if;
      end loop;
      IO.Put_Line(Integer'Image(Odd_Count));
   end Solve;
end Problem_64;
