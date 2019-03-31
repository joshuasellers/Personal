#lang brag

ac-program : [ac-line] (NEWLINE [ac-line])*
ac-line : journal-entry | command
command : "d" | "c" | "l"
journal-entry : date /"<" debits /">" /"<" credits /">"
date : DATE
debits : debit (/"," debit)*
credits : credit (/"," credit)*
debit : (account amt){1}
credit : (account amt){1}
account : ACCOUNT
amt : INTEGER

