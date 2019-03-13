#lang br/quicklang
(require gregor)

(define-macro (ac-module-begin PARSE-TREE)
  #'(#%module-begin
    PARSE-TREE))
(provide (rename-out [ac-module-begin #%module-begin]))

(define (fold-funcs apl ac-funcs)
  (for/fold ([current-apl apl])
            ([ac-func (in-list ac-funcs)])
    (cond
      [(equal? "d" ac-func) (set! current-apl empty)]
      [(equal? "c" ac-func) (cons ac-func current-apl)]
      [else (cons ac-func current-apl)])))

(define-macro (ac-line ENTRIES ...)
  #'(begin
      (define ledger empty)
      (display (fold-funcs ledger (list ENTRIES ...)))))
(provide ac-line)

(define-macro (journal-entry "[" INFO ... "]")
  #'(lambda (ledger)
      (define entry (list INFO ...))
      (define dt (first entry))
      (set! entry (rest entry))
      (define d (first entry))
      (set! entry (rest entry))
      (define c (first entry))
      (define e (list dt d c))
      (display e)
      e
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

(define-macro (command CREDITS ...)
  #' "command")
(provide command)

