TITLE Alexis Narvaez
.286
 
;========================================================================
; DECLARACION DEL SEGMENTO DE PILA
;========================================================================
pila SEGMENT STACK ; Inicio del segmento de pila
;------------------------------------------------------------------
    DB 32 DUP('PILA') ; Inicialización de la pila
;------------------------------------------------------------------
pila ENDS ; Fin del segmento de pila
 
;========================================================================
; DECLARACION DEL SEGMENTO DE DATOS
datos SEGMENT ; Inicio del segmento de datos

    texto DB 'Texto en una varibale','$' ;Podriamos decir que funciona como
                                         ; una variable.  
    valor2 DB 'texto 2','$'              ;iniciamos la varaibale *valor2* en 1
datos ENDS ; Fin del segmento de datos
    
    ;========================================================================
    ; DECLARACION DEL SEGMENTO DE CODIGO
    ;========================================================================
    CODIGO SEGMENT 'codigo'; Inicio del segmento de código
    
    ;------------------------------------------------------------------
        main PROC FAR ; Inicio procedimiento main
    ;------------------------------------------------------------
            ASSUME CS:CODIGO,DS:datos,SS:pila ; Asignar segmentos
    ;------------------------------------------------------------
            push DS
            push 0
            MOV AX, datos   ;Cargamos lo que hay en "datos" lo colocamos en AX (registro acumulador).
            MOV DS,AX       ;Cargamos lo que tenemos en el registro acumulador (AX)
                            ; lo colocamos en el segmento de datos(DS).
            LEA DX, offset valor2  ; Colocamos en el registro de datos (DX) el datos que hay "Texto"                    
            MOV AH, 09H
            INT 21H ; Llamar a la interrupción del DOS
    ;------------------------------------------------------------
            MOV AH,4CH ; Función para terminar el programa
            INT 21H ; y volver al DOS
    ;------------------------------------------------------------
        main ENDP ; Fin del procedimiento main
    ;------------------------------------------------------------------
    
    CODIGO ENDS ; Fin del segmento código
    ;========================================================================
END main ; Empezar a ejecutar el procedimiento main
;========================================================================