type Coord = (Int , Int)
data Game = Start Int | Move Coord Coord Game deriving (Show)

--EJ 1) Utilizando recursion explicita 
--devuelve el max de los movimientos posibles 
range :: Game -> Int
--range (Start k) = k
--range (Move ca cd j) = range j

burned :: Game -> (Coord -> Bool) -- (entender set como a->Bool)
--burned (Start k) = \ _ -> False
--burned (Move ca cd j) = (\coord -> coord == cd || burned j coord)

position :: Game -> Coord -- (La posicion del angel)
--position (Start k) = (0,0)
--position (Move ca cd j) = let pos = position j in (fst ca + fst pos, snd ca + snd pos)

--EJ 2) Crear un foldg para Game y decir su tipo
--foldr f z []     = z 
--foldr f z (x:xs) = f x (foldr f z xs) 
foldg ::  (Int -> a) -> (Coord -> Coord -> a -> a) -> Game -> a
foldg f g (Start k) = f k
foldg f g (Move ca cd j) = g ca cd (foldg f g j)

--EJ 3) sin utilizar recursion explicita 
--range, burned, position,
range j = foldg id (\ _ _ x -> x) j

burned j = foldg (\_ -> \_ -> False) (\_ cd val -> \coord -> coord == cd || val coord ) j

position j = foldg (\_ -> (0,0)) (\ca cd pos -> (fst ca + fst pos, snd ca + snd pos)) j

-- choices: las que eligieron hasta ahora
choices :: Game -> [(Coord, Coord)]
choices j = foldg (\_ -> []) (\ca cd ch -> (ca, cd):ch ) j

--reachable :: Game -> [Coord] --(suponer que existe la funcion scoop p k que devuelve un [Coord])
--reachable j = foldg (\k -> scoop (position j) k ) (\ca cd reach -> if(!burned j ca) then reach ++ ca else reach) j

build :: Int -> [Coord] -> [Coord] -> Maybe Game
build k caa cdd = foldr (\l j -> play (fst l) (snd l) j) (Just (Start k)) (zip caa cdd)

play :: Coord -> Coord -> Maybe Game -> Maybe Game
play ca cd j = case j of
					Just x -> if (not (burned x ca)) then Just (Move ca cd x) else Nothing
					Nothing -> Nothing


-- EJ 4) demostrar que (set (snd) (unzip(choices j))) = burned j

--set :: Ord a => [a] -> Set a
--set xs = ('elem' xs)

-- unzip, fst, snd


--elem _ xs = False
--elem x (y:xs) = x == y || elem x xs 

--DEMOSTRACION:

--set (snd(unzip (choices j))) = burned j

--burned (Start k) = \_ -> False
--burned (Move ca cd j) = \c -> cd== c || burned j c

--choiced = foldg (\k -> []) (\ ca cd xjs -> (ca,cd) : xjs)

--dem: induccion en estructura de j
--CB= j = Start K  (set snd unzip choices (start k))= burned (start k)

--CB = j = move ca cd j

--	hi: set snd unzip choices j' = burned j'
--	ti: set snd unzip choices (Move ca cd j') = burned (Move ca cd j')


--CB 

--set (snd (unzip (foldg )))