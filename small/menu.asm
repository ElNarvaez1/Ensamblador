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
    menuT DB 10,13,7,  'Menu','$'
    menu1 DB 10,13,7,  '1. Sumar','$'
    menu2 DB 10,13,7,  '2. Restar','$'
    menu3 DB 10,13,7,  '3. Salir','$'

    valorX DB ? 
    valorY DB ? 

datos ENDS ; Fin del segmento de datos
 
imprimir MACRO texto
    ;Desplegamos el texto del texto
     MOV AH, 09H
     LEA DX,texto
     INT 21H  
ENDM 

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
 
        MOV AX,datos
        MOV DS,AX

        MOV AX,0600H
        MOV BH,89H
        MOV CX,0000H
        MOV DX,184FH
        INT 10H

        imprimir menuT;Imprimimos el encabezado y el resto de partes
        imprimir menu1
        imprimir menu2
        imprimir menu3



;----Codigo
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