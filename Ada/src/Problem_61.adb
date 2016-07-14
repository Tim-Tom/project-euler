with Ada.Text_IO;
with Ada.Containers.Ordered_Maps;
package body Problem_61 is
   package IO renames Ada.Text_IO;
   package Map is new Ada.Containers.Ordered_Maps(Element_Type => Integer, Key_Type => Integer);
   procedure Solve is
      -- Triangle:   n(n+1)/2  =>  n + 1
      -- Square:     n(n)      => 2n + 1
      -- Pentagonal: n(3n-1)/2 => 3n + 1
      -- Hexagonal:  n(2n-1)   => 4n + 1
      -- Heptagonal: n(5n-3)/2 => 5n + 1
      -- Octagonal:  n(3n-2)   => 6n + 1
      figurate : Map.Map;
      procedure Fill_Figurate is
         n, m : Integer;
      begin
         for i in 2 .. 6 loop
            n := 1;
            m := 1;
            loop
               m := m + i*n + 1;
               exit when m >= 10_000;
               if m >= 1_000 and then m /= 9801 and then m /= 1225 and then m /= 4347 and then m /= 5929 then
                  figurate.Insert(m, i);
               end if;
               n := n + 1;
            end loop;
         end loop;
      end Fill_Figurate;
      function Triangular return Integer is
         n : Integer := 45;
         m : Integer := 1035;
         seen : Array(2 .. 6) of Boolean := (others => false);
         sum : Integer := 0;
         function Check(remaining, search, goal : Integer) return Boolean is
            low : constant Map.Cursor := figurate.Floor(search);
            high : constant Map.Cursor := figurate.Floor(search + 99);
            current : Map.Cursor := low;
            use Map;
         begin
            if remaining = 0 then
               return search = goal;
            elsif search <= 1_000 then
               return false;
            end if;
            loop
               if Key(current) >= search and then not seen(Element(current)) then
                  seen(Element(current)) := true;
                  if Check(remaining - 1, 100*(Key(current) mod 100), goal) then
                     sum := sum + Key(current);
                     return true;
                  end if;
                  seen(Element(current)) := false;
               end if;
               exit when current = high;
               current := Map.Next(current);
               null;
            end loop;
            return false;
         end Check;
      begin
         loop
            m := m + n + 1;
            exit when m >= 10_000;
            if m /= 9801 and then m /= 1225 and then m /= 4347 and then m /= 5929 and then not figurate.Contains(m) and then Check(5, 100*(m mod 100), 100*(m / 100)) then
               sum := sum + m;
               exit;
            end if;
            n := n + 1;
         end loop;
         return sum;
      end;
      result :  Integer;
   begin
      Fill_Figurate;
      result := Triangular;
      IO.Put_Line(Integer'Image(result));
   end Solve;
end Problem_61;
