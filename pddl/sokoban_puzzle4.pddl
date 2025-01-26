(define (problem sokoban4) (:domain Sokoban_new)

(:objects 
    box1 box2 - box
    sok  - sokoban
    u1 u2 u3 u4 u5 u6 d1 d2 d3 d4 d5 d6 - location
    neck a1 b1 a2 b2 a3 b3 - location
    
)

(:init
    (= (total-cost) 0)
    (at sok d3)
    (at box1 d4)
    (at box2 d5)
    (empty u1)
    (empty u2)
    (empty u3)
    (empty u4)
    (empty u5)
    (empty u6)
    (empty d1)
    (empty d2)
    (empty d6)
    (empty neck)
    (empty a1)
    (empty a2)
    (empty a3)
    (empty b1)
    (empty b2)
    (empty b3)
    (below d1 u1)
    (below d2 u2)
    (below d3 u3)
    (below d4 u4)
    (below d5 u5)
    (below d6 u6)
    (below neck d5)
    (below b1 neck)
    (below a2 a1)
    (below a3 a2)
    (below b2 b1)
    (below b3 b2)
    (IsLeft u1 u2)
    (IsLeft u2 u3)
    (IsLeft u3 u4)
    (IsLeft u4 u5)
    (IsLeft u5 u6)
    (IsLeft d1 d2)
    (IsLeft d2 d3)
    (IsLeft d3 d4)
    (IsLeft d4 d5)
    (IsLeft d5 d6)
    (IsLeft a1 b1)
    (IsLeft a2 b2)
    (IsLeft a3 b3)
    
    ;todo: put the initial state's facts and numeric values here
)

(:goal (or (and (at box1 u4) (at box2 u5)) 
            (and (at box2 u4) (at box1 u5)))
    ;todo: put the goal condition here
)

;un-comment the following line if metric is needed
;(:metric minimize (total-cost))
)
