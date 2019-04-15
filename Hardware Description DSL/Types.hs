{-
Name: Josh Sellers
File Description: Types
-}

{-# OPTIONS -Wall -Wno-unused-imports #-}

module Types where

-- SIGNALS

data Bit = Bit Int 
  deriving (Show)

bit :: Int -> Bit
bit n 
  | n == 0 || n == 1 = Bit n
  | otherwise = error "invalid value"

data Byte = Byte [Bit]
  deriving (Show)

byte :: [Bit] -> Byte
byte xs 
  | (length xs) == 8 = Byte xs
  | otherwise = error "invalid value" 



