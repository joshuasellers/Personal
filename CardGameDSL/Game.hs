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

{- Helper Functions For Rules and Scoring -}

toDealer :: Dealer -> Player -> (Dealer, Dealer)
toDealer currdealer player = (newD, oldD)
    where newD = Dealer {_nameD = (_name player), _turnD = (_turn player),
                    _scoreD = (_score player), _storedHandsD = (_storedHands player), _deck = (_deck currdealer),
                    _discard = (_discard currdealer), _players = (_players currdealer) \\ [player],
                    _handD = (_hand player), _playedD = (_played player)}
          oldD = currdealer {_players = (_players newD)}

toPlayer :: Dealer -> Player
toPlayer dealer = Player {_hand = (_handD dealer), _storedHands = (_storedHandsD dealer),
        _turn = (_turnD dealer), _score = (_scoreD dealer), _name = (_nameD dealer), 
        _played = (_playedD dealer)}

-- error check for if a list of cards has dupes
hasDupes :: [Card] -> Bool
hasDupes [] = False
hasDupes (c:cards) =  if (elem c cards) then True else hasDupes cards 

-- all possible pairs in a hand
pairs :: [Card] -> [[Card]]
pairs [] = []
pairs (x:xs) = foldr (\ c b -> if (_rank c) == (_rank x) then [[x,c]] ++ b else b) [] xs ++ (pairs xs)

-- make Ord custumizable for rank and suit  
specifyRankOrd :: [Rank] -> [Integer] -> [(Rank, Integer)]
specifyRankOrd [] _ = []
specifyRankOrd _ [] = []
specifyRankOrd (r:ranks) (o:ords) = if ((length ranks) == (length ords))
                                      then (r,o) : specifyRankOrd ranks ords
                                      else error "Lists need to be the same length"

specifySuitOrd :: [Suit] -> [Integer] -> [(Suit, Integer)]
specifySuitOrd [] _ = []
specifySuitOrd _ [] = []
specifySuitOrd (s:suits) (o:ords) = if ((length suits) == (length ords))
                                      then (s,o) : specifySuitOrd suits ords
                                      else error "Lists need to be the same length"

-- https://stackoverflow.com/questions/35118659/haskell-permutations-with-the-length-of-the-output-list
possibleHands :: Int -> [Card] -> [[Card]]
possibleHands n deck = concatMap permutations $ possibleHands' deck [] where
  possibleHands' []     r = if length r == n then [r] else []
  possibleHands' (x:xs) r | length r == n = [r]
                          | otherwise     = possibleHands' xs (x:r) 
                                            ++ possibleHands' xs r
