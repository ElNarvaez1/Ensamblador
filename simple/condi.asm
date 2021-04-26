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
        igual DB 'Son iguales ','$'
        mayorO DB 'El orgen es mayor ','$'
        mayorDes DB 'El destino es mayor ','$'
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
 
        MOV AX,datos
        MOV DS,AX
        ;----Codigo
        ;JZ cuando los datos (destino,origen) son iguales.
        ;JC cuando el destino es mayor que el origen
        ;JNZ cuando el origen es mayor que el destino

        MOV al,6
        CMP al,4
        JZ iguales
        JC destino
        JNZ origen

        iguales:
                MOV AH,09H		
                LEA DX,igual		
                INT 21H
                JMP continua

        destino:
                MOV AH,09H		
                LEA DX,mayorDes		
                INT 21H
                JMP continua
        origen:
                MOV AH,09H		
                LEA DX,mayorO		
                INT 21H      
        
        continua:        

        ;INT 21H ; Llamar a la interrupción del DOS
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