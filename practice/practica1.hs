-- ejercicio 1
seven x = 7
sign x = (if x>0 then 1 else (if x<0 then -1 else 0))
absolute x = x * sign x
absolute' x = if x<0 then x * (-1) else x
and' x y = x && y
or' x y = x || y
not' True = False
not' False = True
--not' x = if x==True then False else True
xor' x y = if x==True then (if y==True then False else True) else (if y==True then True else False)
isMultiple x y = if mod x y==0 then True else False
isCommonDivisor x y z = if mod y x==0 then (if mod z x==0 then True else False) else False
isCommonMult x y z = if mod x y==0 then (if mod x z==0 then True else False) else False
swap (x,y) = (y,x)

-- ejercicio 2
f'1 x = x
greaterThan (x,y) = (x-y)>0
f'2 (x,y) = x

-- ejercicio 3
power4'1 x = x * x * x * x
power4'2 x = power2 x * power2 x
power2 x = x * x

-- ejercicio 4
-- fib n = if (or' (n==1) (n==0)) then 1 else ((fib (n-1)) + (fib (n-2)))
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

-- ejercicio complementario año sauronico
sauronico x = let w = (mod x 100) in if (and' (w/=0) (mod w 4==0)) then True else (if (mod x 400==0) then True else False)

-- ejercicio complementario sort
sort3'1 (x,y,z) = 1
sort3'2 (x,y,z) = 1
sort3'3 (x,y,z) = 1
