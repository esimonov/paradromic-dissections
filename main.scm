(import srfi-28)
(load "io-helpers.scm")

(define (process-input half-twists-initial dissection-denominator)
  (let ((lengths (compute-lengths half-twists-initial dissection-denominator))
      (widths (compute-widths half-twists-initial dissection-denominator))
      (half-twists (compute-half-twists half-twists-initial dissection-denominator)))
    (display bar)
    (display
      (format #f
        "When dissecting ~a 1/~a way across its width, you get ~a~a\n~a\n"
        (describe-initial-structure half-twists-initial)
        dissection-denominator
        (format-short-summary lengths widths half-twists)
        (format-detailed-summary lengths widths half-twists)
        bar))
    'continue))

(define (compute-lengths half-twists-initial dissection-denominator)
  (if (even? half-twists-initial)
    '(1 . 1)
    (cons 2
      (if (= dissection-denominator 2) '() 1))))

(define (compute-widths half-twists-initial dissection-denominator)
  (cons
    (frac 1 dissection-denominator)
    (frac (- (sub1 dissection-denominator) (modulo half-twists-initial 2)) dissection-denominator)))

(define (compute-half-twists half-twists-initial dissection-denominator)
  (let ((num-for-odd (+ (* 2 half-twists-initial) 2)))
    (if (even? half-twists-initial)
      (cons half-twists-initial half-twists-initial)
      (cons num-for-odd
        (if (= dissection-denominator 2)
          '()
          half-twists-initial)))))

(define (frac numer denom) (/ numer denom))

(define (describe-initial-structure half-twists-initial)
  (if (zero? half-twists-initial) "an untwisted strip"
    (string-append
      "a strip with "
      (number->string half-twists-initial)
      " half-twist"
      (if (= half-twists-initial 1) "" "s"))))

(define (format-short-summary lengths widths half-twists)
  (let ((have-same-half-twists? (eq? (car half-twists) (cdr half-twists))))
    (if (null? (cdr half-twists))
      "a single connected strip which is 2 times longer than the original one:\n\n"
      (format "two ~a strips~a:\n\n"
        (if (zero? (car half-twists)) "disconnected" "linked")
        (if have-same-half-twists? " of the same length" ", one of which is 2 times longer than the other")))))

(define (format-detailed-summary lengths widths half-twists)
  (let ((has-one-strip? (null? (cdr lengths))))
    (string-append
      (if has-one-strip? "" "Strip #1\n")
      (format-strip-summary (car lengths) (car widths) (car half-twists))
      (if has-one-strip? ""
        (format "Strip #2\n~a\n"
          (format-strip-summary (cdr lengths) (cdr widths) (cdr half-twists)))))))

(define (format-strip-summary len wid half-twists)
  (let ((numer (numerator wid)) (denom (denominator wid)))
    (format "Length: ~aL\nWidth: ~aW/~a\nNumber of half-twists: ~a\n\n"
      (if (= len 1) "" len)
      (if (= numer 1) "" numer)
      denom
      half-twists)))

(define (main-loop)
  (display "Let L and W denote the initial length and width of the strip, respecitively.\n\n")
  (let ((half-twists
        (prompt-until-valid-number
          (allow-quitting "Enter the number of initial half-twists")
          validate-half-twists)))
    (if (eq? half-twists 'quit) (display "Goodbye!")
      (let ((dissection-denominator
            (prompt-until-valid-number
              (allow-quitting "Enter D>=2 to mark the line 1/D along which the strip will be dissected")
              validate-dissection-denominator)))
        (if (eq? dissection-denominator 'quit) (display "Goodbye!")
          (begin
            (process-input half-twists dissection-denominator)
            (main-loop)))))))

(main-loop)
