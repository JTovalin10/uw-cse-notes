(struct int n)
(struct add e1 e2)
(struct mul e1 e2)
(define (interp4 e)
  (match e
    ((int i) i)
    ((add e1 e2) (+ (interp4 e1) (interp4 e2)))
    ((mul e1 e2) (* (interp4 e1) (interp4 e2)))))