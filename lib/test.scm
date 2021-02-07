(define (expect-equal a b)
  (expect 'equal? equal? a b))

(define (expect name condition a b)
  (post condition)
  (let ((result (apply condition (list a b))))
    (if result
        (post name)
        (error 'test-failure
               (with-output-to-string
                 (lambda ()
                   (display "failure: ")
                   (display name)
                   (newline)
                   (display "Comparison: ")
                   (display (object->string condition))
                   (newline)
                   (display (object->string a))
                   (newline)
                   (display (object->string b))))))))
