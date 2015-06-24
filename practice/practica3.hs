import Data.Char

--Ejercicio 5
twice :: (a -> a) -> a -> a
twice f x = f (f x)

twice' :: (a -> a) -> a -> a
twice' = \f -> \x -> f (f x)

myflip :: (a -> a -> b) -> a -> a -> b
myflip f x y = f y x

myflip' :: (a -> a -> b) -> a -> a -> b
myflip' = \f -> \x -> \y -> f y x

inc :: Integer -> Integer
inc = (+1)

inc' :: Integer -> Integer
inc' = \x -> x+1

--Ejercicio 6
fix :: ((a -> b) -> a -> b) -> a -> b
fix f x = f (fix f) x

fork :: ((a -> b), (a -> c)) -> a -> (b, c)
fork (f,g) x = (f x,g x)

apply :: (a -> b) -> a -> b
apply f x = f x

curry :: ((a, b) -> c) -> a -> b -> c
curry f x y = f (x,y)

--Ejercicio 7
--a) reducir square(square(3+7))
--square(square(3+7)) = square(3+7) * square(3+7) =
--(3+7) * (3+7) * (3+7) * (3+7) =
--10 * 10 * 10 * 10 = 10000
--b) reducir apply first (const 3 4, (/0) (seven seven))
--apply first (const 3 4, (/0) (seven seven)) = first (const 3 4, (/0) (seven seven)) =
--(const 3 4) = 3

--Ejercicio 8
--(+ -2) no esta definida
--aunque (+ (-2)) = \x -> x + (-2) = \x -> x - 2

--Ejercicio 9
undef x = 1 + undef x

--Ejercicio 10
--las opciones a y c son invalidas porque g recibe dos argumentos y f solo uno, entonces f.g diria que f recibe dos argumentos
--por eso la opcion b es correcta f . (g x) porque g x es una funcion que recibe un argumento

--Ejercicio 11
compose :: (a -> b) -> (c -> a) -> c -> b
compose f g = (\x -> f (g x))

sumDigit c x = compose (+x) digitToInt c