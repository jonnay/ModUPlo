;; 1 -> a
;; 2 -> ab
;; 3 -> abac 0 64 0 127
;; 4 -> abacabad 0 32 0 64 0 32 0 127
;; 5 -> abacabadabacabae
(define (make-acab order)
  (define (safe-half-map lst)
    (map (lambda (x)
           (if (= 0 x) 0 (/ x 2)))
         lst))
  (define (all-but-last lst)
    (if (<= (length lst) 1)
        lst
        (reverse (list-tail (reverse lst) 1))))
  (append
   (all-but-last 
         (let abacabad ((ord order))
           (case ord
             ((0) '())
             ((1) '(0 128))
             (else
              (append (safe-half-map (abacabad (- ord 1)))
                      (safe-half-map (all-but-last (abacabad (- ord 1))))
                      '(128))))))
   '(127)))

(define (get-acab order reversed?)
  (out-0 (if (= 1 reversed?)
             (reverse (make-acab order))
             (make-acab order))))

(define (test)
  (post "Testing...")
  (expect 'order-0-is-127
          equal?
          '(127)
          (make-acab 0))
  (expect 'order-1-is-0-127
          equal?
          '(0 127)
          (make-acab 1))
  (expect 'order-2-is-0-64-0-127
          equal?
          '(0 64 0 127)
          (make-acab 2)))

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
