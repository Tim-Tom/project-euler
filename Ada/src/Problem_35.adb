with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Containers.Ordered_Sets;
with PrimeUtilities;
package body Problem_35 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   subtype One_Million is Integer range 1 .. 1_000_000;
   package Million_Set is new Ada.Containers.Ordered_Sets(One_Million);
   package Million_Primes is new PrimeUtilities(One_Million);
   function Magnitude(n : One_Million) return Natural is
      begin
         if n >= 100_000 then
            return 100_000;
         elsif n >= 10_000 then
            return 10_000;
         elsif n >= 1_000 then
            return 1_000;
         elsif n >= 100 then
            return 100;
         elsif n >= 10 then
            return 10;
         else
            return 1;
         end if;
      end Magnitude;
   function Rotate(n : One_Million; mag : Natural) return One_Million is
   begin
      return n mod 10 * mag + n / 10;
   end Rotate;
   procedure Solve is
      primes : Million_Set.Set;
      count : Natural := 0;
      procedure Check_Rotations(c : Million_Set.Cursor) is
         prime    : constant One_Million := Million_Set.Element(c);
         mag      : constant Natural := Magnitude(prime);
         possible : One_Million := Rotate(prime, mag);
         All_Prime : Boolean    := True;
      begin
         while possible /= prime loop
            if not primes.Contains(possible) then
               All_Prime := False;
               exit;
            else
               possible := Rotate(possible, mag);
            end if;
         end loop;
         if All_Prime then
            count := count + 1;
         end if;
      end Check_Rotations;
   begin
      declare
         prime : One_Million;
         gen : Million_Primes.Prime_Generator := Million_Primes.Make_Generator(One_Million'Last);
      begin
         loop
            Million_Primes.Next_Prime(gen, prime);
            exit when prime = 1;
            primes.Insert(prime);
         end loop;
      end;
      primes.Iterate(Process => Check_Rotations'Access);
      I_IO.Put(count);
      IO.New_Line;
   end Solve;
end Problem_35;
