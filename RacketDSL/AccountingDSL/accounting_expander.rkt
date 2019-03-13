#lang br/quicklang
(require gregor)

(define-macro (ac-module-begin PARSE-TREE)
  #'(#%module-begin
    PARSE-TREE))
(provide (rename-out [ac-module-begin #%module-begin]))

(define (fold-funcs apl ac-funcs)
  (for/fold ([current-apl apl])
            ([ac-func (in-list ac-funcs)])
    (ac-func current-apl)))

(define-macro (ac-line ENTRIES ...)
  #'(begin
      (define ledger empty)
      (void (fold-funcs ledger (list ENTRIES ...)))))
(provide ac-line)

(define-macro (journal-entry "[" INFO ... "]")
  #'(lambda (ledger)
      (define entry (list INFO ...))
      (define dt (first entry))
      (display dt)
      (display (date? dt))
      (set! entry (rest entry))
      (define d (first entry))
      (display d)
      (set! entry (rest entry))
      (define c (first entry))
      (display c)
      ledger
      ))
(provide journal-entry)

(define-macro (entry-date DATE ...)
  #' (iso8601->date (apply string-append (list DATE ...))))
(provide entry-date)

(define-macro (debits DEBITS ...)
  #' "debits")
(provide debits)

(define-macro (credits CREDITS ...)
  #' "credits")
(provide credits)

