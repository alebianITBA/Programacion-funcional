--Mover cartas: dada una pila de origen, po, una pila de destino, pd y un numero n, si en po hay una secuencia de cartas destapadas de longitud n, ordenadas en
--forma descendente (desde n hasta el tope) y del mismo palo, y si pd esta vacia o la carta en su tope tiene el numero siguiente de la carta mas grande de la se-
--cuencia de po, entonces mueve dicha secuencia de po a pd en un solo movimiento. Si po no quedo vacia, y la carta al tope esta tapada, la destapa. Ademas,
--si en pd se forma una secuencia completa del mismo palo, del As hasta la K, dicha secuencia es removida.
--Repartir: agrega una carta al tope de cada una de las 10 pilas o hasta que el mazo se vacie. Las cartas repartidas se colocan destapadas.
--Para representar el juego, se dispone de los tipos abstractos de datos, Numero, Palo, Carta, Pila, Jugada y Spider, con las siguientes funciones sobre ellos:
getPalo :: Carta -> Palo
--Funcion total que retorna el palo de una carta dada.
getNum :: Carta -> Numero
--Funcion total que retorna el numero de una carta dada.
eqPalo :: Palo -> Palo -> Bool
--Funcion total que retorna si dos palos son iguales.
eqNum :: Numero -> Numero -> Bool
--Funcion total que retorna si dos numeros son iguales.
esSiguiente :: Numero -> Numero -> Bool
--Funcion total que retorna si el primer numero es el siguiente del segundo.
tope :: Pila -> Maybe Carta
--Funcion total que dada una pila retorna, si existe, la carta en el tope de la misma. Si la pila esta vacia, retorna Nothing.
destapadas :: Pila -> [Carta]
--Funcion total que retorna la lista de cartas destapadas de la pila, siendo la cabeza de la lista retornada (si existe), el tope de la pila.
tapadas :: Pila -> [Carta]
--Funcion total que retorna la lista de cartas tapadas de la pila, siendo la cabeza de la lista retornada (si existe), la mas cercana al tope de la pila.
setDestapadas :: Pila -> [Carta] -> Pila
--Funcion total que dada dada una pila p y una lista de cartas cs, retorna una pila q que es como p, pero donde las cartas destapadas de p fueron totalmente reemplazadas por las cartas de cs.
setTapadas :: Pila -> [Carta] -> Pila
--Funcion total que dada dada una pila p y una lista de cartas cs, retorna una pila q que es como p, pero donde las cartas tapadas de p fueron totalmente reemplazadas por las cartas de cs.
agregar :: Carta -> Pila -> Pila
--Funcion total que agrega una carta destapada al tope de la pila dada.
sugerir :: Spider -> [Jugada]
--Funcion total que retorna la lista de las jugadas que es posible realizar en este spider.
realizar :: Spider -> Jugada -> Spider
--Funcion total que realiza una jugada.

--Ejercicio 1)
separar :: Numero -> [Carta] -> ([Carta],[Carta])
separar n cs = separarRec n cs ([], [])

separarRec :: Numero -> [Carta] -> ([Carta],[Carta]) -> ([Carta],[Carta])
separarRec n [] (ant, desp) = (ant, desp)
separarRec n (c:cs) (ant, desp) = if (eqNum n c)
										then (ant++(c:[]), cs++desp)
										else separarRec n cs (ant++(c:[]), desp)

--Ejercicio 2)
reglas :: Pila -> Numero -> Pila -> Bool
reglas po n pd = regla1 po n && regla2 po n && regla3 po n && regla4 pd n

regla1 :: Pila -> Numero -> Bool
regla1 po n = regla1Rec (destapadas po) n
regla1Rec :: [Carta] -> Numero -> Bool
regla1Rec [] n = False
regla1Rec (c:cs) n = if (eqNum (getNum c) n)
						then True
						else regla1Rec cs n

