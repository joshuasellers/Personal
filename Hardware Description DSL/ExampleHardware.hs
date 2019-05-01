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

Useful link: http://web.cse.ohio-state.edu/~teodorescu.1/download/teaching/cse675.au08/Cse675.02.F.ALUDesign_part1.pdf
-}

alu :: Bit_32 -> Bit_32 -> Control -> (Bit_32, Bit, Bit, Bit)
alu a b control
    