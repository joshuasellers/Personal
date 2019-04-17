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
import Data.Function


import Types

-- MISC FUNCS

powerset :: [a] -> [[a]]
powerset [] = [[]]
powerset (x:xs) = xss ++ map (x:) xss
                 where xss = powerset xs

powersort :: [a] -> [[a]]
powersort xs = sortBy (compare `on` length) (powerset xs)

replaceNth :: Int -> a -> [a] -> [a]
replaceNth _ _ [] = []
replaceNth n newVal (x:xs)
        | n == 0 = newVal:xs
        | otherwise = x:replaceNth (n-1) newVal xs

bitVal :: Bit -> Int
bitVal (Bit b) = b

--BASIC GATES

and_gate :: [Bit] -> Bit
and_gate [] = error "and invalid value"
and_gate bs = foldr (\ (Bit x) b -> if (x == 0) then (Bit 0) else b) (Bit 1) bs

or_gate :: [Bit] -> Bit
or_gate [] = error "or invalid value"
or_gate bs = foldr (\ (Bit x) b -> if (x == 1) then (Bit 1) else b) (Bit 0) bs

xor_gate :: [Bit] -> Bit
xor_gate [] = error "xor invalid value"
xor_gate bs = if ((count :: Integer) == 1) then Bit 1 else Bit 0
    where count = foldr (\ (Bit x) b -> if (x == 1) then (b+1) else b) (0) bs

not_gate :: Bit -> Bit
not_gate (Bit a)
  | a == 1 = Bit 0
  | otherwise = Bit 1

nand_gate :: [Bit] -> Bit
nand_gate bs = not_gate (and_gate bs)

nor_gate :: [Bit] -> Bit
nor_gate bs = not_gate (or_gate bs)

xnor_gate :: [Bit] -> Bit
xnor_gate bs = not_gate (xor_gate bs)

-- DECODER
{-
i1 i0 d0 d1 d2 d3
1  1  1  0  0  0
1  0  0  1  0  0
0  1  0  0  1  0
0  0  0  0  0  1



d0 = i1i0
d1 = i1 (not i0)
d2 = (not i1) i0
d3 = (not i1i0)
-}
n_to_2n_decoder :: Bit -> [Bit] -> [Bit]
n_to_2n_decoder _ [] = error "n_to_2n_decoder invalid input"
n_to_2n_decoder e bs = o
        where o = map (\ x -> if ((bitVal e)==0) then e else x) (decoder_helper bs negs)
              xs = unfoldr (\ b -> if (b == (length bs)) then Nothing else Just (b,b+1)) 0
              negs = powersort xs

decoder_helper :: [Bit] -> [[Int]] -> [Bit]
decoder_helper [] _ = error "decoder_helper invalid input"
decoder_helper _ [] = []
decoder_helper bs (n:negs) = neg bs n : decoder_helper bs negs
    where neg [] _ = error "neg invalid input"
          neg bits [] = and_gate bits
          neg bits (i:ns) = neg (replaceNth i (not_gate (bits!!i)) bits) ns



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