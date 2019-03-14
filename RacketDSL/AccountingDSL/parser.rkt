#lang brag

ac-line : (journal-entry | @command)*
command : "d" | "c"
journal-entry : "["entry-date /"<" debits /">" /"<" credits /">""]"
debits : debit (/"," debit)*
credits : credit (/"," credit)*
entry-date : (@digit{4} "-" @digit{1,2} "-" @digit{1,2})*
debit : (account amt){1}
credit : (account amt){1}
account : (@word /"-")+
amt : [@zero] | [@num (@zero | @num)*]
word : [@letter+]
letter : "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" |
         "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" |
         "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"
         "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" |
         "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" |
         "U" | "V" | "W" | "X" | "Y" | "Z"
num : "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
zero : "0"
digit : "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "0"