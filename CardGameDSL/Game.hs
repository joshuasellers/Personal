{-# OPTIONS -Wall -Wno-unused-imports #-}

module Game where

import Data.Either
import Data.List
import Data.Maybe
import Data.Array.ST
import Control.Monad
import Control.Monad.ST
import Data.STRef
import System.Random

import Types
import Functions


-- make Ord custumizable for rank and suit  
specifyRankOrd :: [Rank] -> [Integer] -> [(Rank, Integer)]
specifyRankOrd [] _ = []
specifyRankOrd _ [] = []
specifyRankOrd (r:ranks) (o:ords) = if ((length ranks) == (length ords))
                                      then (r,o) : specifyRankOrd ranks ords
                                      else []

specifySuitOrd :: [Suit] -> [Integer] -> [(Suit, Integer)]
specifySuitOrd [] _ = []
specifySuitOrd _ [] = []
specifySuitOrd (s:suits) (o:ords) = if ((length suits) == (length ords))
                                      then (s,o) : specifySuitOrd suits ords
                                      else []

-- https://stackoverflow.com/questions/35118659/haskell-permutations-with-the-length-of-the-output-list
possibleHands :: Int -> [Card] -> [[Card]]
possibleHands n deck = concatMap permutations $ possibleHands' deck [] where
  possibleHands' []     r = if length r == n then [r] else []
  possibleHands' (x:xs) r | length r == n = [r]
                          | otherwise     = possibleHands' xs (x:r) 
                                            ++ possibleHands' xs r

-- can i make a function that lets user specif scoring and rank, or is that something the would make                           

-- make move in game NEED ODDS FUNCTIONALITY
 -- move :: Player -> Move -> Player
-- play final hand NEED ODDS FUNCTIONALITY
 -- play :: Player -> Move -> Player

