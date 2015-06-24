import Data.Char
{-
filter :: (a -> Bool) -> [a] -> [a]
filter f [] = []
filter f (x:xs) = if f x
                  then x:(filter f xs)
                  else filter f xs

map :: (a -> b) -> [a] -> [b]
map f [] = []
map f (x:xs) = f x : map f xs

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z [] = z
foldr f z (x:xs) = f x (foldr f z xs)
-}

--Ejercicio 1
sumlist :: Num a => [a] -> a
sumlist = foldr (\n b -> n + b) 0

anyinlist :: [Bool] -> Bool
anyinlist = foldr (\x b -> x || b) False

allinlist :: [Bool] -> Bool
allinlist = foldr (\x b -> x && b) True

codes :: [Char] -> [Int]
codes = map ord

remainders :: Int -> [Int] -> [Int]
remainders n = map (\x -> mod x n)

squares :: [Int] -> [Int]
squares = map (\x -> x*x)

lengths :: [[a]] -> [Int]
lengths = map length

order :: [(Int,Int)] -> [(Int,Int)]
order = filter (\(a,b) -> a<3*b)

pairs :: [Int] -> [Int]
pairs = filter (\x -> mod x 2 == 0)

chars :: [Char] -> [Char]
chars = filter isAlpha

moreThan :: Int -> [[a]] -> [[a]]
moreThan n = filter (\x -> length x > n)

--Ejercicio 2
pal :: [Char] -> Bool
pal s = (s == reverse s)

hs :: [[Char]] -> Int
hs = foldr (\(x:xs) b -> if (x=='h' || x=='H') then 1+b else b) 0

avgLength :: Fractional b => [[a]] -> b
avgLength []     = 0
avgLength (x:xs) = fromIntegral (sum (lengths (x:xs))) / fromIntegral (length (x:xs))

adjacents :: [a] -> [(a,a)]
adjacents [] = []
adjacents [_] = []
adjacents (x:y:zs) = (x,y) : adjacents (y:zs)

diffAdj :: [Int] -> [(Int,Int)]
diffAdj [] = []
diffAdj [_] = []
diffAdj (x:y:zs) = if (mod (x-y) 2 == 0) then (x,y):diffAdj(y:zs) else diffAdj (y:zs)

remDups :: [Int] -> [Int]
remDups [] = []
remDups [a] = [a]
remDups (x:y:zs) = if (x==y) then remDups(y:zs) else x:remDups(y:zs)

---------------------------GUIA 4-------------------------------
prime 1 = False
prime 2 = True
prime x = primerec 2 x

primerec y x = if (mod x y == 0)
					then False
					else if (y < floor (sqrt(fromInteger x)))
							then True && (primerec (y+1) x)
							else True
----------------------------------------------------------------
primes n = if(n>0) then primesRec (n-1) 2 [2] else []
primesRec n ult ans = if(n>0)
						then (if prime(ult+1) 
									then primesRec (n-1) (ult+1) (ans++[ult+1]) 
									else primesRec n (ult+1) ans) 
						else ans

--Ejercicio 3
f :: [a] -> [a]
f = foldr (:) []
--Devuelve la misma lista
f' (x:xs) = (x:xs)

--Ejercicio 4
filtro f list = filtroAux list (map f list)
filtroAux (l1:l1s) (l2:l2s) = if l2 then [l1] ++ (filtroAux l1s l2s) else [] ++ (filtroAux l1s l2s)

--Ejercicio 5
takewhile :: (a -> Bool) -> [a] -> [a]
takewhile f l = takewhilerec f False l
--El boolean sirve como flag para saber si alguna vez cumplio con la condicion o no
takewhilerec :: (a -> Bool) -> Bool -> [a] -> [a]
takewhilerec f _ [] = []
takewhilerec f False (x:xs) = if f x then x : (takewhilerec f True xs) else takewhilerec f False xs
takewhilerec f True (x:xs) = if f x then x : (takewhilerec f True xs) else []

dropwhile :: (a -> Bool) -> [a] -> [a]
dropwhile f [] = []
dropwhile f (x:xs) = if f x then [] else x : dropwhile f xs

--Ejercicio 6
ffreshIndex :: [Lt] -> Int
