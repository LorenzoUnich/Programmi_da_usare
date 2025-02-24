(define (problem sokoban5) (:domain Sokoban_new)
(:objects 
    sok - sokoban
    box1 box2 box3 box4  box5 - box
    b0 c0 a1 b1 c1 a2 b2 c2 - location
    a3 b3 c3 a4 b4 c4 a5 b5 c5 - location
    a6 b6 c6 d6 b7 c7 d7 - location 
)

(:init
    
    (= (total-cost) 0)
    (empty b0)
    (empty c0)
    (empty a1)
    (empty b1)
    (at box1 c1)
    (empty a2)
    (at box2 b2)
    (empty c2)
    (empty a3)
    (at box3 b3)
    (empty c3)
    (empty a4)
    (at box4 b4)
    (empty c4)
    (empty a5)
    (empty b5)
    (at box5 c5)
    (empty a6)
    (empty b6)
    (empty c6)
    (empty d6)
    (at sok b7)
    (empty c7)
    (empty d7)


    (IsLeft b0 c0)
    (below b1 b0)
    (below c1 c0)

    (IsLeft a1 b1)
    (IsLeft b1 c1)
    (below a2 a1)
    (below b2 b1)
    (below c2 c1)
    
    (IsLeft a2 b2)
    (IsLeft b2 c2)
    (below a3 a2)
    (below b3 b2)
    (below c3 c2)
    
    (IsLeft a3 b3)
    (IsLeft b3 c3)
    (below a4 a3)
    (below b4 b3)
    (below c4 c3)
    
    (IsLeft a4 b4)
    (IsLeft b4 c4)
    (below a5 a4)
    (below b5 b4)
    (below c5 c4)
    
    (IsLeft a5 b5)
    (IsLeft b5 c5)
    (below a6 a5)
    (below b6 b5)
    (below c6 c5)
    
    (IsLeft a6 b6)
    (IsLeft b6 c6)
    (IsLeft c6 d6)
    (below b7 b6)
    (below c7 c6)
    (below d7 d6)
    
    (IsLeft b7 c7)
    (IsLeft c7 d7)
    
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and (at box1 a1) (at box2 a2) (at box3 a3) (at box4 a4) (at box5 a5)
    ;todo: put the goal condition here
))

;un-comment the following line if metric is needed
;(:metric minimize (total-cost))

)