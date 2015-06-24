import CustomStack
import CustomSortedList

--Ejercicio 1)
-- El primer parametro es el string, el segundo es el sibolo de apertura, el tercero el de cierre
isBalanced :: [Char] -> Char -> Char -> Bool
isBalanced string open close = isSBalanced string emptyCS open close

isSBalanced :: [Char] -> CustomStack -> Char -> Char -> Bool
isSBalanced [] s o c = True
isSBalanced (ls:l) s o c = if (ls == o) 
								then isSBalanced l (pushCS o s) o c
								else if (ls == c)
											then if (isEmptyCS s) 
														then False
														else isSBalanced l (popCS s) o c
											else isSBalanced l s o c

--isSBalanced (o:l) s o c = isSBalanced l (pushS o s) o c
--isSBalanced (c:l) s o c = if (isEmptyS s) 
--								then False
--								else isSBalanced l (popS s) o c
--isSBalanced (ls:l) s o c = isSBalanced l s o c

--Ejercicio 2)
resort :: (a -> a -> Bool) -> SL a -> SL a
resort f ol = resortRec (buildSL f) ol
resortRec :: SL a -> SL a -> SL a
resortRec ans orig = if (isEmptySL orig) 
						then ans
						else resortRec (insertSL (headSL orig) ans) (tailSL orig)

sizeSL :: SL a -> Int
sizeSL ol = if (isEmptySL ol)
				then 0
				else 1 + sizeSL (tailSL ol)

list2SL :: (a -> a -> Bool) -> [a] -> SL a
list2SL f list = list2SLRec (buildSL f) list
list2SLRec :: SL a -> [a] -> SL a
list2SLRec ol [] = ol
list2SLRec ol (xs:x) = list2SLRec (insertSL xs) x

sl2list :: SL a -> [a]
sl2list ol = if (isEmptySL ol)
				then []
				else (headSL ol) : sl2list (tailSL ol)

sortIntSL :: [Int] -> [Int]
sortIntSL list = sl2list (list2SL (\x -> \y -> x<=y ) list)

sortBySL :: (a -> a -> Bool) -> [a] -> [a]
sortBySL f list = sl2list (list2SL f list)