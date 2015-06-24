--Ejercicio 1
-- mod x y resto de x/y
nextDiv :: Integer -> Integer -> Integer
nextDiv x y = if (mod y h == 0) 
                then h 
                else nextDiv h y
    			where h = x + 1

sumDivs :: Integer -> Integer
sumDivs x = sumDivRec x x
			where sumDivRec a b = if (a == 1)
                           			then a
                           			else if (b `mod` a == 0)
                                   			then a + sumDivRec (a-1) b
                                   			else sumDivRec (a-1) b

power 0 0 = error "Operacion no definida"
power _ 0 = 1
power x y = if(y > 0) 
				then x * power x (y-1)
				else powneg x y		
powneg x y = 1 / power x (y*(-1))

--sumatoria :: (Integer -> Num) -> Integer -> Integer -> Num
sumatoria f i j = if (i > j)
					then 0
					else f i + sumatoria f (i+1) j

--prime :: Integer -> Bool
prime 1 = False
prime 2 = True
prime x = primerec 2 x
--primerec :: Integer -> Integer -> Bool
primerec y x = if (mod x y == 0)
					then False
					else if (y < floor (sqrt(fromInteger x)))
							then True && (primerec (y+1) x)
							else True

phi i = phiRec i 2
  where phiRec a b = if prime b
                        then if a == 1
                                then b
                                else phiRec (a-1) (b+1)
                        else phiRec a (b+1)

