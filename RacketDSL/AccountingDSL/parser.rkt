#lang brag

ac-program : [@ac-line] (/NEWLINE [@ac-line])*
ac-line : journal-entry | @command
command : show | clear | ledger | len
show : "show" ([entry-date] (entry-date)* | [ACCOUNT] | [INTEGER] | [len])
clear : "clear" ([entry-date] | [INTEGER])
ledger : "ledger"
len : "len"
journal-entry : entry-date /"<" debits /">" /"<" credits /">"
entry-date : DATE
debits : debit (/"," debit)*
credits : credit (/"," credit)*
debit : (account amt){1}
credit : (account amt){1}
account : ACCOUNT
amt : INTEGER

