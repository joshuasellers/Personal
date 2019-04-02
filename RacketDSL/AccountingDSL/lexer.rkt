#lang br
(require brag/support)

(define-lex-abbrev digits (:+ (char-set "0123456789")))

(define-lex-abbrev date (:: (:= 4 (char-set "0123456789")) "-" (:** 1 2 (char-set "0123456789")) "-" (:** 1 2 (char-set "0123456789")) ))

(define-lex-abbrev account (intersection (:+ alphabetic) (complement "ledger") (complement "show") (complement "clear") (complement "len")))

(define basic-lexer
  (lexer-srcloc
   ["\n" (token 'NEWLINE lexeme)]
   [whitespace (token lexeme #:skip? #t)]
   [date (token 'DATE lexeme)]
   [digits (token 'INTEGER (string->number lexeme))]
   [account (token 'ACCOUNT lexeme)]
   [(:or "clear" "ledger" "show" "len") (token lexeme lexeme)]
   [(char-set "%<>,") lexeme]))

(provide basic-lexer)