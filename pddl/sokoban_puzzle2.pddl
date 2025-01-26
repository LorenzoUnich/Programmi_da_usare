(define (problem sokoban2) (:domain Sokoban_new)
(:objects 
    s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 - location 
    sokoban1 - sokoban 
    box1 box2 - box

)

(:init
    
    (= (total-cost) 0)
    (at sokoban1 s11)
    (at box1 s8)
    (at box2 s9)
    (empty s1)
    (empty s2 )
    (empty s3)
    (empty s4 )
    (empty s5 )
   (empty s6 )
    (empty s7)
    (empty s10)
    (empty s12)
    (empty s13)
    (empty s14)

    (IsLeft s1 s2)
    (IsLeft s2 s3)
    (IsLeft s3 s4)
    
    
    (IsLeft s5 s6)

    (IsLeft s7 s8)
    (IsLeft s8 s9)
    (IsLeft s9 s10)
    (IsLeft s10 s11)
    (IsLeft s11 s12)
    (IsLeft s12 s13)
    (IsLeft s13 s14)

    (below s5 s3)
    (below s6 s4)
    (below s9 s5)
    (below s10 s6)
    (below s11 s7)
    (below s12 s8)
    (below s13 s9)
    (below s14 s10)
   
    )


    ;todo: put the initial state's facts and numeric values here


(:goal (or (and (at box1 s1) (at box2 s2))
          (and (at box1 s2) (at box2 s1)) ) 
) ;todo: put the goal condition here
)



;un-comment the following line if metric is needed
;(:metric minimize (total-cost))

