module Kapittel5 where

import Data.Char

-- ======================== ⭐ Exercise 1 ⭐ ========================

-- -------------------------------------------------------------------
sumOfFirstHundredSquares :: Int
sumOfFirstHundredSquares = sum [x^2 | x <- [1..100]]
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 2 ⭐ ========================

-- -------------------------------------------------------------------
grid :: Int -> Int -> [(Int, Int)]
grid m n = [(x, y) | x <- [0..m], y <- [0..n] ]
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 3 ⭐ ========================

-- -------------------------------------------------------------------
square :: Int -> [(Int, Int)]
square n = [(x, y) | (x, y) <- grid n n, x /= y]
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 4 ⭐ ========================

-- -------------------------------------------------------------------
replicate' :: Int -> a -> [a]
replicate' n x = [x | _ <- [1..n]]
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 5 ⭐ ========================

-- -------------------------------------------------------------------
pyths :: Int -> [(Int, Int, Int)]
pyths n = [(x, y, z) | x <- [1..n],
                       y <- [1..n],
                       z <- [1..n],
                       x^2 + y^2 == z^2]
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 6 ⭐ ========================

-- -------------------------------------------------------------------
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

-- Bruker init for å ikke telle med selve n i summen
perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum(init(factors x)) == x]

-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 7 ⭐ ========================

-- -------------------------------------------------------------------

singleGenerator :: [Int]
singleGenerator = concat [[(x, y) | y <- [3, 4]] | x <- [1, 2]]

-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 8 ⭐ ========================

-- -------------------------------------------------------------------

find :: Eq a => a -> [(a, b)] -> [b]
find k t = [v | (k', v) <- t, k == k']

positions :: Eq a => a -> [a] -> [Int]
positions x xs = find x (zip xs [0..])

-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 9 ⭐ ========================

-- -------------------------------------------------------------------
scalarproduct :: [Int] -> [Int] -> Int
scalarproduct xs ys = sum [x*y | (x, y) <- zip xs ys]
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 10 ⭐ ========================

-- -------------------------------------------------------------------

-- Liten bokstav til tall (bokstavens plassering i alfabetet)
lower2int :: Char -> Int
lower2int c = ord c - ord 'a'

-- Tall til liten bokstav
int2lower :: Int -> Char
int2lower n = chr (ord 'a' + n)

-- Stor bokstav til tall
upper2int :: Char -> Int
upper2int c = ord c - ord 'A' 

-- Stor bokstav til tall
int2upper :: Int -> Char
int2upper n = chr (ord 'A' + n)

-- Gjør alle bokstaver i en streng til små bokstaver
lowers :: String -> Int
lowers xs = length [x | x <- xs, x >= 'a' && x <= 'z']

-- Teller antall forekomster av en bokstav i en streng
count :: Char -> String -> Int
count x xs = length [x' | x' <- xs, x == x']

-- Forskjellen fra boka er at vi gjør xs til en streng med små
-- bokstaver før vi teller antall forekomster av hver bokstav
freqs :: String -> [Float]
freqs xs = [percent (count x (map toLower xs)) n | x <- ['a'..'z']]
    where
        n   = lowers xs

shift :: Int -> Char -> Char
shift n c
    | isLower c = int2lower ((lower2int c + n) `mod` 26)
    | isUpper c = int2upper ((upper2int c + n) `mod` 26)
    | otherwise = c

encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]

table :: [Float]
table = [8.1, 1.5, 2.8, 4.2, 12.7, 2.2, 2.0, 6.1, 7.0,
         0.2, 0.8, 4.0, 2.4, 6.7, 7.5, 1.9, 0.1, 6.0,
         6.3, 9.0, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1]

percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m) * 100

-- Teller antall *bokstaver* i en streng
-- isAlpha sjekker om x (Char) er en bokstav slik at den kun tar med
-- det i strengen som er en bokstav
letters :: String -> Int
letters xs = length [x | x <- xs, isAlpha x]

-- -------------------------------------------------------------------