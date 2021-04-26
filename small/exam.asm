TITLE Alexis Narvaez Examen
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
    texto db 10,13,7, 'Ingrese un numero 0-9 ','$'
    textoI db 10,13,7, 'Son iguales ','$'
    textoD db 10,13,7, 'Este es el mayor ','$'

    menu1 db 10,13,7, 'Desea ingresar numeros? --> 1 ','$'
    menu2 db 10,13,7, 'Desea salir --> 2 ','$'
    restp db ?  ;Respuesta del menu  


    num1 db ?
    num2 db ?
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

        inicio:
                ;Desplegamos el texto del menu1
                MOV AH, 09H
                LEA DX,menu1
                INT 21H  
                ;Desplegamos el texto del menu2
                MOV AH, 09H
                LEA DX,menu2
                INT 21H
                ;Leemos la respuesta
                MOV AH,01H
                INT 21H
                SUB AL,48D
                MOV restp,AL

                ;Comparamos la respuesta 
                MOV AL,restp ;->5 
                CMP AL,1D ;->3
                ;Saltos para la condicion
                JZ aceptar
                ;JC cancelar
                JNZ cancelar
                aceptar: 
                         ;----------------------------------------------------------
                        ;Desplegamos el texto
                        MOV AH, 09H
                        LEA DX,texto
                        INT 21H

                        ;Guardamos el primer numero
                        MOV AH,01H
                        INT 21H
                        SUB AL,48D
                        MOV num1,AL

                        ;Desplegamos el texto
                        MOV AH, 09H
                        LEA DX,texto
                        INT 21H

                        ;Guardamos el segundo numero
                        MOV AH,01H
                        INT 21H
                        SUB AL,48D
                        MOV num2,AL
                        
                         MOV AH, 09H       
                        ;Al aun contiene el segundo valor
                        ;Inicio de la condicion.
                        
                        MOV AL,num1 ;->5 
                        CMP AL,num2 ;->3
                        ;Saltos para la condicion
                        JZ iguales
                        JC segundo
                        JNZ primero

                        ;Lugares donde caera el salto.
                        iguales:
                                		
                                LEA DX,textoI		
                                INT 21H
                                JMP inicio
                        primero:  
		
                                LEA DX,textoD
                                INT 21H

                                MOV AH,02H
                                MOV DL,num1
                                ADD DL,48D
                                INT 21H
                                JMP inicio
                        segundo: 
		
                                LEA DX,textoD
                                INT 21H

                                MOV AH,02H
                                MOV DL,num2
                                ADD DL,48D
                                INT 21H
                                JMP inicio
                        ;----------------------------------------------------------
                cancelar:


       


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