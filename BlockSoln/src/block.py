"""
project: BlockSoln
author: Josh Sellers
date: 5/25/2017
description: This creates the block class
file: block.py
language: python3
"""


class Block(object):
    """A block with different coloured pips

    Attributes:
        :param pips A 2D array of ring combos
        :param name Name given to block
    """

    def __init__(self, name, pips):
        """
        Initialize new Block.  Give it a name and its possible ring combinations

        :param name: name of block
        :param pips: pips for given block
        """
        self.name = name
        self.combinations = permutations(pips)

    def getCombos(self):
        """
        Return ring combinations
        :return:
        """
        return self.combinations


def permutations(pips = []):
    """
    Return the possible ring combos for the block in a 2D array
    :param pips: pips of given Block
    :return: ring combos
    """
    w, h = 4, 24
    # create empty combo array
    combos = [[0 for x in range(w)] for y in range(h)]
    combos[0] = [1, 2, 3, 4]
    combos[1] = [1, 6, 3, 5]
    combos[2] = [2, 3, 4, 1]
    combos[3] = [2, 6, 4, 5]
    combos[4] = [3, 4, 1, 2]
    combos[5] = [3, 6, 1, 5]
    combos[6] = [4, 1, 2, 3]
    combos[7] = [4, 6, 2, 5]
    combos[8] = [6, 3, 5, 1]
    combos[9] = [6, 4, 5, 2]
    combos[10] = [5, 1, 6, 3]
    combos[11] = [5, 2, 6, 4]
    combos[12] = [1, 4, 3, 2]
    combos[13] = [1, 5, 3, 6]
    combos[14] = [2, 1, 4, 3]
    combos[15] = [2, 5, 4, 6]
    combos[16] = [3, 2, 1, 4]
    combos[17] = [3, 5, 1, 6]
    combos[18] = [4, 3, 2, 1]
    combos[19] = [4, 5, 2, 6]
    combos[20] = [6, 1, 5, 3]
    combos[21] = [6, 2, 5, 4]
    combos[22] = [5, 3, 6, 1]
    combos[23] = [5, 4, 6, 2]
    # given combo array and specific pips, repopulate with colors
    for x in range(0,24):
        combos[x] = [pips[combos[x][0]-1], pips[combos[x][1]-1], pips[combos[x][2]-1], pips[combos[x][3]-1]]
    return combos
