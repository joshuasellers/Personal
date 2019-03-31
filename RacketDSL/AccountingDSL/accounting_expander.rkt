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

(define-macro (ac-program ENTRIES ...)
  #'(begin
      (define ledger empty)
      (void (fold-funcs ledger (list ENTRIES ...)))))
(provide ac-program)

(define-macro (journal-entry INFO ...)
  #'(lambda (ledger)
      (define entry (list INFO ...))
      (define dt (first entry))
      (set! entry (rest entry))
      (define d (first entry))
      (set! entry (rest entry))
      (define c (first entry))
      (define e (list dt d c))
      (cons e ledger)))
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

(define-macro (account ACT)
  #' ACT)
(provide account)

(define-macro (amt NUM)
  #' NUM)
(provide amt)

(define-macro (ledger ARG)
  #' (lambda (journal)
      (print-ledger journal)))
(provide ledger)

(define-macro (show ARG)
  #' (lambda (journal)
      (display journal)
       journal))
(provide show)

(define-macro (clear ARG)
  #' (lambda (journal)
      empty))
(provide clear)

(define (print-ledger journal)
  (define ast (assets))
  (define lbt (liabilities))
  (define r (rde))
  (display (for/fold ([cl (list ast lbt r)])
            ([e (in-list journal)])
    (set! e (rest e))
    (define d (first e))
    (set! e (rest e))
    (define c (first e))
    (add-to-ledger cl d c)))
  journal)

(define (add-to-ledger l d c)
  (define l-one (for/fold ([led l])
            ([ds (in-list d)])
    (define val (first ds))
    (set! ds (rest ds))
    (define ac (first ds))
    (cond
      [(equal? "cash" ac) (access-cash-d led val)]
      [(equal? "equipment" ac) (access-equipment-d led val)]
      [else (access-supplies-d led val)])))
  (for/fold ([led l-one])
            ([cs (in-list c)])
    (define val (first cs))
    (set! cs (rest cs))
    (define ac (first cs))
    (cond
      [(equal? "cash" ac) (access-cash-c led val)]
      [else (access-stock-c led val)])))

(define (access-cash-d led val)
  (define ats (first led))
  (define fst (first (assets-cash ats)))
  (set! fst (cons val fst))
  (define c (list fst (second (assets-cash ats))))
  (set-assets-cash! ats c)
  (list ats (second led) (third led)))

(define (access-equipment-d led val)
  (define ats (first led))
  (define fst (first (assets-equipment ats)))
  (set! fst (cons val fst))
  (define c (list fst (second (assets-equipment ats))))
  (set-assets-equipment! ats c)
  (list ats (second led) (third led)))

(define (access-supplies-d led val)
  (define ats (first led))
  (define fst (first (assets-supplies ats)))
  (set! fst (cons val fst))
  (define c (list fst (second (assets-supplies ats))))
  (set-assets-supplies! ats c)
  (list ats (second led) (third led)))

(define (access-cash-c led val)
  (define ats (first led))
  (define snd (second (assets-cash ats)))
  (set! snd (cons val snd))
  (define c (list (first (assets-cash ats)) snd))
  (set-assets-cash! ats c)
  (list ats (second led) (third led)))

(define (access-stock-c led val)
  (define ats (third led))
  (define snd (second (rde-stock ats)))
  (set! snd (cons val snd))
  (define c (list (first (rde-stock ats)) snd))
  (set-rde-stock! ats c)
  (list (first led) (second led) ats))

(struct assets ([cash #:auto #:mutable] [equipment #:auto #:mutable] [supplies #:auto #:mutable])
  #:auto-value '(() ())
  #:transparent)

(struct liabilities ([accounts-payable #:auto #:mutable] [unearned-revenue #:auto #:mutable])
  #:auto-value '(() ())
  #:transparent)

(struct rde ([service-revenue #:auto #:mutable] [dividend #:auto #:mutable] [stock #:auto #:mutable])
  #:auto-value '(() ())
  #:transparent) 
