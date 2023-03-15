module Math.TheImposter (
  honest,
  lier,
  tryOne,
  tryAll,
  setupProblem,
  showAssignment,
  (.==),
  (.!=),
  (.:),
  (.&),
  (.|),
  (.^),
  (.=>),
  (.<=>),
  printOneSolution,
  printAllSolutions
) where

import Control.Monad
import Control.Monad.State
import Data.List
import Data.Maybe

type Var = String
type Value = String

type Assignment = [(Var, Value)]

data Predicate = Is Var Value
               | And Predicate Predicate
               | Or Predicate Predicate
               | Not Predicate
               | Boolean Bool
  deriving Show

isNot :: Var -> Value -> Predicate
var `isNot` val = Not (var `Is` val)

implies :: Predicate -> Predicate -> Predicate
p `implies` q = Not (p `And` Not q)

sameAs :: Predicate -> Predicate -> Predicate
p `sameAs` q = (p `And` q) `Or` (Not p `And` Not q)

orElse :: Predicate -> Predicate -> Predicate
p `orElse` q = Not (p `sameAs` q)

honest = "honest"
lier = "lier"

said :: Var -> Predicate -> Predicate
u `said` p = And
  ((u `Is` honest) `implies` p)
  ((u `Is` lier) `implies` Not p)

maybeAnd :: Maybe Bool -> Maybe Bool -> Maybe Bool
maybeAnd (Just False) _ = Just False
maybeAnd _ (Just False) = Just False
maybeAnd x y = liftM2 (&&) x y

maybeOr :: Maybe Bool -> Maybe Bool -> Maybe Bool
maybeOr (Just True) _ = Just True
maybeOr _ (Just True) = Just True
maybeOr x y = liftM2 (||) x y

check :: Assignment -> Predicate -> Maybe Bool
check vs (u `Is` v) = do
  x <- lookup u vs
  return (x == v)
check vs (p `And` q)  = maybeAnd (check vs p) (check vs q)
check vs (p `Or` q)   = maybeOr (check vs p) (check vs q)
check vs (Not p)      = not <$> check vs p
check vs (Boolean b)  = Just b

data ProblemState = ProblemState
  { assignment :: Assignment
  , predicates :: [Predicate]
  }

type NDS a = StateT ProblemState [] a

isConsistent :: Bool -> NDS Bool
isConsistent partial = do
  ps <- gets predicates
  vs <- gets assignment
  let results = map (check vs) ps
  return $ all (fromMaybe partial) results

getVar :: Var -> NDS (Maybe Value)
getVar u = do
  vs <- gets assignment
  return $ lookup u vs

setVar :: Var -> Value -> NDS ()
setVar u val = do
  vs <- gets assignment
  let vs' = filter ((/= u) . fst) vs
  st <- get
  put $ st { assignment = (u,val) : vs' }
  isConsistent True >>= guard

getResult :: NDS Assignment
getResult = do
  isConsistent False >>= guard
  gets assignment

tryOne :: Var -> [Value] -> NDS ()
u `tryOne` vs = msum (map (setVar u) vs)

tryAll :: [Var] -> [Value] -> NDS ()
us `tryAll` vs = mapM_ (`tryOne` vs) us

setupProblem :: [Predicate] -> NDS a -> [Assignment]
setupProblem preds ma = evalStateT (ma >> getResult) (ProblemState [] preds)

showAssignment :: Assignment -> String
showAssignment = unlines . map go where
    go (p, s) = p ++ " is " ++ s

(.==) = Is
(.!=) = isNot
(.:) = said
(.&) = And
(.|) = Or
(.^) = orElse
(.=>) = implies
(.<=>) = sameAs

printOneSolution :: [Assignment] -> IO ()
printOneSolution [] = putStrLn "No solution to the problem"
printOneSolution (x:_) = do
  putStrLn . showAssignment $ x

printAllSolutions :: [Assignment] -> IO ()
printAllSolutions xs = do
  forM_ xs $ \x -> do
    putStrLn "========"
    putStrLn . showAssignment $ x
  putStr "Number of solutions: "
  print . length $ xs
