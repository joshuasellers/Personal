{-
Name: Josh Sellers
File Description: I separated out Bits and Bytes in case I wound up making a bunch 
more signal types (this feels separate from the hardware itself).
-}

{-# OPTIONS -Wall -Wno-unused-imports #-}

module Types where

-- SIGNALS

data Bit = Bit Int 
  deriving (Show)

bit :: Int -> Bit
bit n 
  | n == 0 || n == 1 = Bit n
  | otherwise = error "bit invalid value"

data Byte = Byte [Bit]
  deriving (Show)

byte :: [Bit] -> Byte
byte xs 
  | (length xs) == 8 = Byte xs
  | otherwise = error "byte invalid value" 

data Register = Register [Bit] Bit 

register :: [Bit] -> Bit -> Register
register xs b
   | (length xs) == 32 = Register xs b
   | otherwise = error "register invalid value"

data Register_File = Register_File [Register]

register_file :: [Register] -> Register_File
register_file xs
   | (length xs) == 32 = Register_File xs
   | otherwise = error "register_file invalid value"



