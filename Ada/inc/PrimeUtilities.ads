with Heap;
generic
    type Num is range <>;
package PrimeUtilities is
   type Sieve is Array (Positive range <>) of Num;
   type Prime_Count is Record
      prime : Num;
      count : Positive;
   end Record;
   type Prime_Factors is Array (Positive range <>) of Prime_Count;
   type Proper_Divisors is Array (Positive range <>) of Num;
   type Prime_Generator is private;
   function Make_Generator(Max_Prime : Num := Num'Last) return Prime_Generator;
   procedure Next_Prime(gen : in out Prime_Generator; prime : out Num);
   function Generate_Sieve(Max_Prime : Num) return Sieve;
   function Generate_Prime_Factors(n : Num; primes : sieve) return Prime_Factors;
   function Count_Divisors(factors : Prime_Factors) return Positive;
   function Generate_Proper_Divisors(factors : Prime_Factors) return Proper_Divisors;
   function Generate_Proper_Divisors(n : Num; primes : sieve) return Proper_Divisors;
   function Generate_Proper_Divisors(n : Num) return Proper_Divisors;
private
   type Virtual_List is Record
      Next_Composite : Num;
      Increment      : Num;
   end Record;
   function "<="  (Left, Right: in Virtual_List) return Boolean;
   package Virtual_List_Heap is new Heap(Element_Type => Virtual_List);
   type Incrementor is mod 8;
   type Prime_Generator is Record
      Filters    : Virtual_List_Heap.Heap;
      Last_Prime : Num;
      Max_Prime  : Num;
      Increment  : Incrementor;
      Done       : Boolean;
   end Record;
end PrimeUtilities;
