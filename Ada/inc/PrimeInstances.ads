with PrimeUtilities;

package PrimeInstances is
   package Long_Long_Primes is new PrimeUtilities(Num => Long_Long_Integer);
   package Integer_Primes is new PrimeUtilities(Num => Integer);
   package Positive_Primes is new PrimeUtilities(Num => Positive);
end PrimeInstances;
