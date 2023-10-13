;---------------------------------------

;Práctica 1 - Mapa

;---------------------------------------

;Mapa otorgado:

;-----------¬
;   A B C   |
;-----------|
;   D E F   |
;-----------|
;   G H I   |
;------------

;----------------------------

; Hechos iniciales

;----------------------------

(deffacts iniciales
    (ubicacion A Norte D)
    (ubicacion A Oeste B)
    (ubicacion B Norte E)
    (ubicacion B Oeste C)
    (ubicacion C Norte F)
    (ubicacion D Norte G)
    (ubicacion D Oeste E)
    (ubicacion E Norte H)
    (ubicacion E Oeste F)
    (ubicacion F Norte I)
    (ubicacion G Oeste H)
    (ubicacion H Oeste I)
)

;----------------------------

; Reglas

;----------------------------

(defrule sur
    (ubicacion ?x Norte ?y)
    =>
    (assert(ubicacion ?y Sur ?x))
)

(defrule este
    (ubicacion ?x Oeste ?y)
    =>
    (assert(ubicacion ?y Este ?x))
)

(defrule transitividad_norte
    ((ubicacion ?x Norte ?y)
    (ubicacion ?y Norte ?z))
    =>
    (assert(ubicacion ?x Norte ?z))
)

(defrule transitividad_sur
    ((ubicacion ?x Sur ?y)
    (ubicacion ?y Sur ?z))
    =>
    (assert(ubicacion ?x Sur ?z))
)

(defrule transitividad_este
    ((ubicacion ?x Este ?y)
    (ubicacion ?y Este ?z))
    =>
    (assert(ubicacion ?x Este ?z))
)

(defrule transitividad_oeste
    ((ubicacion ?x Oeste ?y)
    (ubicacion ?y Oeste ?z))
    =>
    (assert(ubicacion ?x Oeste ?z))
)

(defrule noroeste
    ((ubicacion ?z Norte ?y)
    (ubicacion ?z Este ?x))
    =>
    (assert(ubicacion ?x Noroeste ?y))
)

(defrule noreste
    ((ubicacion ?z Norte ?y)
    (ubicacion ?z Oeste ?x))
    =>
    (assert(ubicacion ?x Noreste ?y))
)

(defrule suroeste
    ((ubicacion ?z Sur ?y)
    (ubicacion ?z Este ?x))
    =>
    (assert(ubicacion ?x Suroeste ?y))
)

(defrule sureste
    ((ubicacion ?z Sur ?y)
    (ubicacion ?z Oeste ?x))
    =>
    (assert(ubicacion ?x Sureste ?y))
)

(defrule inicio
    ?f1 <-(situacion ?x ?y)
    (ubicacion ?x ?u ?y)
    =>
    (printout t ?x " esta al " ?u " de " ?y crlf)
    (retract ?f1)
);; inicio
