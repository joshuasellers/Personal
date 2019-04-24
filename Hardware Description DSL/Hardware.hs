{-
Name: Josh Sellers
File Description: Functions that represent low-level hardware.  Intended to be used
as a learning tool for students or anyone that wants to understand hardware better.
-}

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS -Wall -Wno-unused-imports #-}

module Hardware where

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


import Data

-- MISC FUNCS

splitEvery :: Int -> [a] -> [[a]]
splitEvery _ [] = []
splitEvery n list = first : (splitEvery n rest)
  where
    (first,rest) = splitAt n list

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
e i1 i0 d0 d1 d2 d3
1  1  1  1  0  0  0
1  1  0  0  1  0  0
1  0  1  0  0  1  0
1  0  0  0  0  0  1
0  x  x  x  x  x  x  


d0 = i1i0
d1 = i1 (not i0)
d2 = (not i1) i0
d3 = (not i1i0)
e = encoder option
-}
n_to_2n_decoder :: [Bit] -> [Bit]
n_to_2n_decoder [] = error "n_to_2n_decoder invalid input"
n_to_2n_decoder bs = o
        where o = decoder_helper bs negs
              xs = unfoldr (\ b -> if (b == (length bs)) then Nothing else Just (b,b+1)) 0
              negs = powersort xs

n_to_2n_decoder_enable :: Bit -> [Bit] -> [Bit]
n_to_2n_decoder_enable _ [] = error "n_to_2n_decoder invalid input"
n_to_2n_decoder_enable e bs = o
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

-- MULTIPLEXER

{-
See image for description: http://www.dcs.gla.ac.uk/~simon/teaching/CS1Q-students/systems/online/sec7.html
-}

multiplexer :: [Bit] -> [Bit] -> Bit
multiplexer [] _ = error "multiplexer invalid input"
multiplexer _ [] = error "multiplexer invalid input"
multiplexer cs is = if ((2^(length cs)) /= (length is)) 
                      then error "multiplexer invalid input"
                      else or_gate o
                        where o = combo is d
                              d = (n_to_2n_decoder cs)
                              combo [] [] = []
                              combo [] _ = error "invalid combo input"
                              combo _ [] = error "invalid combo input"
                              combo (y:ys) (x:xs) = (and_gate [y, x]) : (combo ys xs)

-- PROGRAMABLE LOGIC DEVICE (PLD)
{-
This is a tough one.  The only good way i see to set the programmable output
is to use (!!) and have the user specify which bits to pick.  
Index at 0. Factor in the not after each bit in the array

EX.
pld [Bit 0, Bit 1, Bit 0]  [[[0,1],[0,2],[1,3]],[[1,3],[0,3],[2,3]]]

Helpful link:
https://techdifferences.com/difference-between-pla-and-pal.html

I decided to not do PAL too since its has the same functionality of PLA,
but is more rigid. With hardware, that is a useful distinction, but shouldn't matter here.

I'm also doing ROM separately, since it has a decoder inside (unlike the other two).
-}
pld :: [Bit] -> [[[Int]]] -> [Bit]
pld [] _ = error "pla invalid input"
pld _ [] = []
pld bs (f:fs) = (pld_helper o f) : (pld bs fs)
  where o = foldr (\ x b -> x:(not_gate x):b) [] bs

pld_helper :: [Bit] -> [[Int]] -> Bit
pld_helper [] _ = error "pla_helper invalid input"
pld_helper _ [] = error "pla_helper invalid input"
pld_helper bs fs = or_gate ands
  where ands = foldr (\ x b -> (and_gate (sub x)):b) [] fs
        sub [] = error "sub invalid input"
        sub ns = foldr (\ x b -> (bs!!x):b) [] ns

-- READ ONLY MEMORY (ROM)
{-
https://www.geeksforgeeks.org/read-memory-rom-classification-programming/

Same issue as before with (!!).

ROM is basicall a programmable device that has a decoder and a bunch or OR-gates for the output.
A ROM is programmed once, but I don't see a good way to gaurantee that in a functional language
like Haskell, so it is up to the coder to understand that nuance.
-}

rom :: [Bit] -> [[Int]] -> [Bit]
rom [] _ = error "rom invalid input"
rom _ [] = [error "rom invalid input"]
rom bs is = foldr (\x b -> (or_gate (sub x)) : b) [] is
  where d = n_to_2n_decoder bs
        sub [] = error "sub invalid input"
        sub ns = foldr (\ x b -> (d!!x):b) [] ns

