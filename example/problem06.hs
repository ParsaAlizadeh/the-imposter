module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["A", "B", "C"]
  preds =
    [ "A" .: ("B" .== honest)
    , "B" .: ("guilty" .!= "A")
    , "C" .: ("guilty" .== "A")
    , map (.== honest) crowd `count` 1
    ]
  inits = do
    crowd `tryAll` [honest, lier]
    "guilty" `tryOne` crowd
