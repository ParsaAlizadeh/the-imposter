module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  person i = "person " ++ show i
  crowd = map person [1..10]
  preds = map go crowd where
    go u = u .: (map (.== honest) (filter (/= u) crowd) `count` 3)
  inits =
    crowd `tryAll` [honest, lier]
