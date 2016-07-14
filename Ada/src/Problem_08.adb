with Ada.Integer_Text_IO;
with Ada.Text_IO;
package body Problem_08 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   procedure Solve is
      Big_Num : constant String :=
         "73167176531330624919225119674426574742355349194934"
        &"96983520312774506326239578318016984801869478851843"
        &"85861560789112949495459501737958331952853208805511"
        &"12540698747158523863050715693290963295227443043557"
        &"66896648950445244523161731856403098711121722383113"
        &"62229893423380308135336276614282806444486645238749"
        &"30358907296290491560440772390713810515859307960866"
        &"70172427121883998797908792274921901699720888093776"
        &"65727333001053367881220235421809751254540594752243"
        &"52584907711670556013604839586446706324415722155397"
        &"53697817977846174064955149290862569321978468622482"
        &"83972241375657056057490261407972968652414535100474"
        &"82166370484403199890008895243450658541227588666881"
        &"16427171479924442928230863465674813919123162824586"
        &"17866458359124566529476545682848912883142607690042"
        &"24219022671055626321111109370544217506941658960408"
        &"07198403850962455444362981230987879927244284909188"
        &"84580156166097919133875499200524063689912560717606"
        &"05886116467109405077541002256983155200055935729725"
        &"71636269561882670428252483600823257530420752963450";
      type Last_5 is mod 5;
      numbers : Array (Last_5'Range) of Natural;
      numbers_index : Last_5 := Last_5'Last;
      biggest : Natural := 0;
      function Product_Of return Natural is
         product : Natural := 1;
      begin
         for index in numbers'Range loop
            declare
               number : constant Natural := numbers(index);
            begin
               product := product * number;
            end;
         end loop;
         return product;
      end;
   begin
      for index in Last_5'First .. Last_5'Last - 1 loop
         numbers(index) := Character'Pos(Big_Num(Big_Num'First + Integer(index))) - Character'Pos('0');
      end loop;
      for index in Big_Num'First + Integer(numbers_index) .. Big_Num'Last loop
         numbers(numbers_index) := Character'Pos(Big_Num(index)) - Character'Pos('0');
         numbers_index := numbers_index + 1;
         declare
            product : constant Natural := Product_Of;
         begin
            if product > biggest then
               biggest := product;
            end if;
         end;
      end loop;
      I_IO.Put(biggest);
      IO.New_Line;
   end Solve;
end Problem_08;
