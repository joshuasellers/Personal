{-
Name: Josh Sellers
File Description: Functions
-}

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS -Wall -Wno-unused-imports #-}

module Functions where

import Data.Either
import Data.List
import Data.Maybe
import Data.Array.ST
import Control.Monad
import Control.Monad.ST
import Data.STRef
--import Control.Monad.Random
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

-- go back to how they were
revertDrawDiscard :: Dealer -> Dealer
revertDrawDiscard dealer = dealer {_deck = d, _discard = []}
          where d = (_deck dealer) ++ (_discard dealer)

{- Draw Functions -}

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
drawSpecificCards :: [Card] -> [Card] -> ([Card],[Card])
drawSpecificCards deck [] = ([], deck)
drawSpecificCards [] _ = ([], [])
drawSpecificCards deck cards = ((getSpecific deck cards), (deck \\ cards))
        where getSpecific [] _ = []
              getSpecific _ [] = []
              getSpecific dck (c:cds) = getCard dck c ++ getSpecific (dck \\ [c]) cds

-- drawing class
-- allows for polymorphism 
class Drawing c where
   draw :: Dealer -> c -> ([Card], Dealer)
instance Drawing Int where
    draw dealer 0 = ([],dealer)
    draw dealer n = ((take n deck), d)
        where deck = _deck dealer
              d = dealer {_deck = (drop n deck)}
instance Drawing Card where
    draw dealer c = (card, d)
        where out = removeCard (_deck dealer) c 
              d = dealer {_deck = (snd out)}
              card = fst out
instance Drawing [Card] where
    draw dealer cards = (cs, d)
        where out = drawSpecificCards (_deck dealer) cards
              cs = fst out
              d = dealer {_deck = (snd out)}

{- Discard Functions -}      

--polymorphic class for discarding
class Discarding c where
   discardP :: Dealer -> Player -> c -> (Dealer, Player)
   discardD :: Dealer -> c -> Dealer
   discardT :: Dealer -> Table -> c -> (Dealer, Table)
instance Discarding Int where
    discardP dealer player 0 = (dealer, player)
    discardP dealer player n = (d,p)
             where hand = _hand player
                   d = dealer {_discard = ((take n hand) ++ (_discard dealer))}
                   p = player {_hand = (drop n hand) }
    discardD dealer 0 = dealer
    discardD dealer n = d
            where h = _handD dealer
                  d = dealer {_discard = ((take n h) ++ (_discard dealer)), _handD = (drop n h) }
    discardT dealer table 0 = (dealer, table)
    discardT dealer table n = (d,t)
            where pile = _inPlay table
                  d = dealer {_discard = ((take n pile) ++ (_discard dealer))}
                  t = table {_inPlay = (drop n pile)}
instance Discarding Card where
    discardP dealer player card = (d, p)
            where hand = _hand player
                  d = dealer {_discard = (getCard hand card) ++ (_discard dealer)} 
                  p = player {_hand = (snd (removeCard hand card))}
    discardD dealer card = d
            where hand = _handD dealer
                  d = dealer {_discard = (getCard hand card) ++ (_discard dealer), _handD = (snd (removeCard hand card))} 
    discardT dealer table card = (d, t)
            where hand = _inPlay table
                  d = dealer {_discard = (getCard hand card) ++ (_discard dealer)} 
                  t = table {_inPlay = (snd (removeCard hand card))}
instance Discarding [Card] where
    discardP dealer player [] = (dealer, player)
    discardP dealer player cards = (d,p)
            where hand = _hand player
                  (c, h) = drawSpecificCards hand cards
                  p = player {_hand = h}
                  d = dealer {_discard = c ++ (_discard dealer)}
    discardD dealer [] = dealer
    discardD dealer cards = d
            where hand = _handD dealer
                  (c, h) = drawSpecificCards hand cards
                  d = dealer {_discard = c ++ (_discard dealer), _handD = h}
    discardT dealer table [] = (dealer, table)
    discardT dealer table cards = (d,t)
            where hand = _inPlay table
                  (c, h) = drawSpecificCards hand cards
                  t = table {_inPlay = h}
                  d = dealer {_discard = c ++ (_discard dealer)}

{- Fold Functions -}

class Folding p where
    fold :: Dealer -> p -> (Dealer, p)
instance Folding Dealer where
    fold d1 _ = (d1 {_discard = d ,_handD = []},d1 {_discard = d ,_handD = []})
            where dis = _discard d1
                  hand =_handD d1
                  d = hand ++ dis
instance Folding Player where
    fold dealer player = (d,p)
            where dis = _discard dealer
                  hand =_hand player
                  d = dealer {_discard = hand ++ dis}
                  p = player {_hand = []}
instance Folding Table where
    fold dealer table = (d,t) 
            where dis = _discard dealer
                  hand =_inPlay table
                  d = dealer {_discard = hand ++ dis}
                  t = table {_inPlay = []}

clearTable :: Dealer -> Table -> (Dealer, Table)
clearTable dealer table = fold dealer table

clearDealer :: Dealer -> Dealer -> Dealer
clearDealer d1 d2 = if (d1 == d2)
                               then fst $ fold d1 d2
                               else error "Sorry, must equal"

{- Deal Functions -}



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


{- Table Functions -}

addToTable :: Table -> Card -> Table
addToTable table c = if (elem c (_inPlay table))
                        then table
                        else table {_inPlay = x}
                          where x = c : (_inPlay table)

{- POTENTIAL FUNCTIONS -}

-- https://wiki.haskell.org/Random_shuffle  I don't totally get this TODO TODO TODO
--shuffle :: RandomGen g => [a] -> Rand g [a]
--shuffle xs = do
--    let l = length xs
--    rands <- forM [0..(l-2)] $ \i -> getRandomR (i, l-1)
--    let ar = runSTArray $ do
--        ar <- thawSTArray $ listArray (0, l-1) xs
--        forM_ (zip [0..] rands) $ \(i, j) -> do
--            vi <- readSTArray ar i
--            vj <- readSTArray ar j
--            writeSTArray ar j vi
--            writeSTArray ar i vj
--        return ar
--    return (elems ar)
