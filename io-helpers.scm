(define (read-line)
  (let loop ((chars '()))
    (let ((ch (read-char)))
      (cond
        ((eof-object? ch)
         (if (null? chars)
             ch
             (list->string (reverse chars))))
        ((char=? ch #\newline)
         (list->string (reverse chars)))
        (else
         (loop (cons ch chars)))))))

(define (prompt-until-valid-number message validation-fn)
  (let loop ()
    (display message)
    (let ((input (read-line)))
      (if (string=? input "q") 'quit
        (let ((result (validation-fn input)))
          (if (string? result)
            (begin
              (display result)
              (loop)) result))))))

(define (validate-num-half-twists input)
  (let ((num-twists (string->number input)))
    (cond ((not num-twists) (format #f "Input '~a' is not a valid number\n" input))
      ((not (integer? num-twists)) "Number of half-twists must be an integer\n")
      ((< num-twists 0) "Number of half-twists must be non-negative\n")
      (else num-twists))))

(define (validate-dissection-denominator input)
  (let ((dissection-denominator (string->number input)))
    (cond ((not dissection-denominator) (format #f "Input '~a' is not a valid number.\n" input))
      ((not (real? dissection-denominator)) "D must be a real number\n")
      ((< dissection-denominator 2) "D must be greater than or equal to 2\n")
      (else dissection-denominator))))

(define (allow-quitting prompt) (string-append prompt " (or 'q' to quit) : "))

(define bar "---------\n")