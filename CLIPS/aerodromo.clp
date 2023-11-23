;---------------------------------------

;Práctica 3 - Aerodromo

;---------------------------------------

;----------------------------

; Plantillas

;----------------------------

;Plantilla: Aeronave
(deftemplate aeronave
    (slot identificador)
    (slot company)
    (slot aerodromo_origen)
    (slot aerodromo_destino)
    (slot velocidad_actual)
    (slot peticion (allowed-values Ninguna Despegue Aterrizaje Emergencia Rumbo))
    (slot estado_actual (allowed-values enTierra Ascenso Crucero Descenso) (default enTierra))
) ;deftemplate_aeronave

;Plantilla: Aerodromo
(deftemplate aerodromo
    (slot identificador)
    (slot ciudad)
    (slot estado_radar (allowed-values ON OFF))
    (slot radio_visibilidad)    ;kms
    (slot velocidad_viento)     ;km/h
) ;deftemplate_aerodromo

;Plantilla: Piloto
(deftemplate piloto
    (slot identificador)
    (slot avion_asignado)
    (slot estado (allowed-values OK SOS Ejecutando Stand-by)(default Stand-by))
) ;deftemplate_piloto

;Plantilla: Vuelo
(deftemplate vuelo
    (slot origen)
    (slot destino)
    (slot distancia)
    (slot velocidad_despegue (default 240))
    (slot velocidad_crucero (default 700))
) ;deftemplate_vuelo

;----------------------------

; Funciones

;----------------------------

;Función: Tiempo estimado
(deffunction tiempo_estimado (?distancia ?velocidad)
    (bind ?distancia (div ?distancia ?velocidad))
    (integer ?distancia)
    (return ?distancia)
) ;deffunction_tiempo_estimado

;----------------------------

; Reglas

;----------------------------

;Regla: Despegar
(defrule despegar
    ?v <- (vuelo (origen ?vorigen)(destino ?vdestino)(velocidad_despegue ?vdespegue))
    ?av <-(aeronave (identificador ?av_id)(aerodromo_origen ?vorigen)(aerodromo_destino ?vdestino)(estado_actual enTierra))
    ?p <- (piloto (avion_asignado ?p_avion)(estado OK))
    ?ae <-(aerodromo (identificador ?ae_id)(estado_radar ON)(radio_visibilidad ?ae_visi)(velocidad_viento ?ae_viento))

    (test (> ?ae_visi 5))
    (test (< ?ae_viento 75))
    =>
    (modify ?av (estado_actual Ascenso)(velocidad_actual ?vdespegue)(peticion Ninguna))
    (modify ?p(estado Ejecutando))
) ;defrule_despegar

;Regla: Excepción
(defrule excepcion
    ?p <- (piloto (avion_asignado ?p_av)(estado ?p_estado))
    ?av <- (aeronave (identificador ?av_id)(aerodromo_origen ?av_origen)(aerodromo_destino ?av_destino)(peticion Despegue)
        (company ?av_company))
=>
    (modify ?av (peticion Emergencia))
    (printout t "El piloto de la aeronave "?p_av " de la compañia "?av_company "no se encuentra disponible para iniciar el despegue
    desde el aerodromo" ?av_origen " con destino " ?av_destino crlf)
) ;defrule excepcion

;Regla: Crucero
(defrule Crucero
    ?p <- (piloto (avion_asignado ?p_av))
    ?av <- (aeronave (identificador ?av_id)(estado_actual Ascenso)(peticion Despegue)(aerodromo_origen ?ae_origen)
        (aerodromo_destino ?ae_destino))
    ?v <- (vuelo (velocidad_crucero ?v_crucero)(origen ?ae_origen)(destino ?ae_destino)(distancia ?v_distancia))    
    =>
    (modify ?av(velocidad_actual ?v_crucero))
    (modify ?p(estado Stand-by))
    (printout t "El tiempo estimado es de: "(tiempo_estimado ?v_distancia ?v_crucero) crlf)  
) ;defrule_crucero
