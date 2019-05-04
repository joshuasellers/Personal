{-
Name: Josh Sellers
File Description: An attempt at making an ALU.
-}

{-# OPTIONS -Wall -Wno-unused-imports #-}

module ExampleHardware where

import Hardware
import Data

{-
Arithmetic Logic Unit (ALU)
Useful link: https://minnie.tuhs.org/CompArch/Tutes/week02.html
Useful link: http://web.cse.ohio-state.edu/~teodorescu.1/download/teaching/cse675.au08/Cse675.02.F.ALUDesign_part1.pdf
-}

alu_1bit :: Bit -> Bit -> Control -> Bit -> (Bit, Bit)
alu_1bit a b cntrl carry = (result , c)
    where ands = and_gate [a,b]
          ors = or_gate [a,b]
          add = full_adder a b carry
          sub = full_adder a (not_gate b) carry
          ops = [(fst sub), (fst add), ands, ors]
          result = multiplexer (controlVal cntrl) ops
          c = multiplexer (controlVal cntrl) [(snd sub), (snd add), carry, carry]  

alu :: Bit_32 -> Bit_32 -> Control -> (Bit_32, Bit, Bit)
alu a_vals b_vals cntrl = ((bit_32 (fst result)), (zero (bit_32 (fst result))), (snd result))
      where carry = multiplexer (controlVal cntrl) [Bit 1, Bit 0, Bit 0, Bit 0]
            as = bit_32Val a_vals
            bs = bit_32Val b_vals
            result = foldr (\(a,b) (r,c) -> (((fst (alu_1bit a b cntrl c)):r),c)) ([], carry) (zip as bs)
            zero bits = not_gate (or_gate (bit_32Val bits))
