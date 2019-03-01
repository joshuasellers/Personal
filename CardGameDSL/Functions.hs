{-
Name: Josh Sellers
File Description: Functions
-}


{-# OPTIONS -Wall -Wno-unused-imports #-}

module Functions where

import Data.Either
import Data.List
import Data.Maybe
import Data.Array.ST
import Control.Monad
import Control.Monad.ST
import Data.STRef
import Control.Monad.Random
import System.Random
import GHC.Arr


import Types

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
draw :: [Card] -> Int -> ([Card],[Card])
draw deck 0 = ([],deck)
draw [] _ = ([],[])
draw deck n = ((take n deck),(drop n deck))

-- find card in deck
getCard :: [Card] -> Card -> [Card]
getCard [] _ = []
getCard (d:deck) c 
        | d == c    = [d]
        | otherwise = getCard deck c

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
              getSpecific dck (c:cds) = getCard dck c ++ getSpecific (dck \\ [c]) cds
      

-- discard number of cards from deck
discard :: [Card] -> Int -> [Card]
discard [] _ = []
discard deck 0 = deck
discard deck n = drop n deck 

-- discard specific cards from deck
discardSpecific :: [Card] -> [Card] -> [Card]
discardSpecific deck dscrd = deck \\ dscrd

-- https://wiki.haskell.org/Random_shuffle  I don't totally get this TODO TODO TODO
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
changeScore :: Player -> Integer -> Player
changeScore player n = player {_score = x}
  where x = (_score player) + n

{- Dealer Functions -}

-- add player to dealer -> TABLE
addPlayer :: Dealer -> Player -> Dealer
addPlayer dealer player = if (elem player (_players dealer))
                              then dealer {_players = x}
                              else dealer
                               where x = player : (_players dealer)

-- remove player to dealer -> TABLE
removePlayer :: Dealer -> Player -> Dealer
removePlayer dealer player = if (elem player (_players dealer))
                                then dealer {_players = x}
                                else dealer
                                  where x = (_players dealer) \\ [player]

-- deal to player
deal :: Dealer -> Player -> Int -> (Dealer, Player)
deal dealer player 0 = (dealer, player)
deal dealer player n = ((dealer {_deck = y}),(player {_hand = z}))
            where x = fst (draw (_deck dealer) n)
                  y = snd (draw (_deck dealer) n)
                  z = (_hand player) ++ x

-- discard cards
discardDealer :: Dealer -> [Card] -> Dealer
discardDealer dealer [] = dealer
discardDealer dealer cards = dealer {_deck =  (fst t), _discard = (snd t)}
   where t = drawSpecific cards cards

{- Table Functions -}

addToTable :: Table -> Card -> Table
addToTable table c = if (elem c (_inPlay table))
                        then table
                        else table {_inPlay = x}
                          where x = c : (_inPlay table)


{- Player Functions -}

-- have player fold
fold :: Dealer -> Player -> (Dealer, Player)
fold dealer player = ((dealer {_discard = x}),(player {_hand = []}))
              where x = (_discard dealer) ++ (_hand player)

-- have player draw
drawPlayer :: Dealer -> Player -> Int -> (Dealer, Player)
drawPlayer dealer player 0 = (dealer, player)
drawPlayer dealer player n = ((dealer {_deck = (snd x)}),(player {_hand = y}))
              where x = draw (_deck dealer) n
                    y = (fst x) ++ (_hand player)

-- have player discard
discardPlayer :: Dealer -> Player -> [Card] -> (Dealer, Player)
discardPlayer dealer player [] = (dealer, player)
discardPlayer dealer player cards = ((dealer {_discard = x}), (player {_hand = y}))
              where x = (_discard dealer) ++ (fst (drawSpecific (_hand player) cards))
                    y = (_hand player) \\ cards
