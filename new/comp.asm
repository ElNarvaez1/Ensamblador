.model small
.stack

imprimir MACRO texto
    ;Desplegamos el texto del texto
     MOV AH, 09H
     LEA DX,texto
     INT 21H 
ENDM

leer MACRO string
    MOV AH, 3FH
	MOV BX, 00
	MOV CX, LENGTHOF string  ;;TAMAÑO MAXIMO DE NUESTRA CADENA
	MOV DX, OFFSET[string]    ;;OFFSET NOS DA EL DESPLAZAMIENTO D DATOS DESDE INCIO DEL SEGMENTO HASTA DONDE SE ENCUENTRA LA CADENA
	INT 21H
ENDM

.data
    ;Datos
    ing DB 'Ingrese Texto','$'
    texto1 DB '20 dup(?)','$'
    texto2 DB 20 dup(?),'$'

    igualCad DB 'iguales', '$'
    noIgualCad DB 'No iguales','$'

    temp1 DB 'valor','$'
    temp2 DB 'valor','$'
.code
        Main:
        ;Codigo
        MOV AX,@data
        MOV DS,AX   
        ;;;--------Aqui inicia el codigo chido
        CLD  
        mov AX,DS
        mov ES,AX
		MOV CX, LENGTHOF temp1
        lea di,temp2 
        lea si,temp1  
        REPE CMPSB  
        JNE diferente1 
        iguales:
            imprimir igualCad
            JMP continua
        diferente1:
            imprimir noIgualCad
            JMP continua
        continua:
        ;;-------------Aqui termina el codigo chido

.exit
END