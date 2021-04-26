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
    precio DB 2 ;Relament no vale "2" vale la posicion en el codigo ASCII
    monto DB 7  ;Relament no vale "7" vale la posicion en el codigo ASCII
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

        MOV AX ,datos ;Movemos lo que hay en datos a AX
        MOV DS,AX     ;Lo que hay en AX lo pasamos al segmento de datos.

        MOV AL, precio ;Movemos a AL en valor de precio AL = precio
        ADD AL,monto 
        ADD AL, 48d 

        MOV AH,02H
        MOV DL,AL

        ;ADD DL,48d ;Para visualizar el valor (Por que te regresa el valor del codigo ASCII)
                    ;48 en adelante son los numeros 

        INT 21H ; Llamar a la interrupción del DOS
;------------------------------------------------------------
        MOV AH,4CH ; Función para terminar el programa
        INT 21H ; y volver al DOS
;------------------------------------------------------------
    main ENDP ; Fin del procedimiento p1_hola
;------------------------------------------------------------------
 
CODIGO ENDS ; Fin del segmento código
;========================================================================
END main ; Empezar a ejecutar el procedimiento main
;========================================================================