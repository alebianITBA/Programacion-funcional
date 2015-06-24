module CustomStack
( emptyCS
, isEmptyCS
, pushCS
, popCS
, topCS
, sizeCS
) where

Data CustomStack a = Nil | CStack a (CustomStack a)
emptyCS :: Stack a
emptyCS = Nil

isEmptyCS :: Stack a -> Bool
isEmptyCS Nil = True
isEmptyCS _ = False

pushCS :: a -> Stack a -> Stack a
pushCS el cs = CStack el cs

popCS :: Stack a -> Stack a
popCS Nil = Nil
popCS (CStack el cs) = cs

topCS :: Stack a -> a
topCS Nil = Nil
topCS (CStack el cs) = el

sizeCS :: Stack a -> Int
sizeCS Nil = 0
sizeCS (CStack el cs) = 1 + sizeCS cs