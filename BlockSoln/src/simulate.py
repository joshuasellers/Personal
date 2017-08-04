"""
project: BlockSoln
author: Josh Sellers
date: 5/25/2017
description: This program runs the solution-finding algorithm
file: simulate.py
language: python3
"""
from src.block import *


def simulate(Blocks):
    """
    Run simulation of the puzzle.  Create four Blocks,
    run backtracking on them and find the solution
    :param Blocks: pips for four blocks
    :return: return the solution for the puzzle
    """
    soln = [0,0,0,0]
    x = 0
    for block in Blocks:
        soln[x] = Block(x,block)
        x+=1
    final = [0,0,0,0]
    zeros = 4
    findSoln(soln, final, zeros)
    return final


def findSoln(soln, final, zeros):
    """
    Backtracking algorithm.  Iterates through four spaces.
    If one is empty ('0'), it tries a ring from the given Block's permutations.
    Runs until all spaces are filled with a valid solution.
    :param soln: Blocks with permutations
    :param final: final solution
    :param zeros: number of empty spaces
    :return:
    """
    if zeros == 0:
        # solution found
        return isValid(final)
    for b in range(0,4):
        if final[b] != 0:
            # If its not empty jump
            continue
        for p in soln[b].getCombos():
            final[b] = p
            if isValid(final) and findSoln(soln, final, zeros-1):
                return True
            # prunes branches
            final[b] = 0
    return False


def isValid(final):
    """
    Checks if current setup is valid; the must be no duplicate across the rings
    :param final: the current setup
    :return: if the soltion is valid
    """
    r = True
    for s in range(0,4):
        for t in range(0,4):
            if s != t and final[s] != 0 and final[t] != 0:
                for u in range(0,4):
                    # check for equal pips in the rings
                    if final[s][u] == final[t][u]:
                        return False
    print(final)
    return r