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

(define-macro (journal-entry "[" INFO ... "]")
  #'(lambda (ledger)
      (define entry (list INFO ...))
      (define dt (first entry))
      (set! entry (rest entry))
      (define d (first entry))
      (set! entry (rest entry))
      (define c (first entry))
      (define e (list dt d c))
      (cons e ledger)
      ))
(provide journal-entry)

(define-macro (entry-date DATE ...)
  #' (iso8601->date (apply string-append (list DATE ...))))
(provide entry-date)

(define-macro (debits DEBITS ...)
  #' (fold-accs empty (list DEBITS ...))
  )
(provide debits)

(define-macro (debit INFO ...)
  #' (fold-accs empty (list INFO ...))
  )
(provide debit)

(define-macro (credits CREDITS ...)
  #' (fold-accs empty (list CREDITS ...)))
(provide credits)

(define-macro (credit INFO ...)
  #' (fold-accs empty (list INFO ...))
  )
(provide credit)

(define (fold-accs ledger acs)
  (for/fold ([current-apl ledger])
            ([ac (in-list acs)])
    (cons ac current-apl)))


(define-macro (command COMMAND ...)
  #' "command")
(provide command)

(define-macro (account LETTER ...)
  #' (apply string-append (list LETTER ...)))
(provide account)

(define-macro (amt NUMBER ...)
  #' (apply string-append (list NUMBER ...)))
(provide amt)

(define (print-ledger journal)
  (define j (for/fold ([curr-ledger empty])
            ([entry (in-list journal)])
    (entry curr-ledger)))
  (display j)
  (display (ledger ast lbt rde))
  (for/fold ([cl (ledger ast lbt rde)])
            ([e (in-list j)])
    (set! e (rest e))
    (define d (first e))
    (set! e (rest e))
    (define c (first e))
    (add-to-ledger cl d c))
  journal)

(define (add-to-ledger l d c)
  l)

(struct assets ([cash #:auto #:mutable] [equipment #:auto #:mutable] [supplies #:auto #:mutable])
  #:auto-value empty
  #:transparent
  #:extra-constructor-name ast)

(struct liabilities ([accounts-payable #:auto #:mutable] [unearned-revenue #:auto #:mutable])
  #:auto-value empty
  #:transparent
  #:extra-constructor-name lbt)

(struct rde ([service-revenue #:auto #:mutable] [dividend #:auto #:mutable] [expense #:auto #:mutable])
  #:auto-value empty
  #:transparent
  #:extra-constructor-name Revenue-Dividends-Expenses)

(struct ledger (assets liabilities rde)
  #:transparent)
