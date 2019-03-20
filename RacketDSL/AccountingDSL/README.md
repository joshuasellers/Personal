# AccountingDSL

###### Description:
For this project, I created a Domain-Specific Language (DSL) for the first two steps in the Accounting Cycle.  I used the language Racket for the project.  The domain was specified to be anything contained within those first two steps in the cycle:
- Journals Entries
- Ledger accounts
- All of the information needed to make the structures
The goal of the project was to make a basic language that accountant could use to make their initial journal of entries (all of the information that is used in the later steps of the accounting process).  Then, commands could be utilized to turn that journal into things like the ledger and other data structures used further on in the cycle.

### Installing

To install the project, make sure you have Racket downloaded on your device.  Additionally, make sure you have the modules of Racket known as: Beautiful Racket (bf) and Gregor (gregor).  These will be needed to run the DSL.

### Overall Usability

There are five files for this project: the parser, the two test files, the reader and the expander.  The test files contain sample code and can be edited for your convenience as you wish to test additional cases.  The parser contains the rules for the language:
- Every file is an ac-line
- each ac-line can either be a journal entry or a command
- The commands are "d", "c" and "l"
- the journal entry is formatted as so: [entry-date<debits><credits>]
- an entry date is of the form: yyyy-mm-dd
- debits and credits are lists of the debit/credit accounts and the amounts going into them



### Description
The reader uses the parser to tokenize and parse files. I don't have any specific error catching mechanisms in place, so incorrect code should return some type of parsing error or reading error.

Parsing:
```
ac-line : (journal-entry | @command)*
command : "d" | "c" | "l"
journal-entry : "["entry-date /"<" debits /">" /"<" credits /">""]"
...
```
Tokenizing:
```
(require brag/support)
(define (make-tokenizer port)
  (define (next-token)
    (define ac-lexer
      (lexer
       [(char-set "[],-1234567890<>aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ") lexeme]
       [any-char (next-token)]))
    (ac-lexer port))  
  next-token)
```
The tokenized and parsed code is then sent to the expander.  This is were the accountingDSL code is expanding into usable racket s-expressions.  In order to more accurately mimic the format of racket, I have the the expander work in a functional manner (e.g. no stored global values or data structures).  Essentially, I fold over the ac-lines.  Each time the fold function encounters a journal-entry, it adds it to the fold output value using cons.  For the three commands this happens: for "d," the fold deletes all previous values by reverting the fold value to an empty list, for "c" it display the current journal (essentially printing everything up until that point), and for "l" it converts the current list of journal-entries to a ledger.

Sample expander code:
```
(define (fold-funcs apl ac-funcs)
  (for/fold ([current-apl apl])
            ([ac-func (in-list ac-funcs)])
    (cond
      [(equal? "d" ac-func) (set! current-apl empty)]
      [(equal? "c" ac-func) (print-info current-apl)]
      [(equal? "l" ac-func) (print-ledger current-apl)]
      [else (cons ac-func current-apl)])))

(define (print-info journal)
  (display (for/fold ([curr-ledger empty])
            ([entry (in-list journal)])
    (entry curr-ledger)))
  journal)

(define-macro (ac-line ENTRIES ...)
  #'(begin
      (define ledger empty)
      (void (fold-funcs ledger (list ENTRIES ...)))))
(provide ac-line)
```
### Example Code
I made an example to show some basic usage of the DSL.  The files for this example are: `extra-test.rkt` and `accounting-test.rkt`. 
### Next Steps
Overall, this is a solid DSL.  This was my first time working in Racket, so in the future I'd like to move away from beautiful racket and stick to the actual code (beautiful racket hides some aspects of racket to make things easier for beginners).  Additionally, I would like to make a better parser and tokenizer.  Mine were based on the ones shown in the initial tutorials in the beautiful racket textbook.  Those all tokenize on characters.  The logic of my code would not have been compromised to tokenize on strings and it would simplify a lot of my code in my expander (I had to allocate resources for appending together a bunch of chars to create the intended values).  Finally, I would have added more commands than the initial three I used (for the later steps in the cycle).  All things considered, this was a good first project in Racket.
