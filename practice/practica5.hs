import Data.Char (ord, isAlpha)

--Ejercicio 2
sumlist :: Num a => [a] -> a
sumlist [] = 0
sumlist (x:xs) = x + sumlist xs

anyinlist :: [Bool] -> Bool
anyinlist [] = False
anyinlist (b:bs) = b || (anyinlist bs)

allinlist :: [Bool] -> Bool
allinlist [] = True
allinlist (b:bs) = b && (anyinlist bs)

codes :: [Char] -> [Int]
codes [] = []
codes (c:cs) = ord c:(codes cs)

remainders :: [Int] -> Int -> [Int]
remainders [] n = []
remainders (x:xs) n = (mod x n) : (remainders xs n)

squares :: [Int] -> [Int]
squares [] = []
squares (x:xs) = (x*x) : (squares xs)

lengths :: [[a]] -> [Int]
lengths [] = []
lengths (l:ls) = length l : lengths ls

--order :: [(a,a)] -> [(a,a)]
order [] = []
order ((c,d):ls) = if (c<3*d) then (c,d) : order ls else order ls

pairs :: [Int] -> [Int]
pairs [] = []
pairs (n:ls) = if (mod n 2 == 0) then n : pairs ls else pairs ls

chars :: [Char] -> [Char]
chars [] = []
chars (c:cs) = if isAlpha c then c : chars cs else chars cs

moreThan :: [[a]] -> Int -> [[a]]
moreThan [] n = []
moreThan (l:ls) n = if ((length l) > n) then (l : moreThan ls n) else (moreThan ls n)

--Ejercicio 9
getodds :: [[Int]] -> [Int]
getodds [] = []
getodds (x:xs) = (getoddsaux x) ++ (getodds xs)

getoddsaux :: [Int] -> [Int]
getoddsaux [] = []
getoddsaux (x:xs) = if (mod x 2 == 0) then (getoddsaux xs) else (x : getoddsaux xs)

--Ejercicio 10
data DigBin = Cero | Uno deriving (Show)

sumBin :: [DigBin] -> [DigBin] -> [DigBin]
sumBin l1 l2 = reverse (sumBinAux (reverse l1) (reverse l2) Cero)

sumBinAux :: [DigBin] -> [DigBin] -> DigBin -> [DigBin]
sumBinAux [] [] Uno = Uno : []
sumBinAux [] [] Cero = []
sumBinAux [] (Uno:bs) Uno = Cero : sumBinAux [] bs Uno
sumBinAux [] (Cero:bs) Uno = Uno : sumBinAux [] bs Cero
sumBinAux [] (Uno:bs) Cero = Uno : sumBinAux [] bs Cero
sumBinAux [] (Cero:bs) Cero = Cero : sumBinAux [] bs Cero
sumBinAux (Uno:bs) [] Uno = Cero : sumBinAux bs [] Uno
sumBinAux (Cero:bs) [] Uno = Uno : sumBinAux bs [] Cero
sumBinAux (Uno:bs) [] Cero = Uno : sumBinAux bs [] Cero
sumBinAux (Cero:bs) [] Cero = Cero : sumBinAux bs [] Cero
sumBinAux (Cero:lb1) (Cero:lb2) Cero = Cero : sumBinAux lb1 lb2 Cero
sumBinAux (Cero:lb1) (Cero:lb2) Uno = Uno : sumBinAux lb1 lb2 Cero
sumBinAux (Uno:lb1) (Cero:lb2) Cero = Uno : sumBinAux lb1 lb2 Cero
sumBinAux (Uno:lb1) (Cero:lb2) Uno = Cero : sumBinAux lb1 lb2 Uno
sumBinAux (Cero:lb1) (Uno:lb2) Cero = Uno : sumBinAux lb1 lb2 Cero
sumBinAux (Cero:lb1) (Uno:lb2) Uno = Cero : sumBinAux lb1 lb2 Uno
sumBinAux (Uno:lb1) (Uno:lb2) Cero = Cero : sumBinAux lb1 lb2 Uno
sumBinAux (Uno:lb1) (Uno:lb2) Uno = Uno : sumBinAux lb1 lb2 Uno

multBin :: [DigBin] -> [DigBin] -> [DigBin]
multBin l1 l2 = reverse(multBinAux (reverse l1) (reverse l2) [Cero])

multBinAux :: [DigBin] -> [DigBin] -> [DigBin] -> [DigBin]
multBinAux [Uno] l1 ans = sumBinAux ans l1 Cero
multBinAux [Cero] l2 ans = ans
multBinAux (Uno:l1s) (l2:l2s) ans = multBinAux l1s (Cero:l2:l2s) (sumBinAux ans (l2:l2s) Cero)
multBinAux (Cero:l1s) (l2:l2s) ans = multBinAux l1s (Cero:l2:l2s) ans

binToInt :: [DigBin] -> Int
binToInt l1 = binToIntAux (reverse l1) 0 0

binToIntAux :: [DigBin] -> Int -> Int -> Int
binToIntAux (Uno:ls) 0 ans = binToIntAux ls 2 1
binToIntAux (Uno:ls) b ans = binToIntAux ls (b*2) (ans+b)
binToIntAux (Cero:ls) 0 ans = binToIntAux ls 2 ans
binToIntAux (Cero:ls) b ans = binToIntAux ls (b*2) ans
binToIntAux [] b ans = ans

--intToBin :: Int -> [DigBin]
intToBin 0 = [Cero]
intToBin n = intToBinAux n (floor(logBase 2 n))

--intToBinAux :: Int -> Integral -> [DigBin]
intToBinAux n (-1) = []
intToBinAux n p = if (n - 2^p >= 0) then (Uno : intToBinAux (n-2^p) (p-1)) else (Cero : intToBinAux n (p-1))