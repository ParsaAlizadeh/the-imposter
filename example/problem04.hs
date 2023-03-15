module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["white", "brown", "gray", "blue", "black"]
  preds = zipWith go crowd [0..4] where
    go u i = u .: (map (.== honest) crowd `count` i)
  inits =
    crowd `tryAll` [honest, lier]
