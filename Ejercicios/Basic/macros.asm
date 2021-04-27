;---Imprimir algo
imprTexto MACRO texto
        ;Desplegamos el texto del parametro texto
        MOV AH, 09H
        LEA DX,texto
        INT 21H 
ENDM

;---Leer una cadena de texto de longitud variable
leerCadena MACRO string
        MOV AH, 3FH
        MOV BX, 00
        MOV CX, LENGTHOF string  ;;TAMAÑO MAXIMO DE NUESTRA CADENA
        MOV DX, OFFSET[string]    ;;OFFSET NOS DA EL DESPLAZAMIENTO D DATOS DESDE INCIO DEL SEGMENTO HASTA DONDE SE ENCUENTRA LA CADENA
        INT 21H
ENDM

;--- Leer un solo caracter
leerChar MACRO char
        MOV ah,01h
        INT 21h
        MOV char,AL
        ;MOV DX, OFFSET char ; Obtiene la Direccion de "VAR"
        ;MOV AH, 3FH        ; Funcion (Read from File or Device, Using a Handle)
        ;INT 21H            ; Ejecutar
ENDM

;--- Imprimir un caracyter en pantalla
imprChar MACRO char
        MOV AH, 2  ;Funcion del DOS para imprimir un caracter
        MOV DL, char  ;Imprimir el primer digito
        INT 21h
ENDM

;---Limpia la consola de ensamblador
limpConsola MACRO 
        mov ax,0600h
        mov bh,00Ah ;Color de las letras y  el fonod
        mov cx,0000h
        mov dx,184Fh
        int 10h
ENDM



