module Main where

import Data.List (init)

import Math.TheImposter

main = printAllSolutions $ setupProblem preds inits where
  crowd = ["first", "second", "third", "forth", "fifth"]
  alg x = "algebra of " ++ x
  failedAlgs = map ((.== "failed") . alg) crowd
  preds =
    [ map (.== honest) (init crowd) `count` 1
    , "first" .: (failedAlgs `atleast` 1)
    , "second" .: (failedAlgs `atleast` 2)
    , "third" .: (failedAlgs `atleast` 3)
    , "forth" .: (failedAlgs `atleast` 4)
    ]
  inits = do
    "fifth" `tryOne` [honest]
    init crowd `tryAll` [honest, lier]
    map alg crowd `tryAll` ["failed", "passed"]
