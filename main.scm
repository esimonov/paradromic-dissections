(import srfi-28)
(load "io-helpers.scm")

(define (process-input num-half-twists-initial dissection-denominator)
  (let ((resulting-lengths (compute-lengths num-half-twists-initial dissection-denominator))
      (resulting-half-twists (compute-half-twists num-half-twists-initial dissection-denominator)))
    (display bar)
    (display
      (format #f
        "When dissecting ~a of length L 1/~a way across its width, you get ~a~a\n~a\n"
        (describe-initial-structure num-half-twists-initial)
        dissection-denominator
        (format-short-summary resulting-lengths resulting-half-twists)
        (format-detailed-summary resulting-lengths resulting-half-twists)
        bar))
    'continue))

(define (compute-lengths num-half-twists-initial dissection-denominator)
  (if (even? num-half-twists-initial)
    '(1 . 1)
    (cons 2
      (if (= dissection-denominator 2) '() 1))))

(define (compute-half-twists num-half-twists-initial dissection-denominator)
  (let ((num-for-odd (+ (* 2 num-half-twists-initial) 2)))
    (if (even? num-half-twists-initial)
      (cons num-half-twists-initial num-half-twists-initial)
      (cons num-for-odd
        (if (= dissection-denominator 2)
          '()
          num-half-twists-initial)))))

(define (describe-initial-structure num-half-twists-initial)
  (if (zero? num-half-twists-initial) "an untwisted strip"
    (string-append
      "a strip with "
      (number->string num-half-twists-initial)
      " half-twist"
      (if (= num-half-twists-initial 1) "" "s"))))

(define (format-short-summary resulting-lengths resulting-half-twists)
  (let ((have-same-num-half-twists? (eq? (car resulting-half-twists) (cdr resulting-half-twists))))
    (if (null? (cdr resulting-half-twists))
      (format "a single connected strip which is ~a times longer and slimmer and than the original one:\n\n" (car resulting-lengths))
      (format "two ~a strips~a:\n\n"
        (if (zero? (car resulting-half-twists)) "disconnected" "linked")
        (if have-same-num-half-twists? " of the same length" ", one of which is twice as long as the other")))))

(define (format-detailed-summary resulting-lengths resulting-half-twists)
  (let ((has-one-strip? (null? (cdr resulting-lengths))))
    (string-append
      (if has-one-strip? "" "Strip #1\n")
      (format-strip-summary (car resulting-lengths) (car resulting-half-twists))
      (if has-one-strip? ""
        (format "Strip #2\n~a\n" (format-strip-summary (cdr resulting-lengths) (cdr resulting-half-twists)))))))

(define (format-strip-summary len num-half-twists)
  (format "Length: ~aL\nNumber of half-twists: ~a\n\n" (if (eq? len 1) "" len) num-half-twists))

(define (main-loop)
  (let ((num-half-twists
        (prompt-until-valid-number
          (allow-quitting "Enter the number of initial half-twists")
          validate-num-half-twists)))
    (if (eq? num-half-twists 'quit) (display "Goodbye!")
      (let ((dissection-denominator
            (prompt-until-valid-number
              (allow-quitting "Enter D>=2 to mark the line 1/D along which the strip will be dissected")
              validate-dissection-denominator)))
        (if (eq? dissection-denominator 'quit) (display "Goodbye!")
          (begin
            (process-input num-half-twists dissection-denominator)
            (main-loop)))))))

(main-loop)
