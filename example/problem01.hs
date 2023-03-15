module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  preds =
    [ "Leila" .: ("Maryam" .== lier)
    , "Maryam" .: ("Golnoosh" .== lier)
    , "Golnoosh" .: (("Maryam" .== lier) .& ("Leila" .== lier))
    , "Ali" .: ("Ali" .== honest)
    ]
  inits =
    ["Leila", "Maryam", "Golnoosh", "Ali"] `tryAll` [honest, lier]
