{-
Name: Josh Sellers
File Description: Types
-}

-- {-# OPTIONS -Wall -Wno-unused-imports #-}

module CardGameDSL.Types where

-- CARD

-- TODO make Ord custumizable
-- https://stackoverflow.com/questions/5947340/overriding-in-haskell
-- maybe let user do it
data Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten
          | Jack | Queen | King | Ace
  deriving (Read, Eq, Ord, Bounded, Enum)
   instance Show Rank where
    show x = case x of
     Two   -> "2"
     Three -> "3"
     Four  -> "4"
     Five  -> "5"
     Six   -> "6"
     Seven -> "7"
     Eight -> "8"
     Nine  -> "9"
     Ten   -> "T"
     Jack  -> "J"
     Queen -> "Q"
     King  -> "K"
     Ace   -> "A"

data Suit = Clubs | Diamonds | Hearts | Spades
  deriving (Eq, Ord, Bounded, Enum)
   instance Show Suit where
    show x = case x of
     Clubs    -> " ♧"
     Diamonds -> " ♢"
     Hearts   -> " ♡"
     Spades   -> " ♤"

data Card = Card {rank :: Rank, suit :: Suit} 
 deriving (Eq)
  instance Ord Card where
    (Card r1 _) `compare` (Card r2 _) = r1 `compare` r2
  instance Show Card where
    show (Card r s) = show r ++ show s
  instance Applicative Card where
      pure r s = Card {rank :: r, suit :: s}
      fc <*> cs = fmap fc cs

-- DECK
-- I actuall don't think deck should be a type, make it a list that can be defined by the user

-- data Deck = [Card]

-- PLAYER

data Player = Player {_hand :: [Card], _turn :: Int} deriving (Eq, Show)

-- DEALER

data Dealer = Dealer {_deck :: [Card], _discard :: [Card]}

-- SCORECARD
-- This one might also be defined by the user

-- data ScoreCard = [(Int, Int)]



