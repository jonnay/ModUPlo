
(define (list-head lst num)
  (reverse
   (list-tail (reverse lst)
              (- (length lst)
                 num))))

(define (list-offset lst lst-offset)
  (let ((offset (modulo lst-offset (length lst))))
    (append (list-tail lst offset)
            (list-head lst offset))))

(define testing #f)

(if testing
    (let ((input '(a b c d)))
      (load-from-max "lib/test.scm")
      (expect 'list-head-2 equal? '(a b) (list-head input 2))
      (expect 'list-head-3 equal? (list-head input 3) '(a b c))
      (expect 'list-offset-1 equal? (list-offset input 0) '(a b c d))
      (expect 'list-offset-2 equal? (list-offset input 2) '(c d a b))
      (expect 'list-offset-1 equal? (list-offset input 1) '(b c d a))))
