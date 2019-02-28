{-
Name: Josh Sellers
File Description: DSL
-}


-- {-# OPTIONS -Wall -Wno-unused-imports #-}

module CardGameDSL.DSL where

import Data.Either
import Data.List
import Data.Maybe

import CardGameDSL.Types

{- Deck Functions -}

fullDeck :: [Card]
fullDeck = Card <$> [minBound..] <*> [minBound..]

initialDiscardPile :: [Card]
initialDiscardPile = []

draw :: [Card] -> Integer -> [Card]
draw _ _ = []

discard :: [Card] -> Integer -> [Card]
discard _ _ = []

-- shuffel: there looks like a decent shuffle io for haskell online

{- ScoreCard Functions -}

increaseScore :: Player -> Player
increaseScore _ = _

decreaseScore :: Player -> Player
decreaseScore _ = _

scorePlay :: Integer -> [Card] -> Integer
scorePlay _ _ = _

{- Dealer Functions -}

newDealer :: Dealer 
newDealer = _

changeDealer :: Dealer -> Dealer
changeDealer _ = _

addPlayer :: Dealer -> Player -> Dealer
addPlayer _ _ = _

removePlayer :: Dealer -> Integer -> Dealer
removePlayer _ _ = _

deal :: Dealer -> Integer -> Dealer
deal _ _ = _

discardD :: Dealer -> [Card] -> Dealer
discard _ _ = _

{- Player Functions -}

newPlayer :: Player
newPlayer = _

fold :: Dealer -> Integer -> Player
fold _ _ = _

draw :: Dealer -> Integer -> Dealer
draw _ _ = _

discardP :: Dealer -> [Card] -> Dealer
discard _ _ = _


