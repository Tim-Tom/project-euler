-- There are exactly ten ways of selecting three from five, 12345:
--
-- 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
--
-- In combinatorics, we use the notation, 5C3 = 10.
--
-- In general,nCr = n!/(r!(n-r)!) ,where r < n
--
-- It is not until n = 23, that a value exceeds one-million: 23C10 = 1,144,066.
--
-- How many, not necessarily distinct, values of  nCr, for 1 <= n <= 100, are greater than one-million?
package Problem_53 is
   procedure Solve;
end Problem_53;
