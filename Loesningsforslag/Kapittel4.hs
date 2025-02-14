module Kapittel4 where

-- ======================== ⭐ Exercise 1 ⭐ ========================

-- Løsningsforslag 1 - bruker splitAt
-- -------------------------------------------------------------------
halve :: [a] -> ([a], [a])
halve list = splitAt (length list `div` 2) list
-- -------------------------------------------------------------------

-- Løsningsforslag 2
-- -------------------------------------------------------------------
halve' :: [a] -> ([a], [a])
halve' list = (take half list, drop half list)
    where half = length list `div` 2
-- -------------------------------------------------------------------

-- Løsningsforslag 3
-- -------------------------------------------------------------------
halve'' :: [a] -> ([a], [a])
halve'' list =
    let half = length list `div` 2 in
        (take half list, drop half list)
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 2 ⭐ ========================

-- Løsningsforslag 1 - bruk av `head` og `tail`
-- -------------------------------------------------------------------
third :: [a] -> a
third list = head (tail (tail list))
-- -------------------------------------------------------------------

-- Løsningsforslag 2 - listeindeksering `!!`
-- -------------------------------------------------------------------
third' :: [a] -> a
third' list = list !! 2
-- -------------------------------------------------------------------

-- Løsningsforslag 3 - pattern matching
-- -------------------------------------------------------------------
third'' :: [a] -> a
third'' (_:_:x:_) = x
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 3 ⭐ ========================

-- Løsningsforslag 1 - conditional expression
-- -------------------------------------------------------------------
safetail :: [a] -> [a]
safetail list = if   null list
                then list
                else tail list
-- -------------------------------------------------------------------

-- Løsningsforslag 2 - guards
-- -------------------------------------------------------------------
safetail' :: [a] -> [a]
safetail' list
    | null list = list
    | otherwise = tail list
-- -------------------------------------------------------------------

-- Løsningsforslag 3 - pattern matching v.1
-- -------------------------------------------------------------------
safetail'' :: [a] -> [a]
safetail'' []   = []
safetail'' list = tail list
-- -------------------------------------------------------------------

-- Løsningsforslag 3 - pattern matching v.2
-- -------------------------------------------------------------------
safetail''' :: [a] -> [a]
safetail''' list =
    case null list of
        True  -> list
        False -> tail list
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 4 ⭐ ========================

-- Løsningsforslag 1 - pattern matching der vi skriver ut enhver mulig
--                     kombinasjon
-- Kan for kalle på denne som infix slik: True `v` False
-- -------------------------------------------------------------------
v :: Bool -> Bool -> Bool
v True  True  = True
v True  False = True
v False True  = True
v False False = False
-- -------------------------------------------------------------------

-- Løsningsforslag 2
-- -------------------------------------------------------------------
v' :: Bool -> Bool -> Bool
v' False False = False
v' _     _     = True
-- -------------------------------------------------------------------

-- Løsningsforslag 3
-- -------------------------------------------------------------------
v'' :: Bool -> Bool -> Bool
v'' False b = b
v'' True  _ = True
-- -------------------------------------------------------------------

-- Løsningsforslag 4
-- -------------------------------------------------------------------
v''' :: Bool -> Bool -> Bool
v''' b1 b2
    | b1 == b2  = b1
    | otherwise = True
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 5 ⭐ ========================

-- -------------------------------------------------------------------
and' :: Bool -> Bool -> Bool
and' a b = if a == True
           then if b == True
                then True
                else False
           else False
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 6 ⭐ ========================

-- -------------------------------------------------------------------
and'' :: Bool -> Bool -> Bool
and'' a b = if   a
            then b
            else False
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 7 ⭐ ========================

-- Husk at Int -> Int -> Int -> Int er det samme som
-- Int -> (Int -> (Int -> Int))
-- -------------------------------------------------------------------
mult :: Int -> (Int -> (Int -> Int))
mult = (\x -> (\y -> (\z -> x*y*z)))
-- -------------------------------------------------------------------

-- ======================== ⭐ Exercise 8 ⭐ ========================

-- Løsningsforslag 1
-- -------------------------------------------------------------------

luhnDouble :: Int -> Int
luhnDouble digit =
    let result = digit*2 in
        if   result > 9
        then result - 9
        else result

luhn :: Int -> Int -> Int -> Int -> Bool
luhn d1 d2 d3 d4 =
    let result = (luhnDouble d1 + d2 + luhnDouble d3 + d4) in
        result `mod` 10 == 0

-- Løsningsforslag 2
-- -------------------------------------------------------------------
luhnDouble' :: Int -> Int
luhnDouble' digit = if   result > 9
                    then result - 9
                    else result
    where result = digit*2

luhn' :: Int -> Int -> Int -> Int -> Bool
luhn' d1 d2 d3 d4 = result `mod` 10 == 0
    where result = luhnDouble' d1 + d2 + luhnDouble' d3 + d4
-- -------------------------------------------------------------------

-- Løsningsforslag 3
-- -------------------------------------------------------------------
luhnDouble'' :: Int -> Int
luhnDouble'' digit = if   digit*2 > 9
                     then digit*2 - 9
                     else digit*2

luhn'' :: Int -> Int -> Int -> Int -> Bool
luhn'' d1 d2 d3 d4 = (luhnDouble'' d1 + d2 + luhnDouble'' d3 + d4) `mod` 10 == 0
-- -------------------------------------------------------------------