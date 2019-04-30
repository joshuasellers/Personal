{-
Name: Josh Sellers
File Description: I separated out Bits and Bytes in case I wound up making a bunch 
more signal types (this feels separate from the hardware itself).
-}

{-# OPTIONS -Wall -Wno-unused-imports #-}

module Data where

-- SIGNALS

data Bit = Bit Int 
  deriving (Show)

bit :: Int -> Bit
bit n 
  | n == 0 || n == 1 = Bit n
  | otherwise = error "bit invalid value"

bitVal :: Bit -> Int
bitVal (Bit b) = b

data Byte = Byte [Bit]
  deriving (Show)

byte :: [Bit] -> Byte
byte xs 
  | (length xs) == 8 = Byte xs
  | otherwise = error "byte invalid value" 

data Register = Register [Bit]
  deriving (Show)

register :: [Bit] -> Register
register xs
   | (length xs) == 32 = Register xs
   | otherwise = error "register invalid value"

data Registers = Registers [Register]
  deriving (Show)

registers :: [Register] -> Registers
registers xs
   | (length xs) == 32 = Registers xs
   | otherwise = error "registers invalid value"

registerVal :: Register -> [Bit]
registerVal (Register b) = b

registersVal :: Registers -> [Register]
registersVal (Registers b) = b

