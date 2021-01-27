
;; (0 1 3 5 6 8 10)
;; (0 1 1 3 3 5 6 6 8 8 10 10)

(define (scale-to-12 . lst)
  (out (rescale lst)))

(define (rescale notes-in-scale)
  (reverse
   (let fill-scale ((notes notes-in-scale)
                    (scale-map '()))
     (cond ((<= 12 (length scale-map))
            scale-map)
           ((null? notes)
            (cons (car scale-map) scale-map))
           ((= (length scale-map) (car notes))
            (fill-scale (cdr notes) (cons (car notes) scale-map)))
           (else
            (fill-scale notes (cons (car scale-map) scale-map)))))))

(define (test)
  (expect 'converts-push-scale-to-full-12
          equal?
          '(0 1 1 3 3 5 5 7 8 8 10 10)
          (rescale '(0 1 3 5 7 8 10))))

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
