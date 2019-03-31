#lang br/quicklang
(require "tokenizer.rkt" "parser.rkt")

(define (read-syntax path port)
  (datum->syntax #f `(module ac-mod "accounting_expander.rkt"
                       ,(parse path (make-tokenizer port)))))
(provide read-syntax)


; [(char-set ",-1234567890<>aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ") lexeme]
;[(from/to "ENTRY:" "]") ()]