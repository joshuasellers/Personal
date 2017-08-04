"""
project: BlockSoln
author: Josh Sellers
date: 5/25/2017
description: This main program finds the solution for my puzzle box
file: BlockMain.py
language: python3
"""

from src.simulate import *


def main():
    """
    Main function.  Runs simulation based on the given four blocks.
    :return:
    """
    B1 = ['R', 'Y', 'B', 'G', 'G', 'R']
    B2 = ['Y', 'Y', 'R', 'B', 'G', 'R']
    B3 = ['G', 'B', 'G', 'R', 'Y', 'B']
    B4 = ['Y', 'R', 'Y', 'B', 'Y', 'G']
    Blocks = [B1, B2, B3, B4]
    print("This is the solution for the box:")
    print("*********************************")
    Soln = simulate(Blocks)
    one = Soln[0]
    two = Soln[1]
    three = Soln[2]
    four = Soln[3]
    print("B1: ", B1)
    print("B2: ", B2)
    print("B3: ", B3)
    print("B4: ", B4)
    print("For B1, do this ring: ", one[0:4])
    print("For B2, do this ring: ", two[0:4])
    print("For B3, do this ring: ", three[0:4])
    print("For B4, do this ring: ", four[0:4])


# run the main program
main()