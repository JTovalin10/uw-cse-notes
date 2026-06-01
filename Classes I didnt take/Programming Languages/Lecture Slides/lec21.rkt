
; encode expressions as pairs, using symbols
; ex. (cons 'int 5) is 5
; ex. (cons 'add (cons (cons 'int 4) (cons 'int 5))) is 4 + 5
(define (interp1 e)
  (cond
    ((= (car e) 'int) (cdr e))
    ((= (car e) 'add)
      (let ((e1 (cadr e))
            (e2 (cddr e)))
        (+ (interp1 e1) (interp1 e2))))))


(define (mk-int n) (cons 'int n))
(define (mk-add x y) (cons 'add (cons x y)))
(define (get-int e) (cdr e))
(define (get-e1 e) (cadr e))
(define (get-e2 e) (cddr e))
(define (is-int e) (= (car e) 'int))
(define (is-add e) (= (car e) 'add))
(define (interp2 e)
  (cond
    ((is-int e) (get-int e))
    ((is-add e) (+ (interp2 (get-e1 e)) (interp2 (get-e2 e))))))

(struct int n)
(struct add e1 e2)
;; int, int?, int-n, add, add?, add-e1, add-e2 for free
(define (interp3 e)
  (cond
    ((int? e) (int-n e))
    ((add? e) (+ (interp3 (add-e1 e)) (interp3 (add-e2 e))))))