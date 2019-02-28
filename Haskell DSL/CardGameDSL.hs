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

-- shuffel there looks like a decent shuffle io for haskell online

{- ScoreCard Functions -}


{- Dealer Functions -}


{- Player Functions -}
