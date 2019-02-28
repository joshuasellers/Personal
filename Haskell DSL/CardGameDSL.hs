{-
Name: Josh Sellers
File Description: DSL
-}


-- {-# OPTIONS -Wall -Wno-unused-imports #-}

module CardGameDSL.DSL where

import Data.Either
import Data.List
import Data.Maybe
import System.Random
import Data.Array.ST
import Control.Monad
import Control.Monad.ST
import Data.STRef

import CardGameDSL.Types

{- Deck Functions -}

-- full deck
fullDeck :: [Card]
fullDeck = Card <$> [minBound..] <*> [minBound..]

-- if you don't want a full deck
initialDeck :: [Card] -> [Card]
initialDeck remove = fullDeck \\ remove

-- empty list
initialDiscardPile :: [Card]
initialDiscardPile = []

-- draw number of cards from top of deck
draw :: [Card] -> Integer -> [Card]
draw _ _ = []

-- draw specific cards from deck
drawSpecific :: [Card] -> [Card] -> [Card]
drawSpecific _ _ = []

-- discard number of cards from deck
discard :: [Card] -> Integer -> [Card]
discard _ _ = []

-- discard specific cards from deck
discardSpecific :: [Card] -> [Card] -> [Card]
discardSpecific _ _ = []

-- https://wiki.haskell.org/Random_shuffle
shuffleIO :: [a] -> IO [a]
shuffleIO xs = getStdRandom (shuffle' xs)

{- ScoreCard Functions -}

-- increase score of player
increaseScore :: Player -> Integer -> Player
increaseScore _ = _

-- decrease score of player
decreaseScore :: Player -> Integer -> Player
decreaseScore _ = _

-- get score from a list of cards
scorePlay :: Integer -> [Card] -> Integer
scorePlay _ _ = _

{- Dealer Functions -}

-- create new dealer
newDealer :: Dealer 
newDealer = _

-- replace old dealer with new one
changeDealer :: Dealer -> Dealer
changeDealer _ = _

-- add player to dealer -> TABLE
addPlayer :: Dealer -> Player -> Dealer
addPlayer _ _ = _

-- remove player to dealer -> TABLE
removePlayer :: Dealer -> Player -> Dealer
removePlayer _ _ = _

-- deal to player
deal :: Dealer -> Player -> Dealer
deal _ _ = _

-- discard cards
discardD :: Dealer -> [Card] -> Dealer
discard _ _ = _

{- MAKE TABLE TOO - TODO -} 

{- Player Functions -}

-- create new player
newPlayer :: Player
newPlayer = _

-- have player fold
fold :: Dealer -> Integer -> Player
fold _ _ = _

-- have player draw
draw :: Dealer -> Integer -> Dealer
draw _ _ = _

-- have player discard
discardP :: Dealer -> [Card] -> Dealer
discard _ _ = _

-- make move in game NEED ODDS FUNCTIONALITY
 -- move :: Player -> Move -> Player
-- play final hand NEED ODDS FUNCTIONALITY
 -- play :: Player -> Move -> Player

