
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda (elem) (string-append elem suffix)) xs))

(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (let ([ans (s)])
        (cons (car ans) (stream-for-n-steps (cdr ans) (- n 1))))))

(define funny-number-stream
  (letrec ([f (lambda (x)
                (cons (if (= (remainder x 5) 0)
                                       (- 0 x)
                                       x) (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

(define (dan-then-dog)
  (cons "dan.jpg" (lambda () (cons "dog.jpg" dan-then-dog))))

(define (stream-add-zero s)
  (lambda ()
    (let ([eval (s)])
      (cons (cons 0 (car eval)) (stream-add-zero (cdr eval))))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))
                      (lambda () (f (+ n 1)))))])
    (lambda () (f 0))))

(define (vector-assoc v vec)
  (letrec ([f (lambda (v vec n)
                (if (equal? n (vector-length vec)) #f
                    (letrec ([elem (vector-ref vec n)])                                                    
                      (if (pair? elem)
                          (if (equal? v (car elem))
                              elem
                              (f v vec (+ n 1)))
                          (f v vec (+ n 1))))))])
(f v vec 0)))

(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [pos 0]
           [f (lambda (v)
                (let ([ans (vector-assoc v memo)])
                  (if ans
                      ans
                      (let ([new-ans (assoc v xs)])
                        (if new-ans
                            (begin
                              (vector-set! memo pos new-ans)
                              (if (equal? n (+ pos 1))
                                  (set! pos 0)
                                  (set! pos (+ pos 1)))
                              new-ans)
                            new-ans)))))])
    f))

(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (letrec ([x e1]
           [loop (lambda () (if (>= e2 x)
             #t
             (loop)))])
       (loop))]))
       