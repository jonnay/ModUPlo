(load-from-max "lib/lists.scm")

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

(define (output-youklid onsets pulses offset)
  (out-0
   (list-offset (make-youklid onsets pulses)
                offset)))

(load-from-max "lib/test.scm")

(define (test)
  (expect-equal '(0 0 0 0)
                (make-youklid 0 4))
  (expect-equal '(1 0 0 0)
                (make-youklid 1 4))
  (expect-equal '(1 0 1 0)
                (make-youklid 2 4)))
