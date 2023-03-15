module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["A", "B", "C"]
  preds =
    [ ("A" .== honest) .=> (("B" .== honest) .& ("C" .== honest))
    , ("B" .== honest) .=> (("A" .== honest) .| ("C" .== honest))
    , ("C" .== honest) .=> (("A" .== honest) .& ("B" .== lier))
    ]
  inits =
    crowd `tryAll` [honest, lier]
