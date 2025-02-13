# Kapittel 3 - Types and classes - Løsningsforslag

Løsningsforslag for kapittel 3 - Types and classes fra Programming in Haskell av Graham Hutton.

## Oppgave 1

```haskell
['a', 'b', 'c'] :: [Char]
```

```haskell
('a', 'b', 'c') :: (Char, Char, Char)
```

```haskell
[(False, '0'), (True, '1')] :: [(Bool, Char)]
```

```haskell
([False, True], ['0', '1']) :: ([Bool], [Char])
```

```haskell
[tail, init, reverse] :: [[a] -> [a]]
```

## Oppgave 2

```haskell
bools :: [Bool]
bools = [True, False, True]
```

```haskell
nums :: [[Int]]
nums = [[1, 2, 3], [1]]
```

```haskell
add :: Int -> Int -> Int -> Int
add x y z = x + y + z
```

```haskell
copy :: a -> (a, a)
copy x = (x, x)
```

```haskell
apply :: (a -> b) -> a -> b
apply f x = f x
```

## Oppgave 3

```haskell
second :: [a] -> a
second xs = head (tail xs)
```

```haskell
swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)
```

```haskell
pair :: a -> b -> (a, b)
pair x y = (x, y)
```

```haskell
double :: Num a => a -> a
double x = x*2
```

```haskell
palindrome :: Eq a => [a] -> Bool
palindrome xs = reverse xs == xs
```

```haskell
twice :: (a -> a) -> a -> a
twice f x = f (f x)
```

## Oppgave 5

Det krever at man sjekker at begge funksjonene man sammenligner gir samme svar for enthvert input. Funksjoner som tar input med en type som kan ha uendelig mange verdier gjør at du må sjekke teste begge funksjonene med uendelig mange input for å sjekke om de er like. Dette kan for eksempel være `Integer`, da må du teste at funksjonene gir samme svar for *alle* mulige integers.
Hvis funksjonene derimot tar inn et input med en type med "få medlemmer" så skal det ikke mye til for å sjekke om funksjonene er like. Dette kan for eksempel være at funksjonene tar inn en `Bool`, da trenger du kun å teste begge funksjonene med `True` og `False`.
