#lang racket
(provide (all-defined-out))

(define (my-if-bad e1 e2 e3)
  (if e1 e2 e3))

(define (f-bad x)
  (my-if-bad (= x 0)
             1
             (* x (f-bad (- x 1)))))

(define fibonacci3
  (letrec([memo null]
          [f (lambda (x)
               (let ([ans (assoc x memo)])
                 (if ans
                     (cdr ans)
                     (let ([new-ans (if (or (= x 1) (= x 2))
                                        1
                                        (+ (f (- x 1))
                                           (f (- x 2))))])
                       (begin
                         (set! memo (cons (cons x new-ans) memo))
                         new-ans)))))])
    f))

(define (fib x)
  (if (or (= x 1) (= x 2))
      1
      (+ (fib (- x 1))
         (fib (- x 2)))))