(define (problem Puzzle1) 
(:domain Sokoban_new)



(:objects 
    sokoban - sokoban 
    box - box
    square1 - location
    square2 - location
    square3 - location

)
(:init
    (at sokoban square1)
    (at box square2)
    (empty square3)
    (IsLeft square1 square2)
    (IsLeft square2 square3)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    (at box square3)
    ;todo: put the goal condition here
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
