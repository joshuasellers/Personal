{-
Name: Josh Sellers
File Description: I separated out Bits and Bytes in case I wound up making a bunch 
more signal types (this feels separate from the hardware itself).
-}

{-# OPTIONS -Wall -Wno-unused-imports #-}

module Data where

import Data.List

-- BIT

data Bit = Bit Int 
  deriving (Show)

bit :: Int -> Bit
bit n 
  | n == 0 || n == 1 = Bit n
  | otherwise = error "bit invalid value"

bitVal :: Bit -> Int
bitVal (Bit b) = b

-- CONTROL

data Control = Control [Bit]
  deriving (Show)

control :: [Bit] -> Control
control xs 
  | (length xs) == 2 = Control xs
  | otherwise = error "control invalid value" 

controlVal :: Control -> [Bit]
controlVal (Control xs) = xs

control_0 :: Control -> Bit
control_0 (Control xs) = xs !! 1

control_1 :: Control -> Bit
control_1 (Control xs) = xs !! 0

-- ADDRESS

data Address = Address [Bit]
  deriving (Show)

address :: [Bit] -> Address
address xs 
  | (length xs) == 5 = Address xs
  | otherwise = error "address invalid value" 

addressVal :: Address -> [Bit]
addressVal (Address xs) = xs

-- BYTE

data Byte = Byte [Bit]
  deriving (Show)

byte :: [Bit] -> Byte
byte xs 
  | (length xs) == 8 = Byte xs
  | otherwise = error "byte invalid value" 

byteVal :: Byte -> [Bit]
byteVal (Byte xs) = xs

-- BIT_32

data Bit_32 = Bit_32 [Bit]
   deriving (Show)

bit_32 :: [Bit] -> Bit_32
bit_32 xs 
  | (length xs) == 32 = Bit_32 xs
  | otherwise = error "bit_32 invalid value" 

bit_32Val :: Bit_32 -> [Bit]
bit_32Val (Bit_32 xs) = xs

-- REGISTER

data Register = Register [Bit]
  deriving (Show)

register :: [Bit] -> Register
register xs
   | (length xs) == 32 = Register xs
   | otherwise = error "register invalid value"

registerVal :: Register -> [Bit]
registerVal (Register b) = b

-- REGISTERS

data Registers = Registers [Register]
  deriving (Show)

registers :: [Register] -> Registers
registers xs
   | (length xs) == 32 = Registers xs
   | otherwise = error "registers invalid value"

registersVal :: Registers -> [Register]
registersVal (Registers b) = b

-- MISC

bitwiseOpp :: [Bit] -> [Bit] -> ([Bit] -> Bit) -> [Bit]
bitwiseOpp [] [] _ = []
bitwiseOpp [] _ _ = error "bitwiseOpp invalid value"
bitwiseOpp _ [] _ = error "bitwiseOpp invalid value"
bitwiseOpp (a:as) (b:bs) f 
        | (length as) == (length bs) = (f [a,b]) : (bitwiseOpp as bs f)
        | otherwise = error "bitwiseOpp invalid value"
