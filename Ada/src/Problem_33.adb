with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Containers.Ordered_Sets;
package body Problem_33 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   type SimpleRational is Record
      Numerator : Integer;
      Denominator : Integer;
   end Record;
   function "<"(left, right : SimpleRational) return Boolean is
   begin
      -- left < right.  We can't do real less than because we're just inserting
      -- the same fraction over and over again.
      -- IO.Put_Line("Less-Comparing " & ToString(left) & " and " & ToString(right));
      if left.Numerator = right.Numerator then
         return right.Denominator < left.Denominator;
      elsif left.Denominator = right.Denominator then
         return left.Numerator < right.Numerator;
      else
         return left.Numerator < right.Numerator;
      end if;
   end "<";
   function "*"(left, right : SimpleRational) return SimpleRational is
      result : SimpleRational;
   begin
      result.Numerator   := left.Numerator*right.Numerator;
      result.Denominator := left.Denominator*right.Denominator;
      -- This doesn't simplify most things, but it works for this problem :)
      if result.Denominator mod result.Numerator = 0 then
         result.Denominator := result.Denominator / result.Numerator;
         result.Numerator := 1;
      end if;
      return result;
   end "*";
   Package RationalSet is new Ada.Containers.Ordered_Sets(SimpleRational);
   procedure Solve is
      result : SimpleRational := (0, 0);
   begin
      for denominator in 2 .. 9 loop
         for numerator in 1 .. denominator - 1 loop
            declare
               set : RationalSet.Set;
               base : constant SimpleRational := (numerator, denominator);
            begin
               for multiplier in 1 .. (99 / denominator) loop
                  declare
                     r : constant SimpleRational := (numerator*multiplier, denominator*multiplier);
                  begin
                     if r.Numerator >= 10 and r.Denominator >= 10 then
                        declare
                           num_ten  : constant Integer := r.Numerator / 10;
                           num_unit : constant Integer := r.Numerator mod 10;
                           den_ten  : constant Integer := r.Denominator /  10;
                           den_unit : constant Integer := r.Denominator mod 10;
                           check    : SimpleRational   := (0, 0);
                        begin
                           if num_ten = den_unit then
                              check := (num_unit, den_ten);
                           elsif num_unit = den_ten then
                              check := (num_ten, den_unit);
                           end if;
                           if check.Denominator /= 0 and then set.Contains(check) then
                              if result.Denominator = 0 then
                                 result := base;
                              else
                                 result := result * base;
                              end if;
                           end if;
                        end;
                     elsif r.Numerator < 10 and r.Denominator < 10 then
                        -- IO.Put_Line("Inserting " & ToString(r));
                        set.Insert(r);
                     end if;
                  end;
               end loop;
            end;
         end loop;
      end loop;
      I_IO.Put(result.Denominator);
      IO.New_Line;
   end Solve;
end Problem_33;

