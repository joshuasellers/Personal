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
import System.Random
import GHC.Arr


import Types

--BASIC GATES

and_gate :: Bit -> Bit -> Bit
Bit a `and_gate` Bit b 
  | a /= b = Bit 0
  | a == b && a == 1 = Bit 1
  | otherwise = Bit 0

or_gate :: Bit -> Bit -> Bit
Bit a `or_gate` Bit b 
  | a == 1 || b == 1 = Bit 1
  | otherwise = Bit 0

xor_gate :: Bit -> Bit -> Bit
Bit a `xor_gate` Bit b 
  | a == 1 && b == 0 = Bit 1
  | a == 0 && b == 1 = Bit 1
  | otherwise = Bit 0

not_gate :: Bit -> Bit
not_gate Bit a
  | a == 1 = Bit 0
  | otherwise = Bit 1

nand_gate :: Bit -> Bit -> Bit
Bit a `nand_gate` Bit b 
  | a /= b = Bit 1
  | a == b && a == 1 = Bit 0
  | otherwise = Bit 1

nor_gate :: Bit -> Bit -> Bit
Bit a `nor_gate` Bit b 
  | a == 1 || b == 1 = Bit 0
  | otherwise = Bit 1

xnor_gate :: Bit -> Bit -> Bit
Bit a `xnor_gate` Bit b 
  | a == 1 && b == 0 = Bit 0
  | a == 0 && b == 1 = Bit 0
  | otherwise = Bit 1


{-
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
-}