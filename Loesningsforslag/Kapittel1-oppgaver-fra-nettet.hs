module Uke1 where

-- ======================== ⭐ Exercise 1 ⭐ ========================

-- Løsningsforslag 1 - if-setning og list comprehension
-- -------------------------------------------------------------------
toDigits :: Integer -> [Integer]
toDigits number = if   number <= 0
                  then []
                  else [read [charDigit] | charDigit <- show number]
-- -------------------------------------------------------------------

-- Løsningsforslag 2 - guards og list comprehension
-- -------------------------------------------------------------------
toDigits' :: Integer -> [Integer]
toDigits' number
    | number <= 0 = []
    | otherwise   = [read [charDigit] | charDigit <- show number]
-- -------------------------------------------------------------------

-- Løsningsforslag 3 - if-setning og map
-- -------------------------------------------------------------------
toDigits'' :: Integer -> [Integer]
toDigits'' number = if   number <= 0
                    then []
                    else map (\charDigit -> read [charDigit]) (show number)
-- -------------------------------------------------------------------

-- Løsningsforslag 4 - guards og map
-- -------------------------------------------------------------------
toDigits''' :: Integer -> [Integer]
toDigits''' number
    | number <= 0 = []
    | otherwise   = map (\charDigit -> read [charDigit]) (show number)
-- -------------------------------------------------------------------

-- Løsningsforslag for reverse der toDigits kunne vært hvilken som
-- helst av løsningsforslagene over
-- -------------------------------------------------------------------
toDigitsRev :: Integer -> [Integer]
toDigitsRev number = reverse (toDigits number)
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 2 ⭐ ========================

-- Løsningsforslag 1
-- doubleEveryOther og doubleEveryOther' henger sammen som en del
-- av løsningsforslaget
-- -------------------------------------------------------------------
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther numbers = reverse (doubleEveryOther' (reverse numbers))

doubleEveryOther' :: [Integer] -> [Integer]
doubleEveryOther' []                         = []
doubleEveryOther' [number]                   = [number]
doubleEveryOther' (number1 : number2 : rest) = number1 : number2*2 : doubleEveryOther' rest
-- -------------------------------------------------------------------

-- Løsningsforslag 2
-- -------------------------------------------------------------------
doubleEveryOther'' :: [Integer] -> [Integer]
doubleEveryOther'' numbers = reverse (doubleEveryOther''' (reverse numbers))

doubleEveryOther''' :: [Integer] -> [Integer]
doubleEveryOther''' numbers = if   (length numbers) <= 1
                              then numbers
                              else head numbers : (head (tail numbers))*2 : doubleEveryOther''' (tail (tail numbers))
-- -------------------------------------------------------------------

-- Løsningsforslag 3
-- -------------------------------------------------------------------
doubleEveryOther'''' :: [Integer] -> [Integer]
doubleEveryOther'''' numbers = reverse (doubleEveryOther''''' (reverse numbers))

doubleEveryOther''''' :: [Integer] -> [Integer]
doubleEveryOther''''' numbers = if   (length numbers) <= 1
                                then numbers
                                else numbers !! 0 : (numbers !! 1)*2 : doubleEveryOther''''' (tail (tail numbers))
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 3 ⭐ ========================

-- Løsningsforslag 1
-- -------------------------------------------------------------------
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (digit:digits) = sum (toDigits digit) + sumDigits digits
-- -------------------------------------------------------------------

-- Løsningsforslag 2
-- -------------------------------------------------------------------
sumDigits' :: [Integer] -> Integer
sumDigits' digits = if   digits == []
                    then 0
                    else sum (toDigits (head digits)) + sumDigits (tail digits)
-- -------------------------------------------------------------------

-- Løsningsforslag 3
-- -------------------------------------------------------------------
sumDigits'' :: [Integer] -> Integer
sumDigits'' digits
    | digits == [] = 0
    | otherwise    = sum (toDigits (head digits)) + sumDigits (tail digits)
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 4 ⭐ ========================

validate :: Integer -> Bool
validate number = (sumDigits (doubleEveryOther (toDigits number)) `mod` 10) == 0

-- ======================== ⭐ Exercise 5 ⭐ ========================

type Peg  = String
type Move = (Peg, Peg)

-- Løsningsforslag 1
-- -------------------------------------------------------------------
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi number a b c = if   number == 0
                     then []
                     else hanoi (number - 1) a c b ++ [(a, b)] ++ hanoi (number - 1) c b a
-- -------------------------------------------------------------------

-- Løsningsforslag 2
-- -------------------------------------------------------------------
hanoi' :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi' number a b c
    | number == 0 = []
    | otherwise   = hanoi' (number - 1) a c b ++ [(a, b)] ++ hanoi' (number - 1) c b a
-- -------------------------------------------------------------------