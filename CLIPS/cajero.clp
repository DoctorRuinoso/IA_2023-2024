;---------------------------------------

;Práctica 2 - Cajero

;---------------------------------------

(defglobal 
    ?*ANNO* = 2023
    ?*LIMITE1* = 900
)

;----------------------------

;----------------------------

; Plantillas

;----------------------------

;Plantilla: Usuario
(deftemplate usuario
    (slot DNI)
    (slot Pin)
    (slot Dinero (default 0))
) ;deftemplate_usuario

;Plantilla: Tarjeta
(deftemplate tarjeta
    (slot Pin)
    (slot DNI)
    (slot Intentos (default 3))
    (slot Limite (default 800))
    (slot Anno (default 2030))
    (slot Validada (allowed-values Si No)(default No))
) ;deftemplate_tarjeta

;Plantilla: Cuenta
(deftemplate cuenta
    (slot DNI)
    (slot Saldo)
    (slot Estado(allowed-values enPantalla dineroEntregado Inicial SuperaLimite SinSaldo)(default Inicial))
) ;deftemplate_cuenta

;----------------------------

;----------------------------

; Hechos Iniciales

;----------------------------

(deffacts iniciales
    (tarjeta
            (DNI 123456)
            (Pin 1212)
            (Intentos 3)
            (Limite 500)
            (Anno 2026)
    )
    (tarjeta
            (DNI 456456)
            (Pin 4545)
            (Intentos 3)
            (Limite 500)
            (Anno 2026)
    )
    (tarjeta
            (DNI 000111)
            (Pin 0011)
            (Intentos 0)
            (Limite 500)
            (Anno 2026)
    )
    (cuenta
            (DNI 123456)
            (Saldo 5000)
    )
    (cuenta
            (DNI 456456)
            (Saldo 33)
    )
    (cuenta
            (DNI 000111)
            (Saldo 30000)
    )
) ;deffacts_iniciales

;----------------------------

;----------------------------

; Funciones

;----------------------------

(deffunction decrementar(?a)
        (bind ?res (- ?a 1))
        (return ?res)
) ;deffunction_decrementar

(deffunction resta(?a ?b)
        (if(< ?a ?b) then
                (bind ?res (- ?b ?a))
                (return ?res)
        else
                (bind ?res (- ?a ?b))
                (return ?res)
        )
) ;deffunction_resta

;----------------------------

; Reglas

;----------------------------

(defrule supera_intentos
        (tarjeta (Intentos ?int))
) ;defrule_supera_intentos