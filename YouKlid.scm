
;; 2 -> ab
;; 3 -> abac 0 64 0 127
;; 4 -> abacabad 0 32 0 64 0 32 0 127
;; 5 -> abacabadabacabae

(define (make-youklid onsets pulses)
  (if (= onsets 0)
      (make-list pulses 0)
      (let youklid ((current -1)
                    (step 0)
                    (result '()))
        (let ((next (floor (* step (/ onsets pulses)))))
          (if (>= step pulses)
              (reverse result)
              (youklid next
                       (+ 1 step)
                       (cons (if (not (= current next)) 1 0)
                             result)))))))

(define (list-head lst num)
  (reverse
   (list-tail (reverse lst)
              (- (length lst)
                 num))))

(define (list-offset lst offset)
  (let ((offset (modulo (length lst) offset)))
    (append (list-tail lst offset)
            (list-head lst offset))))

(define (output-youklid onsets pulses offset)
  (out-0
   (list-offset (make-youklid onsets pulses)
                offset)))

(define (test)
  (expect-equal 'e-1
                (0 0 0 0)
                (make-youklid 1 4))
  (expect-equal 'e-2-is-unsurprising
                (1 0 1 0)
                (make-youklid 2 4)))

(define (expect-equal? name a b)
  (expect name equal? a b))

(define (expect name condition a b)
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
