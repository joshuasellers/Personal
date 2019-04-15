{-
Name: Josh Sellers
File Description: Types
-}

{-# OPTIONS -Wall -Wno-unused-imports #-}

module Types where

-- SIGNALS

data Bit = 0 | 1 
  deriving (Show, Read, Eq, Bounded, Enum)

data Byte = [Bit, Bit, Bit, Bit, Bit, Bit, Bit, Bit]
  deriving (Show, Read, Eq, Bounded, Enum)


