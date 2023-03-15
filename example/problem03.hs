module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["alan", "ben", "chris", "dave", "emma"]
  eater = "eater"
  preds =
    [ (eater .!= "emma") .^ (eater .== "ben")
    , (eater .!= "chris") .^ (eater .!= "emma")
    , (eater .== "emma") .^ (eater .!= "alan")
    , (eater .== "chris") .^ (eater .== "ben")
    , (eater .== "dave") .^ (eater .!= "alan")
    ]
  inits = eater `tryOne` crowd
