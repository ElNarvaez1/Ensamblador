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

leerChar2 MACRO variable
    mov ah,0ah
    mov dx,offset variable
    int 21h
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
	int 33h 
ENDM

mostrarMouse MACRO
    mov ax,01h
	int 33h
ENDM

modoVideo MACRO

ENDM
;---------------Programa------------------------------
.data
    ;Datos
    texto DB 'Ingrese cadena: ','$'
    textoIng DB 'Ingrese caracter a buscar: ','$'
    encont DB 'Letra  ENCONSTRADA: ','$'
    noEncont DB 'letra no encontrada: ','$'

    op1 DB '1 - Buscar otra vocal','$'
    op2 DB '2 - Ingresar otra palabra','$'
    op3 DB '3 - Salir','$'
    
    sumaText DB '1 -  suma','$'
    resta DB '2 - resta','$'
    cadenaOP DB '3 - Cadenas','$'
    vocalEsc DB '4 - Escaneo','$'
    salir DB '5 - Salir','$'

    textNum1 DB 'numero UNO: ','$'
    textNum2 DB 'numero DOS: ','$'
    resultNum DB 'La suma es: ','$'
    tituloSuma DB 'SUMA','$'

    numS1 DB ?
    numS2 DB ?
    resultS DB ?

    cadena DB 30 DUP (' '), '$'
    cadena2 DB 30 DUP (' '), '$'
    igualCad DB 'Son iguales', '$'
    noIgualCad DB 'No son iguales', '$'
    vocal DB ?
    posicion DB ?
    basura DB ?

    clik DB ?
    filaEvento DB ?
    columnaEvento DB ? 

    rango DB ?

.code
        Main:
        ;Codigo
        MOV AX,@data
        MOV DS,AX

        limpPantalla
        posicionCurso 0,10

        imprimir sumaText
        posicionCurso 1,10
        imprimir resta

        posicionCurso 2,10
        imprimir cadenaOP

        posicionCurso 3,10
        imprimir vocalEsc

        posicionCurso 4,10
        imprimir salir

        iniciarMouse
        mostrarMouse

        escucha: 
            ;mov click,bx;

            mov ax, dx
            mov bl,8
            div bl
            mov filaEvento,al

            mov ax, cx
            mov bl,8
            div bl
            mov columnaEvento,al
            
            mov ax,03h
            int 33h 
            CMP bx,1 ;Clicik izquierdo se sale
                JE steps
                JMP escucha
        ;Detectar click 

        steps: 
            CMP columnaEvento,10
                JGE menorA;Mayor o igual que                 
                JMP escucha
        menorA:
            CMP columnaEvento,22
                JLE evaFila;menor que 
                JMP escucha

        evaFila:
            CMP filaEvento,0 ;suma
                JE sumaTag 
            CMP filaEvento,1 ;resta
                JE restaTag
            CMP filaEvento,2 ;cadenas comp
                JE palabrasTag
            CMP filaEvento,3 ;Vocal
                JE vocalTag
            CMP filaEvento,4 ;sali
                JE salirTag    
                JMP escucha
                ;limpPantalla
           
        ;....................Vocal--------------------------------------------
        vocalTag:
            oculatarMouse
            limpPantalla
            limpPantalla
            posicionCurso 0,10
            ;Imprimimos La peticion del texto
            imprimir texto      
            leer cadena       
            
            posicionCurso 1,10
            imprimir textoIng
            leerChar vocal
            
            CLD 
			MOV DI, OFFSET cadena
			MOV AL, vocal
			MOV CX, LENGTHOF cadena

            MOV posicion,1 ;SI le opngo cero 
			repeticion:
				SCASB 
				JE existe
                INC posicion
			LOOP repeticion 

            contadores:
   
                JMP ciclo 

        finLinea:
            imprimir noEncont
            JMP continua 

        existe:
            imprimir encont
            ADD posicion,48D;
            ;MOV posicion,AL
            imprimirChar posicion
            JMP continua
        ;----------------------Suma----------------------------
        sumaTag:
            oculatarMouse  
            posicionCurso 6,10
            imprimir textNum1
            leerChar numS1

            posicionCurso 7,10
            imprimir textNum2
            leerChar numS2

            MOV AL,numS1   
            ADD AL, numS2

            SUB AL,48D;
            MOV resultS,AL

            posicionCurso 8,10
            imprimir resultNum
            imprimirChar resultS
            
            CMP resultS,0
            JGE continua

            ;JMP continua 
        ;--------------------Resta---------------
        restaTag:
            oculatarMouse  
            posicionCurso 9,10
            imprimir textNum1
            leerChar numS1

            posicionCurso 10,10
            imprimir textNum2
            leerChar numS2

            MOV AL,numS2
            CMP numS1,AL 
                JLE dosM  ;num1>=num2
                MOV AL,numS1   
                SUB AL, numS2
            JMP opM

            dosM:

                MOV AL,numS2   
                SUB AL, numS1
           
            opM:
            ADD AL,48D;
            MOV resultS,AL

            posicionCurso 11,10
            imprimir resultNum
            imprimirChar resultS
            
            CMP resultS,0
            JGE continua
        ;------------Palabras---------------
        palabrasTag:
            oculatarMouse
            limpPantalla
            posicionCurso 0,10
            
            imprimir texto
            leer cadena

            posicionCurso 1,10
            imprimir texto
            leer cadena2    
            
            CLD  
            mov AX,DS
            mov ES,AX
            MOV CX, LENGTHOF cadena
            lea di,cadena2 
            lea si,cadena  
            REPE CMPSB  
            JE pares
            JNE diferente1 

            pares:    
                imprimir igualCad
                JMP continua
            diferente1:
                imprimir noIgualCad
                JMP continua
            
        continua: 
            leerChar basura
            limpPantalla
            JMP Main

        salirTag:
            limpPantalla
            posicionCurso 0,0
        MOV AH,4CH ; Función para terminar el programa
        INT 21H ; y volver al DOS
.exit
END