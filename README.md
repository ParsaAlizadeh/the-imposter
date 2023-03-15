# TheImposter

Easy way to write bunch of predicates and try all possible solutions

## Example

[example/problem06.hs]():
```haskell
module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["A", "B", "C"]                   -- all the people involved in the problem
  preds =                                   -- list of predicates
    [ "A" .: ("B" .== honest)               -- A says B is honest
    , "B" .: ("guilty" .!= "A")             -- B says A is not guilty
    , "C" .: ("guilty" .== "A")             -- C says A is guilty
    , map (.== honest) crowd `count` 1      -- Exactly one of A, B, and C is honest
    ]
  inits = do
    crowd `tryAll` [honest, lier]           -- People can be honests or liers
    "guilty" `tryOne` crowd                 -- One of the people is guilty
```

## Run Examples

```console
$ cabal repl
[1 of 1] Compiling Math.TheImposter ( src/Math/TheImposter.hs, interpreted )
Ok, one module loaded.

ghci> :load example/problem06.hs
[1 of 2] Compiling Math.TheImposter ( src/Math/TheImposter.hs, interpreted )
[2 of 2] Compiling Main             ( example/problem06.hs, interpreted )
Ok, two modules loaded.

ghci> main
========
guilty is A
C is honest
B is lier
A is lier

Number of solutions: 1
```
