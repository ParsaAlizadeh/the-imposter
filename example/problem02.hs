module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  statements = ["A", "B", "C", "D"]
  preds =
    [ "A" .: ("D" .== honest)
    , "B" .: ("A" .== lier)
    , "C" .: ("B" .== lier)
    , "D" .: ("C" .== honest)
    , map (.== lier) statements `count` 1
    ]
  inits = statements `tryAll` [honest, lier]
