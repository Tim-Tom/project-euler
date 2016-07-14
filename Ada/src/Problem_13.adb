with Ada.Text_IO;
with BigInteger; use BigInteger;
package body Problem_13 is
   package IO renames Ada.Text_IO;
   procedure Solve is
      type Problem_13_Array is Array (1 .. 100) of BigInt;
      nums : Problem_13_Array;
      sum  : BigInt := BigInteger.Create(0);
   begin
      nums(  1) := BigInteger.Create("37107287533902102798797998220837590246510135740250");
      nums(  2) := BigInteger.Create("46376937677490009712648124896970078050417018260538");
      nums(  3) := BigInteger.Create("74324986199524741059474233309513058123726617309629");
      nums(  4) := BigInteger.Create("91942213363574161572522430563301811072406154908250");
      nums(  5) := BigInteger.Create("23067588207539346171171980310421047513778063246676");
      nums(  6) := BigInteger.Create("89261670696623633820136378418383684178734361726757");
      nums(  7) := BigInteger.Create("28112879812849979408065481931592621691275889832738");
      nums(  8) := BigInteger.Create("44274228917432520321923589422876796487670272189318");
      nums(  9) := BigInteger.Create("47451445736001306439091167216856844588711603153276");
      nums( 10) := BigInteger.Create("70386486105843025439939619828917593665686757934951");
      nums( 11) := BigInteger.Create("62176457141856560629502157223196586755079324193331");
      nums( 12) := BigInteger.Create("64906352462741904929101432445813822663347944758178");
      nums( 13) := BigInteger.Create("92575867718337217661963751590579239728245598838407");
      nums( 14) := BigInteger.Create("58203565325359399008402633568948830189458628227828");
      nums( 15) := BigInteger.Create("80181199384826282014278194139940567587151170094390");
      nums( 16) := BigInteger.Create("35398664372827112653829987240784473053190104293586");
      nums( 17) := BigInteger.Create("86515506006295864861532075273371959191420517255829");
      nums( 18) := BigInteger.Create("71693888707715466499115593487603532921714970056938");
      nums( 19) := BigInteger.Create("54370070576826684624621495650076471787294438377604");
      nums( 20) := BigInteger.Create("53282654108756828443191190634694037855217779295145");
      nums( 21) := BigInteger.Create("36123272525000296071075082563815656710885258350721");
      nums( 22) := BigInteger.Create("45876576172410976447339110607218265236877223636045");
      nums( 23) := BigInteger.Create("17423706905851860660448207621209813287860733969412");
      nums( 24) := BigInteger.Create("81142660418086830619328460811191061556940512689692");
      nums( 25) := BigInteger.Create("51934325451728388641918047049293215058642563049483");
      nums( 26) := BigInteger.Create("62467221648435076201727918039944693004732956340691");
      nums( 27) := BigInteger.Create("15732444386908125794514089057706229429197107928209");
      nums( 28) := BigInteger.Create("55037687525678773091862540744969844508330393682126");
      nums( 29) := BigInteger.Create("18336384825330154686196124348767681297534375946515");
      nums( 30) := BigInteger.Create("80386287592878490201521685554828717201219257766954");
      nums( 31) := BigInteger.Create("78182833757993103614740356856449095527097864797581");
      nums( 32) := BigInteger.Create("16726320100436897842553539920931837441497806860984");
      nums( 33) := BigInteger.Create("48403098129077791799088218795327364475675590848030");
      nums( 34) := BigInteger.Create("87086987551392711854517078544161852424320693150332");
      nums( 35) := BigInteger.Create("59959406895756536782107074926966537676326235447210");
      nums( 36) := BigInteger.Create("69793950679652694742597709739166693763042633987085");
      nums( 37) := BigInteger.Create("41052684708299085211399427365734116182760315001271");
      nums( 38) := BigInteger.Create("65378607361501080857009149939512557028198746004375");
      nums( 39) := BigInteger.Create("35829035317434717326932123578154982629742552737307");
      nums( 40) := BigInteger.Create("94953759765105305946966067683156574377167401875275");
      nums( 41) := BigInteger.Create("88902802571733229619176668713819931811048770190271");
      nums( 42) := BigInteger.Create("25267680276078003013678680992525463401061632866526");
      nums( 43) := BigInteger.Create("36270218540497705585629946580636237993140746255962");
      nums( 44) := BigInteger.Create("24074486908231174977792365466257246923322810917141");
      nums( 45) := BigInteger.Create("91430288197103288597806669760892938638285025333403");
      nums( 46) := BigInteger.Create("34413065578016127815921815005561868836468420090470");
      nums( 47) := BigInteger.Create("23053081172816430487623791969842487255036638784583");
      nums( 48) := BigInteger.Create("11487696932154902810424020138335124462181441773470");
      nums( 49) := BigInteger.Create("63783299490636259666498587618221225225512486764533");
      nums( 50) := BigInteger.Create("67720186971698544312419572409913959008952310058822");
      nums( 51) := BigInteger.Create("95548255300263520781532296796249481641953868218774");
      nums( 52) := BigInteger.Create("76085327132285723110424803456124867697064507995236");
      nums( 53) := BigInteger.Create("37774242535411291684276865538926205024910326572967");
      nums( 54) := BigInteger.Create("23701913275725675285653248258265463092207058596522");
      nums( 55) := BigInteger.Create("29798860272258331913126375147341994889534765745501");
      nums( 56) := BigInteger.Create("18495701454879288984856827726077713721403798879715");
      nums( 57) := BigInteger.Create("38298203783031473527721580348144513491373226651381");
      nums( 58) := BigInteger.Create("34829543829199918180278916522431027392251122869539");
      nums( 59) := BigInteger.Create("40957953066405232632538044100059654939159879593635");
      nums( 60) := BigInteger.Create("29746152185502371307642255121183693803580388584903");
      nums( 61) := BigInteger.Create("41698116222072977186158236678424689157993532961922");
      nums( 62) := BigInteger.Create("62467957194401269043877107275048102390895523597457");
      nums( 63) := BigInteger.Create("23189706772547915061505504953922979530901129967519");
      nums( 64) := BigInteger.Create("86188088225875314529584099251203829009407770775672");
      nums( 65) := BigInteger.Create("11306739708304724483816533873502340845647058077308");
      nums( 66) := BigInteger.Create("82959174767140363198008187129011875491310547126581");
      nums( 67) := BigInteger.Create("97623331044818386269515456334926366572897563400500");
      nums( 68) := BigInteger.Create("42846280183517070527831839425882145521227251250327");
      nums( 69) := BigInteger.Create("55121603546981200581762165212827652751691296897789");
      nums( 70) := BigInteger.Create("32238195734329339946437501907836945765883352399886");
      nums( 71) := BigInteger.Create("75506164965184775180738168837861091527357929701337");
      nums( 72) := BigInteger.Create("62177842752192623401942399639168044983993173312731");
      nums( 73) := BigInteger.Create("32924185707147349566916674687634660915035914677504");
      nums( 74) := BigInteger.Create("99518671430235219628894890102423325116913619626622");
      nums( 75) := BigInteger.Create("73267460800591547471830798392868535206946944540724");
      nums( 76) := BigInteger.Create("76841822524674417161514036427982273348055556214818");
      nums( 77) := BigInteger.Create("97142617910342598647204516893989422179826088076852");
      nums( 78) := BigInteger.Create("87783646182799346313767754307809363333018982642090");
      nums( 79) := BigInteger.Create("10848802521674670883215120185883543223812876952786");
      nums( 80) := BigInteger.Create("71329612474782464538636993009049310363619763878039");
      nums( 81) := BigInteger.Create("62184073572399794223406235393808339651327408011116");
      nums( 82) := BigInteger.Create("66627891981488087797941876876144230030984490851411");
      nums( 83) := BigInteger.Create("60661826293682836764744779239180335110989069790714");
      nums( 84) := BigInteger.Create("85786944089552990653640447425576083659976645795096");
      nums( 85) := BigInteger.Create("66024396409905389607120198219976047599490197230297");
      nums( 86) := BigInteger.Create("64913982680032973156037120041377903785566085089252");
      nums( 87) := BigInteger.Create("16730939319872750275468906903707539413042652315011");
      nums( 88) := BigInteger.Create("94809377245048795150954100921645863754710598436791");
      nums( 89) := BigInteger.Create("78639167021187492431995700641917969777599028300699");
      nums( 90) := BigInteger.Create("15368713711936614952811305876380278410754449733078");
      nums( 91) := BigInteger.Create("40789923115535562561142322423255033685442488917353");
      nums( 92) := BigInteger.Create("44889911501440648020369068063960672322193204149535");
      nums( 93) := BigInteger.Create("41503128880339536053299340368006977710650566631954");
      nums( 94) := BigInteger.Create("81234880673210146739058568557934581403627822703280");
      nums( 95) := BigInteger.Create("82616570773948327592232845941706525094512325230608");
      nums( 96) := BigInteger.Create("22918802058777319719839450180888072429661980811197");
      nums( 97) := BigInteger.Create("77158542502016545090413245809786882778948721859617");
      nums( 98) := BigInteger.Create("72107838435069186155435662884062257473692284509516");
      nums( 99) := BigInteger.Create("20849603980134001723930671666823555245252804609722");
      nums(100) := BigInteger.Create("53503534226472524250874054075591789781264330331690");
      for index in nums'Range loop
         sum := sum + nums(index);
      end loop;
      declare
         total : constant String := BigInteger.ToString(sum);
         start : String (1 .. 10);
      begin
         for index in start'Range loop
            start(index) := total(index);
         end loop;
         IO.Put_Line(start);
      end;
   end Solve;
end Problem_13;
