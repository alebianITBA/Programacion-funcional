sqr a = a * a

first (x,y) = x
--second (x,y) = y
compose f g = \x -> f (g x)
apply f x = f x
subst f g x = f x (g x)
pairFunc (f1,f2) x y = (f1 (f2 x), f2 (f1 y))

data ColorPrimario = Red | Green | Blue deriving (Show)
data ColorSecundario = Yellow | Cyan | Violet | White deriving (Show)
rojo = Red
azul = Blue
verde = Green
amarillo = Yellow
cian = Cyan
violeta = Violet
blanco = White
mezclar :: ColorPrimario -> ColorPrimario -> ColorSecundario
mezclar Red Green = Yellow
mezclar Red Blue = Violet
mezclar Green Red = Yellow
mezclar Green Blue = Cyan
mezclar Blue Green = Cyan
mezclar Blue Red = Violet

data Point = Pt2 Float Float | Pt3 Float Float Float deriving (Show)
modulo :: Point -> Float
modulo (Pt2 x y) = sqrt(sqr x + sqr y)
modulo (Pt3 x y z) = sqrt(sqr x + sqr y + sqr z)
distancia :: Point -> Point -> Float
distancia (Pt2 x1 y1) (Pt2 x2 y2) = sqrt(sqr(x2 - x1)+sqr(y2 - y1))
distancia (Pt3 x1 y1 z1) (Pt3 x2 y2 z2) = sqrt(sqr(x2 - x1) + sqr(y2 - y1) + sqr(z2 - z1))
xcoord :: Point -> Float
xcoord (Pt2 x y) = x
xcoord (Pt3 x y z) = x
ycoord :: Point -> Float
ycoord (Pt2 x y) = y
ycoord (Pt3 x y z) = y
suma :: Point -> Point -> Point
suma (Pt2 x1 y1) (Pt2 x2 y2) = Pt2 (x1 + x2) (y1 + y2)
suma (Pt3 x1 y1 z1) (Pt3 x2 z2 y2) = Pt3 (x1 + x2) (y1 + y2) (z1 + z2)

data Figura = Circulo Point Float | Rectangulo Point Point deriving (Show)
area :: Figura -> Float
area (Circulo (Pt2 x y) r) = pi * sqr r
area (Rectangulo (Pt2 x1 y1) (Pt2 x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)
perimetro :: Figura -> Float
perimetro (Circulo (Pt2 x y) r) = 2 * pi * r
perimetro (Rectangulo (Pt2 x1 y1) (Pt2 x2 y2)) = (abs $ x2 - x1) * 2 + (abs $ y2 - y1) * 2

data Figura3D = Cubo | Cilindro | Esfera deriving (Show)

type Nombre = String
type Edad = Int
type DNI = String
type Address = String
type Phone = String
type Waddress = String
type Wphone = String
data Persona = Person Nombre Edad DNI Address Phone | WPerson Nombre Edad DNI Address Phone Waddress Wphone deriving (Show)

--tom x = x x
--tom no tiene tipo porque calcularlo da halting

--smaller (x,y,z) | x <= y && x <= z = x
--				| y <= x && y <= z = y
--				| z <= x && z <= y = z
--smaller = \(x,y,z) -> if x <= y && x <= z then x else if y <= x && y <= z then y else z
--second x = \x -> x
second = \x -> \y -> y
--andThen True = \a -> a
--andThen False = \a -> False
andThen = \x -> \y -> if x then y else False

--iff = \x -> \y -> if x then not y else y
iff x y = if x then not y else y
--alpha = \x -> \x -> x
alpha x y = y

coeficients :: Floating a => (a, a, a) -> (a, a)
coeficients (a,b,c) = (((-1)*b+x)/2*a,((-1)*b-x)/2*a) where x = sqrt(sqr(b)-4*a*c)