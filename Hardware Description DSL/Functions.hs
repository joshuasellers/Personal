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

-- MISC FUNCS

powerset :: [a] -> [[a]]
powerset [] = [[]]
powerset (x:xs) = xss ++ map (x:) xss
                 where xss = powerset xs

--BASIC GATES

and_gate :: [Bit] -> Bit
and_gate [] = error "invalid value"
and_gate bs = foldr (\ (Bit x) b -> if (x == 0) then (Bit 0) else b) (Bit 1) bs

or_gate :: [Bit] -> Bit
or_gate [] = error "invalid value"
or_gate bs = foldr (\ (Bit x) b -> if (x == 1) then (Bit 1) else b) (Bit 0) bs

xor_gate :: [Bit] -> Bit
Bit a `xor_gate` Bit b 
  | a == 1 && b == 0 = Bit 1
  | a == 0 && b == 1 = Bit 1
  | otherwise = Bit 0

not_gate :: Bit -> Bit
not_gate (Bit a)
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

-- DECODER
{-
i1 i0 d3 d2 d1 d0
0  0  0  0  0  1
0  1  0  0  1  0
1  0  0  1  0  0
1  1  1  0  0  0

d3 = i1i0
d2 = i1 (not i0)
d1 = (not i1) i0
d0 = (not i1i0)
-}
n_to_2n_decoder :: [Bit] -> [Bit]
n_to_2n_decoder [] = []
n_to_2n_decoder bs = []



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