module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["A", "B", "C"]
  preds =
    [ "B" .: ("A" .: ("A" .== honest))
    , "C" .: ("A" .== lier)
    ]
  inits =
    crowd `tryAll` [honest, lier]