regla2 :: Pila -> Numero -> Bool
regla2 p n = if eqNum getNum(tope p) n
					then True
					else regla2Rec (tope p) tail(first(separar n (destapadas p))) n
regla2Rec :: Carta -> [Carta] -> Numero -> Bool
regla2Rec c [] n = True
regla2Rec prev (c:cs) n = if esSiguiente (getNum c) (getNum prev)
								then regla2Rec c cs n
								else False

regla3 :: Pila -> Numero -> Bool
regla3 p n = checkPalo (first(separar n (destapadas p))) getPalo(tope p)

checkPalo :: [Carta] -> Palo -> Bool
checkPalo [] p = True
checkPalo (c:cs) p = (eqPalo (getPalo c) p) && (checkPalo cs p)

regla4 :: Pila -> Numero -> Bool
regla4 q n = if tope q == Nothing
				then True
				else esSiguiente getNum(tope q) n

--Ejercicio 3)
agregarl :: Pila -> [Carta] -> Pila
agregarl p [] = p
agregarl p (c:cs) = agregar c (agregarl p cs)

destapar :: Pila -> Pila
destapar p = let w = tope p in if w == Nothing
									then p
									else setDestapadas setTapadas(tail (tapadas p)) (w:[])

sacar :: Pila -> Numero -> ([Carta], Pila)
sacar p n = let w = separar n destapadas(p) in if (second w == [])
													then (first w, destapar(tapadas p))
													else (first w, agregarl (tapadas p) (second w))

repartir :: [Pila] -> [Carta] -> ([Pila],[Carta])
repartir p [] = (p, [])
repartir p c = repartirRec p c

repartirRec :: [Pila] -> [Carta] -> ([Pila],[Carta])
repartirRec [] c = ([], c)
repartirRec p [] =  (p, [])
repartirRec (p:ps) (c:cs) = let w = repartirRec ps cs in ((agregarl p (c:[])):first w, second w)

--Ejercicio 4)
spiderSiguientes :: Spider -> [Spider]
spiderSiguientes s = map (realizar s) (sugerir s)
--spiderSiguientes s = spiderSiguientesAux s (sugerir s)
--spiderSiguientesAux :: Spider -> [Jugada] -> [Spider]
--spiderSiguientesAux s [] = []
--spiderSiguientesAux s (j:js) = (realizar s j) : spiderSiguientesAux s js

data AG s = SNode s [AG s]

arbolSpider :: Spider -> AG Spider
arbolSpider s = SNode s (spiderNodes (spiderSiguientes s))
spiderNodes :: [Spider] -> [AG Spider]
spiderNodes ss = map (\x -> SNode x spiderNodes (spiderSiguientes x)) ss
--spiderNodes [] = []
--spiderNodes (l:ls) = (SNode l (spiderNodes (spiderSiguientes l))) : spiderNodes ls

sumarPuntosEn :: Spider -> (Spider->Int) -> Int -> Int -> Bool
sumarPuntosEn s f p n = sumarPuntosEnRec (spiderSiguientes s) f p (n-1) (f s)
sumarPuntosEnRec :: [Spider] -> (Spider->Int) -> Int -> Int -> Int -> Bool
sumarPuntosEnRec [] f p n r = False
sumarPuntosEnRec (l:ls) f p 0 r = if (r>p) then True else False
sumarPuntosEnRec (l:ls) f p n r = if (r>p) then True else sumarPuntosEnRec ls f p (n-1) (r + f l)

--Ejercicio 5)
Identique y mencione condiciones generales
para a y b bajo las cuales se verica la siguiente igualdad.
Justique su respuesta con una demostracion.
f a (foldr f b xs) = foldr f a xs
caso base
f a (foldr f b []) = foldr f a []
por definicion de foldr
f a b = a

f :: t1 -> t2 -> t2
a :: t1
b :: t1
Sugerencia: para tener idea de lo que puede pasar, prue-
be ambos lados de la igualdad con una lista [x1,x2,x3].
