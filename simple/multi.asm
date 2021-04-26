TITLE Alexis Narvaez
.286
 
;========================================================================
; DECLARACION DEL SEGMENTO DE PILA
;========================================================================
pila SEGMENT STACK ; Inicio del segmento de pila
;------------------------------------------------------------------
    DB 64 DUP('PILA') ; Inicialización de la pila
;------------------------------------------------------------------
pila ENDS ; Fin del segmento de pila
 
;========================================================================
; DECLARACION DEL SEGMENTO DE DATOS
datos SEGMENT ; Inicio del segmento de datos
    base DB 2   ;La variable base no guarda el valor "2" Guarda el valor de la posicion en el codigo ASCII
    multi DB 4  ;La variable multi no guarda el valor "4" Guarda el valor de la posicion en el codigo ASCII     
    result DB 0
datos ENDS ; Fin del segmento de datos
 
;========================================================================
; DECLARACION DEL SEGMENTO DE CODIGO
;========================================================================
CODIGO SEGMENT ; Inicio del segmento de código
 
;------------------------------------------------------------------
    main PROC FAR ; Inicio procedimiento main
;------------------------------------------------------------
        ASSUME CS:CODIGO,DS:datos,SS:pila ; Asignar segmentos
;------------------------------------------------------------
        push DS
        push 0

        MOV AX, datos
        MOV DS,AX

        MOV AL,base
        MOV BL,multi

        MUL BL
        ADD AL,48d

        MOV AH,02H
        MOV DL,AL

        INT 21H ; Llamar a la interrupción del DOS
;------------------------------------------------------------
        MOV AX,4CH ; Función para terminar el programa
        INT 21H ; y volver al DOS
;------------------------------------------------------------
    main ENDP ; Fin del procedimiento p1_hola
;------------------------------------------------------------------
 
CODIGO ENDS ; Fin del segmento código
;========================================================================
END main ; Empezar a ejecutar el procedimiento main
;========================================================================