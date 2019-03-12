#lang brag

ac-line : journal-entry
journal-entry : entry-date "<" debit ("," debit)* ">" "<" credit ("," credit)* ">"
entry-date : digit {2} "-" digit {2} "-" digit {4}
debit : (accountd amt)+
accountd : (wrd "-")+
credit : (accountc amt)+
accountc : (wrd "-")+
amt : [zro] | [num (zro | num)*]
wrd : [letter+]
letter : "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" |
         "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" |
         "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"
         "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" |
         "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" |
         "U" | "V" | "W" | "X" | "Y" | "Z"
num : "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
zro : "0"
digit : "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "0"