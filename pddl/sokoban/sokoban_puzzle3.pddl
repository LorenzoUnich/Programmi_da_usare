(define (problem sokoban3) (:domain Sokoban_new)
(:objects a1 b1 a2 b2 a3 b3 c3 d3 a4 b4 c4 d4 a5 b5 - location
    box1 box2 - box
    sok - sokoban
)

(:init
    (= (total-cost) 0)
    (empty a1)
    (empty a2)
    (empty b1)
    (empty b2)
    (at box1 a3)
    (at sok b3 )
    (empty c3)
    (empty d3)
    (empty a4)
    (empty b4)
    (at box2 c4)
    (empty d4)
    (empty a5)
    (empty b5)
    (IsLeft a1 b1)
    (IsLeft a2 b2)
    (IsLeft a3 b3)
    (IsLeft a3 b3)
    (IsLeft b3 c3)
    (IsLeft c3 d3)
    (IsLeft a4 b4)
    (IsLeft b4 c4)
    (IsLeft c4 d4)
    (IsLeft a5 b5)

    (below a2 a1)
    (below a3 a2)
    (below a4 a3)
    (below a5 a4)
    (below b2 b1)
    (below b3 b2)
    (below b4 b3)
    (below b5 b4)
    (below c4 c3)
    (below d4 d3)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (or  (and (at box1 b1) (at box2 a3)) 
        (and (at box2 b1) (at box1 a3)))
    ;todo: put the goal condition here
)

)

;un-comment the following line if metric is needed
;(:metric minimize (total-cost))

