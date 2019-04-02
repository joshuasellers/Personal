#lang brag

ac-program : [@ac-line] (/NEWLINE [@ac-line])*
ac-line : journal-entry | @command
command : show | clear | ledger 
show : "show" [entry-date] (entry-date)*
clear : "clear" [[entry-date "," entry-date] | [entry-date] ]
ledger : "ledger"
journal-entry : entry-date /"<" debits /">" /"<" credits /">"
entry-date : DATE
debits : debit (/"," debit)*
credits : credit (/"," credit)*
debit : (account amt){1}
credit : (account amt){1}
account : ACCOUNT
amt : INTEGER

