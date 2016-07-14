with Ada.Text_IO;
with Ada.Integer_Text_IO;
package body Problem_30 is
   package IO renames Ada.Text_IO;
   package I_IO renames Ada.Integer_Text_IO;
   subtype digit is Integer range 0 .. 9;
   fifth_power : constant Array (0 .. 9) of Integer := (0**5, 1**5, 2**5, 3**5,
                                                        4**5, 5**5, 6**5, 7**5,
                                                        8**5, 9**5);
   total_Sum : Integer := 0;
   procedure Solve is
   begin
      for hundred_thousand_digit in 0 .. 2 loop
         declare
            hundred_thousand_num : constant Integer := hundred_thousand_digit * 100_000;
            hundred_thousand_sum : constant Integer := fifth_power(hundred_thousand_digit);
         begin
            for ten_thousand_digit in digit'Range loop
               declare
                  ten_thousand_num : constant Integer := hundred_thousand_num + ten_thousand_digit * 10_000;
                  ten_thousand_sum : constant Integer := hundred_thousand_sum + fifth_power(ten_thousand_digit);
               begin
                  for thousand_digit in digit'Range loop
                     declare
                        thousand_num : constant Integer := ten_thousand_num + thousand_digit * 1_000;
                        thousand_sum : constant Integer := ten_thousand_sum + fifth_power(thousand_digit);
                     begin
                        for hundred_digit in digit'Range loop
                           declare
                              hundred_num : constant Integer := thousand_num + hundred_digit * 100;
                              hundred_sum : constant Integer := thousand_sum + fifth_power(hundred_digit);
                           begin
                              for ten_digit in digit'Range loop
                                 declare
                                    ten_num : constant Integer := hundred_num + ten_digit * 10;
                                    ten_sum : constant Integer := hundred_sum + fifth_power(ten_digit);
                                 begin
                                    for unit_digit in digit'range loop
                                       declare
                                          unit_num : constant Integer := ten_num + unit_digit;
                                          unit_sum : constant Integer := ten_sum + fifth_power(unit_digit);
                                       begin
                                          if unit_num = unit_sum and unit_num /= 1 then
                                             total_sum := total_sum + unit_num;
                                          end if;
                                       end;
                                    end loop;
                                 end;
                              end loop;
                           end;
                        end loop;
                     end;
                  end loop;
               end;
            end loop;
         end;
      end loop;
      I_IO.Put(total_sum);
      IO.New_Line;
   end Solve;
end Problem_30;
