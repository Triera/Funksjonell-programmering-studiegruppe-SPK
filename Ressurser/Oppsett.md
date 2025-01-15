# Stack

[Tilbake til hovedsiden.](../README.md)

For å enkelt lage Haskell-prosjekter så bruker vi programmet ["The Haskell Tool Stack"](https://docs.haskellstack.org/en/stable/). Ved å laste ned Stack får du med Glasgow Haskell Compiler (GHC) som kompilerer Haskell-kode og som kan brukes interaktivt. Du kan også enkelt laste ned pakker og opprette, bygge, teste, kjøre og installere Haskell-prosjekter.

Følg instruksjonene på ["How to install Stack"](https://docs.haskellstack.org/en/stable/#how-to-install-stack) under fanen "Directly" for operativsystemet og arkitekturen som din maskin har. Du trenger _ikke_ å følge det som står videre under "Quick Start guide", følg heller det som står videre her.

# Stack repl

Den enkleste måten å leke med Haskell-kode er ved å åpne en _REPL_. Det står for read-eval-print loop. Det lar deg skrive uttrykk som leses inn (read), evalueres (eval/evaluate) og skrives ut til terminalen (print) og deretter repeterer løkken på nytt (loop).

Du kan åpne en REPL ved å kjøre følgende kommando i terminalen:

```
stack repl
```

Nå kan du skrive Haskell-kode direkte i terminalen og se hva det evaluerer til! Prøv for eksempel å skrive inn `3 + 7`, det burde se slik ut:

```
ghci> 3 + 7
10
```

Dette gjør det veldig enkelt å teste ut eksemplene som blir gitt i [kapittel 2](https://learnyouahaskell.github.io/starting-out.html) i "Learn You a Haskell for Great Good!".

Når du ønsker å gå ut av REPL-en kan du skrive følgende:

```
ghci> :quit
```

eller:

```
ghci> :q
```

Dersom du ønsker å sjekke typesignaturen til noe kan du skrive `:type` eller `:t` etterfulgt av det du ønsker å sjekke i REPL-en.

```
ghci> :t "Hello world!"
"Hello world!" :: String
```

# Opprette og kjøre enkle filer

Haskell-filer har filendelsen ".hs". Disse kan du opprette slik som andre filer, i dette tilfellet ved å opprette en ny fil med en navn og filendelsen ".hs", for eksempel "Testfil.hs".

Ved å kjøre `stack ghci <fil>` så åpner du en REPL der du har tilgang til alle funksjonene i filen og kan kalle de. For eksempel, dersom du har en fil ved navn "Testfil.hs" med følgende filinnhold:

```
doubleMe x = x*2
```

så kan du åpne en REPL slik:

```
stack ghci Testfil.hs
```

og kan nå kalle på funksjonen `doubleMe` i filen slik:

```
ghci> doubleMe 10
20
```

Dersom du gjør endringer i filen din mens du har REPL-en åpen så trenger du ikke lukke REPL-en og åpne den igjen for å få med deg endringene, du kan "reloade" ved å bruke `:r`:

```
ghci> :r
```

# Nytt prosjekt

For å opprette et nytt prosjekt kan du kjøre `stack new nytt-prosjekt`.

```
> stack new nytt-prosjekt
> cd nytt-prosjekt
> stack build
```

På samme måte som i Java så har Haskell en "startfunksjon" som heter `main`. Denne befinner seg i `app/Main.hs` som ser slik ut:

```haskell
module Main (main) where

import Lib

main :: IO ()
main = someFunc
```

Vi kaller filene i et prosjekt for moduler. De må alltid inneholde linjen `module <modulnavn> (<eksport-liste>) where` der `<modulnavn>` er navnet på filen under filendelsen og `(<eksport-liste>)`
er de funksjonene eller typene som vil være tilgjengelige under run-time. Å sette funksjoner eller typer i eksport-listen er det samme som å bruke `public` i Java, altså vil bare det du setter
i `(<eksport-liste>)` være tilgjengelig for andre moduler. I `Main` ser vi at vi importerer modulen `Lib` og kaller på en funksjon derfra som heter `someFunc`, denne befinner seg i `src/Lib.hs` og ser slik ut:

```haskell
module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"
```

Her ser vi at i eksport-listen til `Lib`-modulen så har vi funksjonen `someFunc`, derfor kan `Main`-modulen kalle på denne når den importerer `Lib`. Det `someFunc` gjør er å skrive ut "someFunc" til terminalen,
du kan gjerne bytte ut dette med "Hello world!".

```haskell
module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "Hello world!"
```

Vi kan nå bygge prosjektet vårt ved å kalle på `stack build` i roten av prosjektet og kjøre det med kommandoen `stack run`. Det vil da kalle på `main` i `app/Main.hs`, som kaller på `someFunc` i `src/Lib.hs`.

```
> stack build
> stack run
"Hello world"
```

Du kan også åpne en REPL som laster inn alle modulene i prosjektet ditt og lar deg kalle på dem ved å kjøre `stack ghci` i roten av prosjektet. Det lar deg for eksempel kalle på `someFunc` i terminalen.

```
> stack ghci
ghci> someFunc
"Hello world!"
```

og `main`:

```
ghci> main
"Hello world!"
```

Dersom du ikke ønsker å laste inn alle modulene i prosjektet ditt, men kun én enkelt fil fra prosjektet så kan du skrive `stack ghci <filnavn>`, vi kan for eksempel kun laste inn `src/Lib.hs`
slik:

```
> stack ghci src/Lib.hs
```

Nå har du kun mulighet til å kalle på `someFunc`, men ikke `main`.

Du kan også enkelt installere prosjektet ditt og få en executable-fil. Når du da kjører filen din så vil den ta utgangspunkt i `main`-funksjonen.

```
> stack install nytt-prosjekt
> nytt-prosjekt-exe.exe
"Hello world!"
```
