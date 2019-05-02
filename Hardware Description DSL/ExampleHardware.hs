{-
Name: Josh Sellers
File Description: An attempt at making an ALU.
-}

{-# OPTIONS -Wall -Wno-unused-imports #-}

module Example where

import Hardware
import Data

{-
Arithmetic Logic Unit (ALU)
Useful link: https://minnie.tuhs.org/CompArch/Tutes/week02.html
Useful link: http://web.cse.ohio-state.edu/~teodorescu.1/download/teaching/cse675.au08/Cse675.02.F.ALUDesign_part1.pdf
-}

alu_1bit :: Bit -> Bit -> Control -> Bit -> (Bit, Bit)
alu_1bit a b control carry = (result , c)
    where and = and_gate [a,b]
          or = or_gate [a,b]
          add = full_adder a b carry
          sub = full_adder a (not_gate b) carry
          ops = [or,and, (fst add),(fst sub)]
          result = multiplexer (controlVal control) ops
          c = if (bitVal (control_1 control)) == 1 && (bitVal (control_0 control)) == 1 
          	     then snd sub
          	     else snd add

alu :: Bit_32 -> Bit_32 -> Control -> (Bit_32, Bit, Bit, Bit)
alu a b control = bitwiseOpp (bit_32Val a) (bit_32Val b) alu_1bit 
