{-
Name: Josh Sellers
File Description: Test out new DSL functions
-}

{-# OPTIONS -Wall -Wno-unused-imports #-}

module Test where

import Hardware
import Data


r0 :: [Bit]
r0 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r1 :: [Bit]
r1 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r2 :: [Bit]
r2 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r3 :: [Bit]
r3 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r4 :: [Bit]
r4 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r5 :: [Bit]
r5 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r6 :: [Bit]
r6 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r7 :: [Bit]
r7 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r8 :: [Bit]
r8 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r9 :: [Bit]
r9 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r10 :: [Bit]
r10 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r11 :: [Bit]
r11 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r12 :: [Bit]
r12 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r13 :: [Bit]
r13 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r14 :: [Bit]
r14 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r15 :: [Bit]
r15 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r16 :: [Bit]
r16 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r17 :: [Bit]
r17 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r18 :: [Bit]
r18 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r19 :: [Bit]
r19 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r20 :: [Bit]
r20 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r21 :: [Bit]
r21 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r22 :: [Bit]
r22 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r23 :: [Bit]
r23 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r24 :: [Bit]
r24 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r25 :: [Bit]
r25 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r26 :: [Bit]
r26 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r27 :: [Bit]
r27 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r28 :: [Bit]
r28 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r29 :: [Bit]
r29 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r30 :: [Bit]
r30 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

r31 :: [Bit]
r31 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, 
      Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

reg0 :: Register
reg0 = Register r0

reg1 :: Register
reg1 = Register r1

reg2 :: Register
reg2 = Register r2

reg3 :: Register
reg3 = Register r3

reg4 :: Register
reg4 = Register r4

reg5 :: Register
reg5 = Register r5

reg6 :: Register
reg6 = Register r6

reg7 :: Register
reg7 = Register r7

reg8 :: Register
reg8 = Register r8

reg9 :: Register
reg9 = Register r9

reg10 :: Register
reg10 = Register r10

reg11 :: Register
reg11 = Register r11

reg12 :: Register
reg12 = Register r12

reg13 :: Register
reg13 = Register r13

reg14 :: Register
reg14 = Register r14

reg15 :: Register
reg15 = Register r15

reg16 :: Register
reg16 = Register r16

reg17 :: Register
reg17 = Register r17

reg18 :: Register
reg18 = Register r18

reg19 :: Register
reg19 = Register r19

reg20 :: Register
reg20 = Register r20

reg21 :: Register
reg21 = Register r21

reg22 :: Register
reg22 = Register r22

reg23 :: Register
reg23 = Register r23

reg24 :: Register
reg24 = Register r24

reg25 :: Register
reg25 = Register r25

reg26 :: Register
reg26 = Register r26

reg27 :: Register
reg27 = Register r27

reg28 :: Register
reg28 = Register r28

reg29 :: Register
reg29 = Register r29

reg30 :: Register
reg30 = Register r30

reg31 :: Register
reg31 = Register r31

regs :: Registers
regs = Registers [reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7, 
                  reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,
                  reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,
                  reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31]

wd :: [Bit]
wd = [Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, 
      Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, 
      Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, 
      Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1, Bit 1]

w :: Bit
w = Bit 1

wa :: [Bit]
wa = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

ra1 :: [Bit]
ra1 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 0]

ra2 :: [Bit]
ra2 = [Bit 0, Bit 0, Bit 0, Bit 0, Bit 1]

testRegFile :: IO()
testRegFile = writeFile "test.txt" $ show $ register_file w ra1 ra2 wa wd regs
