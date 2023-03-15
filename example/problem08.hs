module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["A", "B", "C"]
  preds =
    [ "A" .: ("A" .== honest)
    , "B" .: ("B" .== lier)
    , "C" .: ("C" .== "spy")
    , map (.== honest) crowd `count` 1
    , map (.== lier) crowd `count` 1
    , map (.== "spy") crowd `count` 1
    ]
  inits =
    crowd `tryAll` [honest, lier, "spy"]
