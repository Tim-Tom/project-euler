with Ada.Text_IO;
package body Problem_54 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      type Faces is (Low_Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace, Out_of_Range);
      pragma Unreferenced (Out_of_Range);

      type Suits is (Clubs, Diamonds, Spades, Hearts);
      type Card is Record
         face : Faces;
         suit : Suits;
      end Record;
      function ">"(Left, Right : Card) return Boolean is
      begin
         return Left.face > Right.face;
      end ">";
      function "="(Left, Right : Card) return Boolean is
      begin
         return Left.face = Right.face;
      end "=";

      type Card_Hand is Array (1 .. 5) of Card;
      type Hand_Score is new Integer range 0 .. 294;
      type Hand_Type is (None, Pair, Two_Pair, Three_of_a_Kind, Straight, Flush,
                         Full_House, Four_of_a_Kind, Straight_Flush);
      Hand_Counts : constant Array(Hand_Type) of Hand_Score :=
        (
         None            => 1,
         Pair            => 13,
         Two_Pair        => (12 + 1) * 12 / 2,
         Three_of_a_Kind => 13,
         Straight        => 10,
         Flush           => 1,
         Full_House      => 13 * 12,
         Four_of_A_Kind  => 13,
         Straight_Flush  => 10
        );
      Hand_Bases : constant Array(Hand_Type) of Hand_Score :=
        (
         None            => 0,
         Pair            => Hand_Counts(None),
         Two_Pair        => Hand_Counts(None) + Hand_Counts(Pair),
         Three_of_a_Kind => Hand_Counts(None) + Hand_Counts(Pair) + Hand_Counts(Two_Pair),
         Straight        => Hand_Counts(None) + Hand_Counts(Pair) + Hand_Counts(Two_Pair) + Hand_Counts(Three_of_a_Kind),
         Flush           => Hand_Counts(None) + Hand_Counts(Pair) + Hand_Counts(Two_Pair) + Hand_Counts(Three_of_a_Kind) + Hand_Counts(Straight),
         Full_House      => Hand_Counts(None) + Hand_Counts(Pair) + Hand_Counts(Two_Pair) + Hand_Counts(Three_of_a_Kind) + Hand_Counts(Straight) + Hand_Counts(Flush),
         Four_of_A_Kind  => Hand_Counts(None) + Hand_Counts(Pair) + Hand_Counts(Two_Pair) + Hand_Counts(Three_of_a_Kind) + Hand_Counts(Straight) + Hand_Counts(Flush) + Hand_Counts(Full_House),
         Straight_Flush  => Hand_Counts(None) + Hand_Counts(Pair) + Hand_Counts(Two_Pair) + Hand_Counts(Three_of_a_Kind) + Hand_Counts(Straight) + Hand_Counts(Flush) + Hand_Counts(Full_House) + Hand_Counts(Four_of_A_Kind)
        );

      Two_Pair_Offset : constant Array(Faces range Three .. Ace) of Hand_Score :=
        (
         Three   => 0,
         Four    => 1,
         Five    => 3,
         Six     => 6,
         Seven   => 10,
         Eight   => 15,
         Nine    => 21,
         Ten     => 28,
         Jack    => 36,
         Queen   => 45,
         King    => 55,
         Ace     => 66
        );
      procedure Evaluate(hand : in out Card_Hand; result : out Hand_Score) is
         is_flush    : Boolean := True;
         is_straight : Boolean := True;
         counts   : Array(Faces range Two .. Ace) of Natural := (others => 0);
         pairs    : Natural := 0;
         triple   : Boolean := False;
         quad     : Boolean := False;
         previous : Card := (face => Faces'Pred(hand(1).face), suit => hand(1).suit);
         function Score(face : Faces) return Hand_Score is
         begin
            return Faces'Pos(face) - 1;
         end Score;
      begin
         for index in hand'Range loop
            declare
               finger : constant Card := Hand(index);
            begin
               if is_straight then
                  if finger.face /= Faces'Succ(previous.face) and
                    (finger.face /= Ace or previous.face /= Five) then
                     is_straight := False;
                  end if;
               end if;
               if is_flush and finger.suit /= previous.suit then
                  is_flush := False;
               end if;
               counts(finger.face) := counts(finger.face) + 1;
               if counts(finger.face) = 2 then
                  pairs := pairs + 1;
               elsif counts(finger.face) = 3 then
                  pairs := pairs - 1;
                  triple := True;
               elsif counts(finger.face) = 4 then
                  triple := False;
                  quad := True;
               end if;
               previous := finger;
            end;
         end loop;
         if is_straight and hand(5).face = Ace and hand(4).face = Five then
            declare
               ace_suit : constant Suits := hand(5).suit;
            begin
               for top in reverse 2 .. 5 loop
                  hand(top).face := hand(top - 1).face;
                  hand(top).suit := hand(top - 1).suit;
               end loop;
               hand(1).face := Low_Ace;
               hand(1).suit := ace_suit;
            end;
         end if;
         if is_straight then
            if is_flush then
               result := Hand_Bases(Straight_Flush) + Score(hand(5).face) - 3;
            else
               result := Hand_Bases(Straight) + Score(hand(5).face) - 3;
            end if;
         elsif quad then
            for face in counts'Range loop
               if counts(face) = 4 then
                  result := Hand_Bases(Four_of_a_Kind) + Score(face);
                  exit;
               end if;
            end loop;
         elsif triple and pairs = 1 then
            declare
               last : Boolean := False;
            begin
               result := Hand_Bases(Full_House);
               for face in counts'Range loop
                  if counts(face) = 3 then
                     result := result + 12*Score(face);
                     exit when last;
                     last := True;
                  elsif counts(face) = 2 then
                     result := result + Score(face);
                     if last then
                        result := result - 1;
                        exit;
                     else
                        last := True;
                     end if;
                  end if;
               end loop;
            end;
         elsif is_flush then
            result := Hand_Bases(Flush);
         elsif triple then
            for face in counts'Range loop
               if counts(face) = 3 then
                  result := Hand_Bases(Three_of_a_Kind) + Score(face);
                  exit;
               end if;
            end loop;
         elsif pairs = 2 then
            declare
               first : Boolean := True;
            begin
               result := Hand_Bases(Two_Pair);
               for face in reverse counts'Range loop
                  if counts(face) = 2 then
                     if first then
                        result := result + Two_Pair_Offset(face);
                        first := False;
                     else
                        result := result + Score(face);
                        exit;
                     end if;
                  end if;
               end loop;
            end;
         elsif pairs = 1 then
            for face in counts'Range loop
               if counts(face) = 2 then
                  result := Hand_Bases(pair) + Score(face);
                  exit;
               end if;
            end loop;
         else
            result := Hand_Bases(None);
         end if;
      end;
      procedure High_Card(hand  : Card_Hand;
                          index : in out Natural) is
      begin
         loop
            declare
               current : constant Faces := hand(index).face;
               subtract : Positive := 1;
            begin
               for location in reverse 1 .. index - 1 loop
                  exit when current /= hand(location).face;
                  subtract := subtract + 1;
               end loop;
               exit when subtract = 1;
               index := index - subtract;
               exit when index = 0;
            end;
         end loop;
      end High_Card;
      input : IO.File_Type;
      procedure Read_Card(finger : out Card) is
         read : character;
      begin
         IO.Get(input, read);
         case(read) is
            when '2' =>
               finger.face := Two;
            when '3' =>
               finger.face := Three;
            when '4' =>
               finger.face := Four;
            when '5' =>
               finger.face := Five;
            when '6' =>
               finger.face := Six;
            when '7' =>
               finger.face := Seven;
            when '8' =>
               finger.face := Eight;
            when '9' =>
               finger.face := Nine;
            when 'T' =>
               finger.face := Ten;
            when 'J' =>
               finger.face := Jack;
            when 'Q' =>
               finger.face := Queen;
            when 'K' =>
               finger.face := King;
            when 'A' =>
               finger.face := Ace;
            when others =>
               IO.Put_Line("Character was '" & Character'Image(read) & "'.");
               raise Constraint_Error;
         end case;
         IO.Get(input, read);
         case(read) is
            when 'C' =>
               finger.suit := Clubs;
            when 'S' =>
               finger.suit := Spades;
            when 'H' =>
               finger.suit := Hearts;
            when 'D' =>
               finger.suit := Diamonds;
            when others =>
               raise Constraint_Error;
         end case;
         if not (IO.End_Of_Line(input) or IO.End_Of_File(input)) then
            IO.Get(input, read);
         end if;
      end;
      procedure Sort(a : in out Card_Hand) is
      begin
         for j in 2 .. a'Last loop
            declare
               key : constant Card := a(j);
               i : Natural := j - 1;
            begin
               while i > 0 and then a(i) > key loop
                  a(i + 1) := a(i);
                  i := i - 1;
               end loop;
               a(i + 1) := key;
            end;
         end loop;
      end;
      wins : Natural := 0;
   begin
      IO.Open(input, IO.In_File, "input/Problem_54.txt");
      while not IO.End_Of_File(input) loop
         declare
            left, right : Card_Hand;
            left_score, right_score : Hand_Score;
         begin
            for index in left'Range loop
               Read_Card(left(index));
            end loop;
            Sort(left);
            for index in right'Range loop
               Read_Card(right(index));
            end loop;
            Sort(right);
            Evaluate(left, left_score);
            Evaluate(right, right_score);
            if left_score > right_score then
               wins := wins + 1;
            elsif left_score = right_score then
               declare
                  left_index : Natural := 5;
                  right_index : Natural := 5;
               begin
                  while left_index > 0 and right_index > 0 loop
                     High_Card(left, left_index);
                     High_Card(right, right_index);
                     exit when left_index = 0 or right_index = 0;
                     if left(left_index) > right(right_index) then
                        wins := wins + 1;
                     end if;
                     exit when left(left_index) /= right(right_index);
                  end loop;
               end;
            end if;
         end;
      end loop;
      IO.Put_Line(Natural'Image(wins));
   end Solve;
end Problem_54;
