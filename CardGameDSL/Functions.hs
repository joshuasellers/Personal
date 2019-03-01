{-
Name: Josh Sellers
File Description: Functions
-}


{-# OPTIONS -Wall -Wno-unused-imports #-}

module CardGameDSL.Functions where

import Data.Either
import Data.List
import Data.Maybe
import Data.Array.ST
import Control.Monad
import Control.Monad.ST
import Data.STRef
import System.Random

import CardGameDSL.Types

{- Deck Functions -}

-- full deck
fullDeck :: [Card]
fullDeck = Card <$> [minBound..] <*> [minBound..]

-- if you don't want a full deck
partialDeck :: [Card] -> [Card]
partialDeck remove = fullDeck \\ remove

-- empty list
initialDiscardPile :: [Card]
initialDiscardPile = []

-- draw number of cards from top of deck -> return cards and new deck
draw :: [Card] -> Integer -> ([Card],[Card])
draw deck 0 = ([],deck)
draw [] _ = ([],[])
draw deck n = ((take n deck),(drop n deck))

-- find card in deck
getCard :: [Card] -> Card -> [Card]
getCard [] _ = []
getCard (d:deck) c 
        | d == c    = [d]
        | otherwise = removeCard deck c

-- remove specific card from deck -> return card and new deck
removeCard :: [Card] -> Card -> ([Card],[Card])
removeCard [] _ = ([], [])
removeCard deck c = ((getCard deck c),(deck \\ [c])) 

-- draw specific cards from deck -> return cards and new deck
drawSpecific :: [Card] -> [Card] -> ([Card],[Card])
drawSpecific deck [] = ([], deck)
drawSpecific [] _ = ([], [])
drawSpecific deck cards = ((getSpecific deck cards), (deck \\ cards))
        where getSpecific [] _ = []
              getSpecific _ [] = []
              getSpecific deck (c:cards) = getCard deck c ++ getSpecific (deck \\ [c]) cards
      

-- discard number of cards from deck
discard :: [Card] -> Integer -> [Card]
discard [] _ = []
discard deck 0 = deck
discard (d:deck) n = discard deck (n-1)

-- discard specific cards from deck
discardSpecific :: [Card] -> [Card] -> [Card]
discardSpecific deck dscrd = deck \\ dscrd

-- https://wiki.haskell.org/Random_shuffle  I don't totally get this
shuffle :: RandomGen g => [a] -> Rand g [a]
shuffle xs = do
    let l = length xs
    rands <- forM [0..(l-2)] $ \i -> getRandomR (i, l-1)
    let ar = runSTArray $ do
        ar <- thawSTArray $ listArray (0, l-1) xs
        forM_ (zip [0..] rands) $ \(i, j) -> do
            vi <- readSTArray ar i
            vj <- readSTArray ar j
            writeSTArray ar j vi
            writeSTArray ar i vj
        return ar
    return (elems ar)

{- ScoreCard Functions -}

-- increase score of player
addToScore :: Player -> Integer -> Player
addToScore player n = setL _score ((getL _score player)+n) player

-- get score from a list of cards. TODO
-- scorePlay :: Integer -> [Card] -> Integer
-- scorePlay _ _ = _

{- Dealer Functions -}

-- add player to dealer -> TABLE
addPlayer :: Dealer -> Player -> Dealer
addPlayer dealer player = 

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
newPlayer :: Integer -> Player
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
