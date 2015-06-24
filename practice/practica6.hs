--Ejercicio 6
belongs a [] = False
belongs a (x:xs) = a == x || belongs a xs

union xs [] = xs
union [] xs = xs
union (x:xs) l = if belongs x l
                    then union xs l
                    else union xs (x:l)

intersection xs [] = []
intersection [] xs = []
intersection (x:xs) l = if belongs x l
                           then intersection xs (x:l)
                           else intersection xs l

--Ejercicio 2
data TipTree a = Tip a | Join (TipTree a) (TipTree a)

heightTip :: TipTree a -> Int
heightTip (Tip a) = 0
heightTip (Join t1 t2) = 1 + max (heightTip t1) (heightTip t2)

leaves :: TipTree a -> Int
leaves (Tip a) = 1
leaves (Join t1 t2) = leaves t1 + leaves t2

nodes :: TipTree a -> Int
nodes (Tip a) = 0
nodes (Join t1 t2) = 1 + nodes t1 + nodes t2

walkover :: TipTree a -> [a]
walkover (Tip a) = [a]
walkover (Join t1 t2) = (walkover t1) ++ (walkover t2)

mirrorTip :: TipTree a -> TipTree a
mirrorTip (Tip a) = Tip a
mirrorTip (Join t1 t2) = Join (mirrorTip t2) (mirrorTip t1)

mapTip :: (a -> a) -> TipTree a -> TipTree a
mapTip f (Tip a) = Tip (f a)
mapTip f (Join t1 t2) = Join (mapTip f t1) (mapTip f t2)

--Ejercicio 3
data List a = Empty a | Head a (List a)

--Ejercicio 4
data Seq a = Nil | Unit a | Cat (Seq a) (Seq a)

appSeq :: Seq a -> Seq a -> Seq a
appSeq s1 Nil = s1
appSeq Nil s2 = s2
appSeq s1 s2 = Cat s1 s2

conSeq :: a -> Seq a -> Seq a
conSeq a Nil = Unit a
conSeq a s2 = Cat (Unit a) s2

lenSeq :: Seq a -> Int
lenSeq Nil = 0
lenSeq (Unit a) = 1
lenSeq (Cat s1 s2) = lenSeq s1 + lenSeq s2
--lenSeq (Cat s1 s2) = 1 + lenSeq s1 + lenSeq s2 ?

revSeq :: Seq a -> Seq a
revSeq Nil = Nil
revSeq (Unit a) = Unit a
revSeq (Cat s1 s2) = Cat (revSeq s2) (revSeq s1)

headSeq :: Seq a -> Seq a
headSeq Nil = Nil
headSeq (Unit a) = Unit a
headSeq (Cat s1 s2) = headSeq s1

tailSeq :: Seq a -> Seq a
tailSeq Nil = Nil
tailSeq (Unit a) = Nil
tailSeq (Cat s1 s2) = Cat (tailSeq s1) s2

normSeq :: Seq a -> Seq a
normSeq Nil = Nil
normSeq (Unit a) = Unit a
normSeq (Cat Nil Nil) = Nil
normSeq (Cat s1 Nil) = normSeq s1
normSeq (Cat Nil s2) = normSeq s2
normSeq (Cat s1 s2) = Cat (normSeq s1) (normSeq s2)

eqSeq :: Eq a => Seq a -> Seq a -> Bool
eqSeq Nil Nil = True
eqSeq Nil _ = False
eqSeq _ Nil = False
eqSeq (Unit a) (Unit b) = (a==b)
eqSeq (Unit a) _ = False
eqSeq _ (Unit b) = False
eqSeq (Cat s1 s2) (Cat s3 s4) = (eqSeq s1 s3) && (eqSeq s2 s4)

seq2List :: Seq a -> [a]
seq2List Nil = []
seq2List (Unit a) = [a]
seq2List (Cat s1 s2) = (seq2List s1) ++ (seq2List s2)

--La desventaja es que la sintaxis es mas complicada y dificil de entender. La ventaja es que algunos algoritmos son mas eficientes log n en vez de n

--Ejercicio 5
data Form = Atom
          | Or Form Form
          | Implies Form Form
          | Forall Var Form
          | Not Form
          | And Form Form
          | Iff Form Form
          | Exists Var Form

normalize :: Form -> Form
normalize Atom = Atom
normalize (Or f1 f2) = Or (normalize f1) (normalize f2)
normalize (Implies f1 f2) = Or (Not (normalize f1)) (normalize f2)
normalize (Forall Var f1) = Not (Exists Var (Not(normalize f1)))
normalize (Not f1) = Not (normalize f1)
normalize (And f1 f2) = Not (normalize(Implies (f1) (Not f2)))
normalize (Iff f1 f1) = normalize (And (Implies f1 f2) (Implies f2 f1))
normalize (Exists Var f1) = Exists Var (normalize f1)

data FN = AtomN
        | NotN FN
        | OrN FN FN
        | ExistsN Var FN

fn2FN :: Form -> FN
fn2FN Atom = AtomN
fn2FN (Or f1 f2) = OrN (fn2FN f1) (fn2FN f2)
fn2FN (Not f1) = NotN (fn2FN f1)
fn2FN (Exists Var f1) = ExistsN Var (fn2FN f1)

form2FN :: Form -> FN
form2FN f = fn2FN (normalize f)
