(define my_pair (cons 1 2))
(define result1
  (let
    ((x (car my_pair))
    (y (cdr my_pair)))
    (+ x y)))

(define a 5)
(define b 6)
(define result2
  (let
    ((a b)
    (b a))
    (cons a b)))



(define (dsum l)
  (if
    (nil? l)
    0
    (if
      (cons? l)
      (+ (dsum (car l)) (dsum (cdr l)))
      l)))

(define (dsum l)
  (cond
    ((nil? l) 0)
    ((cons? l) (+ (dsum (car l)) (dsum (cdr l))))
    (true l)))

(define (fact n)
  (cond
    ((= n 1) 1)
    (true (* n (fact (- n 1))))))

(define (length l)
  (cond
    ((nil? l) 0)
    ((cons? l) (+ 1 (length (cdr l))))))

(define (count_zeroes l)
  (cond
    ((nil? l) 0)
    ((cons? l) (cond
                  ((= 0 (car l)) (+ 1 (count_zeroes (cdr l))))
                  (true (count_zeroes (cdr l)))))))
