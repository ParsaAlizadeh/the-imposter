module Main where

import Math.TheImposter

main = printAllSolutions $ setupProblem [pred] inits where
  pred =
    ["car" .== "box1", "car" .!= "box2", "car" .!= "box1"] `count` 1
  inits =
    "car" `tryOne` ["box1", "box2", "box3"]
