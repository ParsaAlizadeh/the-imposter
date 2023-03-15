module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["brian", "chris", "leroy", "mike"]
  preds =
    [ "brian" .: (("brian" .== honest) .<=> ("mike" .== lier))
    , "chris" .: ("leroy" .== lier)
    , "leroy" .: ("chris" .== lier)
    , "mike"  .: (map (.== honest) crowd `atleast` 2)
    ]
  inits =
    crowd `tryAll` [honest, lier]
