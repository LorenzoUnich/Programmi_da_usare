(define (domain Sokoban_new)
	(:requirements :strips :equality :typing :disjunctive-preconditions)
	(:types
        sokoban box - thing
	    location
    )
	(:functions
		(total-cost)
	)
	
	(:predicates (IsLeft ?x - location ?y - location) 							;is location x to the left of loacation y?
				 (below ?x - location  ?y - location)  							;is location x below location y?
				 (at ?x - thing ?y - location)     							   ;is thing x @ location y?
				 (empty ?x - location))						;is location x empty?

	(:action goLeft
	:parameters (?sokoban - sokoban ?x - location ?y - location)
	:precondition (and (at ?sokoban ?x)                     ; Il sokoban è nella posizione ?x
					   (IsLeft ?y ?x)                      ; La posizione ?y è a sinistra della posizione ?x
					   (empty ?y))                         ; La posizione ?y è vuota, quindi sposta a sinistra in ?y
	:effect (and (at ?sokoban ?y) (empty ?x)
			(not (at ?sokoban ?x)) (not (empty ?y)) (increase(total-cost) 1) )
			)


	(:action goRight
		:parameters (?sokoban - sokoban ?x - location ?y - location)
		:precondition (and (at ?sokoban ?x)
							(IsLeft ?x ?y)    					;location x is to the left of y
							(empty ?y))       					;and y is empty, so move right to y
		:effect (and (at ?sokoban ?y) (empty ?x)
				(not (at ?sokoban ?x)) (not (empty ?y))
				(increase(total-cost) 1)
				))

	(:action goUp
		:parameters (?sokoban - sokoban ?x - location ?y - location)
		:precondition (and (at ?sokoban ?x)
						  (below ?x ?y)      					;location x is below location y
						  (empty ?y))        					;and y is empty, so move up to y
		:effect (and (at ?sokoban ?y) (empty ?x)
				(not (at ?sokoban ?x)) (not (empty ?y))
				(increase(total-cost) 1)
				))

	(:action goDown
		:parameters (?sokoban - sokoban ?x - location ?y - location)
		:precondition (and (at ?sokoban ?x)
						  (below ?y ?x)      					;location y is below location x
						  (empty ?y))        					;and y is empty, so move down to y
		:effect (and (at ?sokoban ?y) (empty ?x)
				(not (at ?sokoban ?x)) (not (empty ?y))
				(increase(total-cost) 1)
				))

	(:action pushLeft
		:parameters (?sokoban -sokoban ?x - location ?y -location ?z -location ?box - box)
		:precondition (and 	(IsLeft ?y ?x)  					;location y is left of x
							(IsLeft ?z ?y)    					;z (destination for block) is left of where the block currently is
							(at ?sokoban ?x)   					;sokoban player is at x
							(at ?box ?y)     					;box is at y							    					
							(empty ?z))        					;and location z is empty, so push box left to z
		:effect (and (at ?sokoban ?y) (at ?box ?z) 
				(empty ?x) 
				(not (at ?sokoban ?x)) 
				(not (at ?box ?y)) 
				(not (empty ?z)) 
				(not (empty ?y))
				(increase(total-cost) 1)
				))
			   
	(:action pushRight
		:parameters (?sokoban -sokoban ?x - location ?y -location ?z -location ?box - box)
		:precondition (and 	(IsLeft ?x ?y)						;x is left of y
							(IsLeft ?y ?z)						;y is left of z
							(at ?sokoban ?x)					;sokoban is at x
							(at ?box ?y)						;box is at y
							(empty ?z))							;z is empty, so push box right to z
		:effect (and (at ?sokoban ?y) (at ?box ?z) 
				(empty ?x)
				(not (at ?sokoban ?x))
				(not (at ?box ?y))
				(not (empty ?z))
				(not (empty ?y))
				(increase(total-cost) 1)
				))

	(:action pushUp
		:parameters (?sokoban -sokoban ?x - location ?y -location ?z -location ?box - box)
		:precondition (and 	(below ?x ?y)						;x is below y
							(below ?y ?z)						;y is below z
							(at ?sokoban ?x)					;sokoban is at x
							(at ?box ?y)						;box is at y
							(empty ?z))							;z is empty, so push box up to z
		:effect (and (at ?sokoban ?y) (at ?box ?z)
				(empty ?x)
				(not (at ?sokoban ?x))
				(not (at ?box ?y))
				(not (empty ?y))
				(not (empty ?z))
				(increase(total-cost) 1)
				))


	(:action pushDown
		:parameters (?sokoban -sokoban ?x - location ?y -location ?z -location ?box - box)
		:precondition (and (below ?y ?x)						;y is below x
							(below ?z ?y)						;z is below y
							(at ?sokoban ?x)					;sokoban is at x
							(at ?box ?y)						;box is at y
							(empty ?z))							;z is empty, so push box down to z
		:effect (and (at ?sokoban ?y) (at ?box ?z)
				(empty ?x)
				(not (at ?sokoban ?x))
				(not (at ?box ?y))
				(not (empty ?y))
				(not (empty ?z))
				(increase(total-cost) 1)
				))
)