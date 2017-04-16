#lang racket
(provide (all-defined-out))
(define s "hello"); the first thing
(define cube1
  (lambda (x)
    (* x x x)))

(define (cube x　y)
  (if (= y 0)
  	1
  	(* x (cube x (- y 1)))))
(define it (lambda (x) (if x "hi" #f)))