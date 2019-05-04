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
alu a_vals b_vals cntrl = if c1 == 0
                    then ((bit_32 (fst and_or)), (zero (bit_32 (fst and_or))), (snd and_or))
                    else (if c0 == 1
                            then ((bit_32 (fst subs)), (zero (bit_32 (fst subs))), (snd subs))
                            else ((bit_32 (fst adds)), (zero (bit_32 (fst adds))), (snd adds)) )
      where c0 = (bitVal (control_0 cntrl))
            c1 = (bitVal (control_1 cntrl))
            carry = multiplexer (controlVal cntrl) [Bit 1, Bit 0, Bit 0, Bit 0]
            as = bit_32Val a_vals
            bs = bit_32Val b_vals
            and_or = foldr (\(a,b) (r,c) -> (((fst (alu_1bit a b cntrl c)):r),c)) ([], carry) (zip as bs)
            adds = foldr (\(a,b) (r,c) -> 
                           ( ((fst (alu_1bit a b cntrl c)):r) , (snd (alu_1bit a b cntrl c)) ) )  
                              ([], carry) (zip as bs)
            subs = foldr (\(a,b) (r,c) -> 
                           ( ((fst (alu_1bit a b cntrl c)):r) , (snd (alu_1bit a b cntrl c)) ) ) 
                              ([], carry) (zip as bs)
            zero bits = not_gate (or_gate (bit_32Val bits))
