.model small
.stack

;---------------MACROS------------------------------
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

leerChar MACRO char
    MOV DX, OFFSET char ; Obtiene la Direccion de "VAR"
    MOV AH, 3FH        ; Funcion (Read from File or Device, Using a Handle)
    INT 21H            ; Ejecutar
ENDM

imprimirChar MACRO al
    MOV AH, 2  ;Funcion del DOS para imprimir un caracter
    MOV DL, al  ;Imprimir el primer digito
    INT 21h
ENDM

limpPantalla MACRO 
    mov ax,0600h
	mov bh,00Ah ;Color de las letras y  el fonod
	mov cx,0000h
	mov dx,184Fh
	int 10h
ENDM

posicionCurso MACRO fila,columna
    mov ah,02h
	mov bh,00
	mov dh,fila
	mov dl,columna
	int 10h
ENDM

oculatarMouse MACRO 
    mov ax,02h
	int 33h
ENDM

iniciarMouse MACRO
    mov ax,00
	int 33h //Esta es una interrupcin de DOS y ayuda a controlar el uso del mouse
ENDM

mostrarMouse MACRO
    mov ax,01h
	int 33h
ENDM


;---------------Programa------------------------------
.data
    ;Datos
    texto DB 'Ingrese cadena: ','$'
    textoIng DB 'Ingrese caracter a buscar: ','$'
    encont DB 'Vocal  ENCONSTRADA: ','$'
    noEncont DB 'Vocal no encontrada: ','$'
    noVocal DB 'letra NO aceptada: ','$'

    vocales DB 'AEIOUaeiou','$'

    op1 DB '1 - Buscar otra vocal','$'
    op2 DB '2 - Ingresar otra palabra','$'
    op3 DB '3 - Salir','$'

    cadena DB 30 DUP (' '), '$'
    vocal DB ?

.code
        Main:
        ;Codigo
        MOV AX,@data
        MOV DS,AX

        limpPantalla
        posicionCurso 0,10
        ;Imprimimos La peticion del texto
        imprimir texto     ;Imprimri textos 
        leer cadena        ;Leemos la cadena
        
        ingVocal: ;Ingresamos la vocal
            posicionCurso 1,10
            imprimir textoIng
            leerChar vocal

            ;comparamos si es una vocal o no
            MOV SI,0 ;Sirve como indice para el recorrido de la cadena  
            ciclo1:
                ;Comprobamos si no ha llegado al final de la cadena
                posicionCurso 2,10
                MOV AL,vocales[SI]
                CMP AL,vocal ;Comparamos con la vocal
                    JE vocalAceptada 
                CMP AL,'$'  ;Comprobamos que aun estamos dentro de la cadena principal
                    limpPantalla
                    JZ ingVocal ;Si llego al final entonces no existe esa vocal        
                INC SI
            JMP ciclo1 


        vocalAceptada: 
            MOV SI,0 ;Sirve como indice para el recorrido de la cadena  
            ciclo:
                ;Comprobamos si no ha llegado al final de la cadena
                posicionCurso 2,10
                MOV AL,cadena[SI]
                CMP AL,vocal ;Comparamos con la vocal
                    JE existe 
                CMP AL,'$'  ;Comprobamos que aun estamos dentro de la cadena principal
                    JZ finLinea ;Si llego al final entonces no existe esa vocal        
                INC SI
            JMP ciclo 


        finLinea:
            imprimir noEncont
            JMP continua ;;Slatamos a la linea princpal

        existe:
            imprimir encont
            JMP continua

        continua: ;Etiqueta para continuar normalmente
            ;Buscar otra vocal
            limpPantalla
            posicionCurso 0,10
            imprimir op1
            posicionCurso 1,10
            imprimir op2
            posicionCurso 2,10
            imprimir op3
            posicionCurso 3,10

        MOV AH,4CH ; Función para terminar el programa
        INT 21H ; y volver al DOS
.exit
END