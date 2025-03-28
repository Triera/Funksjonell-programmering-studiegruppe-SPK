module Kapittel8 where

import Data.List

-- ======================== ⭐ Exercise 1 ⭐ ========================

-- -------------------------------------------------------------------
data Nat = Zero | Succ Nat

add :: Nat -> Nat -> Nat
add Zero     m = m
add (Succ n) m = Succ (add n m)

mult :: Nat -> Nat -> Nat
mult m Zero     = Zero
mult m (Succ n) = add m (mult n m)
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 2 ⭐ ========================

-- -------------------------------------------------------------------
data Tree a = Leaf a | Node (Tree a) a (Tree a)

occurs :: Ord a => a -> Tree a -> Bool
occurs x (Leaf y)     = x == y
occurs x (Node l y r) = case compare x y of
                            LT -> occurs x l
                            EQ -> True
                            GT -> occurs x r
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 3 ⭐ ========================

-- -------------------------------------------------------------------
data Tree' a = Leaf' a | Node' (Tree' a) (Tree' a)

leaves :: Tree' a -> Int
leaves (Leaf' _) = 1
leaves (Node' l r) = leaves l + leaves r

balanced :: Tree' a -> Bool
balanced (Leaf' _) = True
balanced (Node' l r) = abs (leaves l - leaves r) <= 1
                      && balanced l && balanced r
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 4 ⭐ ========================

-- -------------------------------------------------------------------
halve xs = splitAt (length xs `div` 2) xs

balance [x] = Leaf' x
balance xs  = Node' (balance ys) (balance xs)
    where (ys, zs) = halve xs
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 5 ⭐ ========================

-- -------------------------------------------------------------------
data Expr' = Val' Int | Add' Expr' Expr'

folde :: (Int -> a) -> (a -> a -> a) -> Expr' -> a
folde f _ (Val' int  ) = f int
folde f g (Add' e1 e2) = g (folde f g e1) (folde f g e2)
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 6 ⭐ ========================

-- -------------------------------------------------------------------
eval :: Expr' -> Int
eval e = folde (id) (+) e

eval' :: Expr' -> Int
eval' = folde (id) (+)

eval'' :: Expr' -> Int
eval'' e = folde (\x -> x) (\x y -> x + y) e

size :: Expr' -> Int
size e = folde (\_ -> 1) (\x y -> x + y) e

size' :: Expr' -> Int
size' = folde (\_ -> 1) (\x y -> x + y)

-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 7 ⭐ ========================

-- -------------------------------------------------------------------
data Maybe' a = Nothing' | Just' a 

instance Eq a => Eq (Maybe' a) where
    Nothing'  == Nothing'  = True
    (Just' x) == (Just' y) = x == y
    _         == _        = False

-- instance Eq a => Eq [a] where
--     [ ]    == [ ] = []
--     (x:xs) == (y:ys) = if   x == y
--                        then xs == ys
--                        else False
--     _      == _      = False
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 8 ⭐ ========================

-- -------------------------------------------------------------------
-- Lagt til konstruktørene `Or` (logical disjunction v) og `Equiv`
-- (equivalence <=>) i definisjonen av `Prop` fra boka
data Prop = Const Bool
          | Var   Char
          | Not   Prop
          | And   Prop Prop
          | Or    Prop Prop
          | Imply Prop Prop
          | Equiv Prop Prop

-- Definisjoner fra boka
type Assoc k v = [(k, v)]
type Subst = Assoc Char Bool

find' :: Char -> Subst -> Bool
find' x [] = False
find' x ((k, v):rest) = if   x == k
                        then v
                        else False 

-- Lagt til pattern-matching for `Or` or `Equiv`
eval''' :: Subst -> Prop -> Bool
eval''' _ (Const b  ) = b
eval''' s (Var   x  ) = find' x s
eval''' s (Not   p  ) = not (eval''' s p)
eval''' s (And   p q) = eval''' s p && eval''' s q
eval''' s (Or    p q) = eval''' s p || eval''' s q
eval''' s (Imply p q) = eval''' s p <= eval''' s q
eval''' s (Equiv p q) = eval''' s p == eval''' s q

-- Lagt til pattern-matching for `Or` or `Equiv`
vars :: Prop -> [Char]
vars (Const  _  ) = []
vars (Var    x  ) = [x]
vars (Not    p  ) = vars p
vars (And    p q) = vars p ++ vars q
vars (Or     p q) = vars p ++ vars q
vars (Imply  p q) = vars p ++ vars q
vars (Equiv  p q) = vars p ++ vars q

-- Fra boka
bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n = map (False:) bss ++ map (True:) bss
    where bss = bools (n - 1)

rmdups :: Eq a => [a] -> [a]
rmdups xs = nub xs

-- Fra boka
subst :: Prop -> [Subst]
subst p = map (zip vs) (bools (length vs))
    where vs = rmdups (vars p)

-- Fra boka
isTaut :: Prop -> Bool
isTaut p = and [eval''' s p | s <- subst p]

-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 9 ⭐ ========================

-- -------------------------------------------------------------------
-- Lagt til konstruktøren `Mult`
data Expr = Val Int | Add Expr Expr | Mult Expr Expr

-- Fra boken
type Cont = [Op]

-- Lagt til konstruktøren `Mult`
data Op = EVAL Expr | ADD Int | MULT Int

-- Lagt til pattern-matcing for `MULT`
exec :: Cont -> Int -> Int
exec [] n = n
exec (EVAL y : x) n = eval'''' y (ADD n : x)
exec (ADD  n : c) m = exec c (n + m)
exec (MULT n : c) m = exec c (n * m)

-- Lagt til pattern-matcing for `Mult`
eval'''' :: Expr -> Cont -> Int
eval'''' (Val  n  ) c = exec c n
eval'''' (Add  x y) c = eval'''' x (EVAL y : c)
eval'''' (Mult x y) c = eval'''' x (EVAL y : c)

value' :: Expr -> Int
value' e = eval'''' e []

-- -------------------------------------------------------------------
