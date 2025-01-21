(#%require (lib "27.ss" "srfi"))

(display "Guess a number from 1 to 10: ")

(define scoreBoard '()) ; Initialize as an empty list

(define (play_guess answer attempts)
  (display "Enter guess: ")
  (define guess (read))

  (cond
    [(> guess answer)
     (display "Lower...\n")
     (play_guess answer (+ attempts 1))]

    [(< guess answer)
     (display "Higher...\n")
     (play_guess answer (+ attempts 1))]

    [(= guess answer)
     (begin
       (display "Correct! ")
       (display attempts)
       (display " guesses...\n")
       (display "Enter your name: ")
       (define dummy (read-line))  ; Clear buffer
       (define name (read-line))  ; Read player name
       (display "Good game, ")
       (display name)
       (display "!\n")
       
       (set! scoreBoard (cons (list name attempts) scoreBoard)))]))

(define (display-scoreboard)
  (display "Scoreboard:\n")
  (for-each (lambda (entry)
              (display (car entry))
              (display ": ")
              (display (cadr entry)) 
              (display " guesses\n"))
            scoreBoard))

(define (game-loop)
  (play_guess (+ (random-integer 9) 1) 1)
  (display "Enter 'q' to quit or any other key to continue: ")
  (define key (read-line))
  (cond
    [(or (string=? key "q") (string=? key "Q"))
     (display-scoreboard)
     (display "Thanks for playing!\n")]
    [else
     (game-loop)]))

(game-loop)