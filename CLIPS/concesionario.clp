;---------------------------------------

;Práctica 1 - Concesionario

;---------------------------------------

(defglobal 
    ?*r_precio* = 0
    ?*r_cab* = 0
    ?*r_abs* = 0
    ?*r_maletero* = "pequegno"
    ?*r_consumo* = 0
)

;----------------------------

;----------------------------

; Plantillas

;----------------------------

;Plantilla: coche
(deftemplate coche
    (slot modelo (allowed-values modelo1 modelo2 modelo3 modelo4 modelo5)
    (slot precio)
    (slot TamMaletero (allowed-values pequegno mediano grande)
    (slot NumCaballo)
    (slot ABS (allowed-values Si No)
    (slot ConLitro)
) ;deftemplate_coche

;Plantilla: usuario
(deftemplate usuario
    (slot precio(default 13000)
    (slot TamMaletero (default grande)
    (slot NumCaballo(default 80)
    (slot ABS (default Si)
    (slot ConLitro(default 8)
) ;deftemplate_usuario

;----------------------------

; Hechos iniciales

;----------------------------

(deffacts iniciales
    (coche  (modelo modelo1)
            (precio 12000)
            (TamMaletero pequegno)
            (NumCaballo 65)
            (ABS No)
            (ConLitro 4,7)
    (coche  (modelo modelo2)
            (precio 12500)
            (TamMaletero pequegno)
            (NumCaballo 80)
            (ABS Si)
            (ConLitro 4,9)
    (coche  (modelo modelo3)
            (precio 13000)
            (TamMaletero mediano)
            (NumCaballo 100)
            (ABS No)
            (ConLitro 7,8)
    (coche  (modelo modelo4)
            (precio 14000)
            (TamMaletero grande)
            (NumCaballo 125)
            (ABS No)
            (ConLitro 6,0)
    (coche  (modelo modelo5)
            (precio 15000)
            (TamMaletero pequegno)
            (NumCaballo 147)
            (ABS No)
            (ConLitro 8,5)
) ;deffacts_iniciales

;----------------------------

; Reglas

;----------------------------

(defrule cuestionario
=>
(printout t "¿Cuánto dinero quieres gastar?")
(bind ?r_precio (read)

(printout t "¿Cuántos caballos quieres?")
(bind ?r_cab (read)

(printout t "¿Quiere A.B.S. ?")
(bind ?r_abs (read)

(printout t "¿Cuál es el tamaño del maletero que deseas?")
(bind ?r_maletero (read)

(printout t "¿Cuál es el consumo máximo?")
(bind ?r_consumo (read)

;Metemos en respuesta los datos
(assert (respuesta 
    (precio ?r_precio)
    (NumCaballo ?r_cab)
    (ABS ?r_abs)
    (TamMaletero ?r_maletero)
    (ConLitro ?r_consumo) 
)
) ;defrule_cuestionario

(defrule recomendacion

   (respuesta 
        (precio ?r_precio)
        (TamMaletero ?r_maletero)
        (NumCaballo ?r_cab)
        (ABS ?r_abs)
        (ConLitro ?r_litros)
    ) 

   (coche 
        (modelo ?modelo) 
        (precio ?precio)
        (TamMaletero ?maletero)
        (NumCaballo ?caballos)
        (ABS ?ABS)
        (ConLitro ?litros)
    )
   
   (test(<= ?precio ?r_precio))
   (test(eq ?maletero ?r_male))
   (test (<= ?r_cab ?caballos))
   (test (eq ?ABS ?r_abs))
   (test (>= ?r_litros ?litros))
    =>
    (printout t "Modelo recomendado: " ?modelo crlf)
) ;defrule_recomendacion