-- LATCHES
{-
https://en.wikibooks.org/wiki/Digital_Circuits/Latches
https://www.allaboutcircuits.com/textbook/digital/chpt-10/s-r-latch/
https://electronics.stackexchange.com/questions/61530/how-to-understand-the-sr-latch

this is asynchronous, so the user will have to store the output 
and propogate it back through the next time the latch is used.

It is reccomended that the user remeber that q and nq should be opposite for
the initial formation of the latch.  This code is not set up for race conditions.
-}

-- set/reset latch

sr_latch :: (Bit, Bit) -> Bit -> Bit -> (Bit, Bit)
sr_latch (q, nq) s r = if (((bitVal s) == 1) && ((bitVal r) == 1))
                        then error "invalid sr_latch input"
                        else ((nor_gate [nq,r]),(nor_gate [q,s]))

-- added enable (keeps output latched to previous data)

gated_sr_latch :: (Bit, Bit) -> Bit -> Bit -> Bit -> (Bit, Bit)
gated_sr_latch (q, nq) e s r = if (bitVal e) == 0 
                                 then (q,nq)
                                 else (if (((bitVal s) == 1) && ((bitVal r) == 1))
                                        then error "invalid sr_latch input"
                                        else ((nor_gate [nq,r]),(nor_gate [q,s])))

-- data latch (transparent)

d_latch :: (Bit, Bit) -> Bit -> Bit -> (Bit, Bit)
d_latch (q, nq) e d =  if (bitVal e) == 0 
                        then (q,nq) 
                        else ((nor_gate [nq,end]),(nor_gate [q,ed]))
                            where ed = and_gate [e,d]
                                  end = and_gate[e,(not_gate d)]

-- FLIP-FLOPS
{-
Since I am not coding in time-related events in this version of my project,
I will not have Flip-Flops.  But they will be on my list for future interations.
-}

-- DELAY
{-
This would be needed for future versions of this project
-}

-- REGISTER FILE
{-
http://web.cse.ohio-state.edu/~teodorescu.1/download/teaching/cse675.au08/Cse675.02.E.MemoryDesign_part1.pdf
http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch05s03.html
-}

reg_out :: [Register] -> [Bit] -> [Bit] -> [Register]
reg_out [] [] _ = []
reg_out _ [] _ = error "reg_out invalid input"
reg_out [] _ _ = error "reg_out invalid input" 
reg_out (r:reg) (w:w_dec) wd = if (bitVal w) == 0
                               then r : (reg_out reg w_dec wd)
                               else (register wd) : (reg_out reg w_dec wd)

read_out :: [Bit] -> Registers -> [Bit]
read_out [] _ = error "read_out invalid input"
read_out ra rego = out
  where splits = foldr (\ x b -> (splitEvery 1 (registerVal x)):b) [] (registersVal rego)
        merges = foldr (\ x b -> if (length b) == 0 then x else (combine x b)) [] splits
        out = foldr (\ x b -> (multiplexer ra x):b) [] merges

combine :: [[Bit]] -> [[Bit]] -> [[Bit]]
combine [] [] = []
combine _ [] = error "combine invalid input"
combine [] _ = error "combine invalid input"
combine (x:xs) (y:ys) = (x ++ y) : (combine xs ys)


register_file :: Bit -> [Bit] -> [Bit] -> [Bit] -> [Bit] -> Registers -> (Registers, ([Bit], [Bit]))
register_file w ra1 ra2 wa wd regs
     | (((length ra1) == 5) && ((length ra2) == 5) && ((length wa) == 5) &&
       ((length wd) == 32) && ((length (registersVal regs)) == 32)) = (ro, (r1out,r2out))
     | otherwise = error "register_file invalid input"
    where w_decoder = n_to_2n_decoder_enable w wa
          ro = Registers (reg_out (registersVal regs) w_decoder wd)
          r1out = read_out ra1 ro
          r2out = read_out ra2 ro

-- FULL ADDER
{-
https://www.geeksforgeeks.org/full-adder-digital-electronics/
-}

full_adder :: Bit -> Bit -> Bit -> (Bit, Bit)
full_adder a b c_in = sumB (bitVal a) (bitVal b) (bitVal c_in)
  where sumB x y z = if (x+y+z) == 3 
                         then ((Bit 1),(Bit 1))
                         else (if (x+y+z) == 2 
                                 then ((Bit 0), Bit 1)
                                 else (if (x+y+z) ==1
                                        then ((Bit 1), (Bit 0))
                                        else ((Bit 0), (Bit 0))))




          


