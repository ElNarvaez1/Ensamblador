;;Alexis Narvaez Ruiz 
.model small
.stack
;;--------------Zona de macors------------------
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
        MOV ah,01h
        INT 21h
        MOV char,AL

        ;MOV DX, OFFSET char ; Obtiene la Direccion de "VAR"
        ;MOV AH, 3FH        ; Funcion (Read from File or Device, Using a Handle)
        ;INT 21H            ; Ejecutar
    ENDM

    leerChar2 MACRO variable
        mov ah,0ah
        mov dx,offset variable
        int 21h
    ENDM

    imprimirChar MACRO char
        MOV AH, 2  ;Funcion del DOS para imprimir un caracter
        MOV DL, char  ;Imprimir el primer digito
        INT 21h
    ENDM

    imprimirChar2 MACRO char
        MOV AH, 02h  ;Funcion del DOS para imprimir un caracter
        MOV DL, char  ;Imprimir el primer digito
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
    clickPant MACRO filaEvento,columnaEvento 
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
    ENDM

.data
    ;Datos
    ;texto DB 'Hola mundo pequeño','$'
    
    ;-----------Variables del menu-------------------
    sumaText DB '1 - SUMA','$'
    restaText DB '2 - RESTA','$'
    cadenasText DB '3 - COMPARAR CADENAS','$'
    escanerText DB '4 - ESCANEAR','$'
    salirText DB '5 - SALIR','$'

    ;;------------------Variables SUMA Y REST--------------------------------------
    sumaTitutlo DB 'SUMA: ','$'
    restaTitutlo DB 'RESTA: ','$'
    num1Text DB 'Ingrese numero UNO: ','$'
    num2Text DB 'Ingrese numero DOS: ','$'
    resultNum DB 'Resultado es: ','$'
    num1 DB ?
    num2 DB ?
    numRes DB ?

    ;;----------------Variables de comparacion de cadenas----------------------------------
    stringTitulo DB 'COMPARACON: ','$'
    stringTitulo2 DB 'ESCANEO: ','$'
    stringText DB 'Ingrese cadena: ','$'
    stringLetra DB 'Ingrese la letra : ','$'
    stringIgual DB 'Letra encontrada en: ','$'
    stringNoIgual DB 'Letra NO encontrada ','$'

    srtg DB 'Iguales','$'
    srtg2 DB 'NO Iguales','$'

    cadena DB 30 DUP (' '), '$'
    cadena2 DB 30 DUP (' '), '$' 
    letra DB ?
    posicion DB ?

    ;;---------Variables de Opcion---------------------------------
    filaEvento DB ?
    columnaEvento DB ?

    basura DB ?




.code
        Main:
        ;Codigo
        MOV AX,@data
        MOV DS,AX

            
        inicio:
            limpPantalla
            
            posicionCurso 0,10
            imprimir sumaText
            
            posicionCurso 1,10
            imprimir restaText
            
            posicionCurso 2,10
            imprimir cadenasText
            
            posicionCurso 3,10
            imprimir escanerText

            posicionCurso 4,10
            imprimir salirText

        ;;-------------------------ESCUCHA--------------------------------------------
        ;;-------MOUSE --------
            iniciarMouse
            mostrarMouse

        escucha: 
            ;mov click,bx;
            clickPant filaEvento,columnaEvento
           
            CMP bx,1 ;Clicik izquierdo se sale
                JE steps
                JMP escucha 

        steps: 
            CMP columnaEvento,10
                JGE menorA;Mayor o igual que                 
                JMP escucha
        menorA:
            CMP columnaEvento,35
                JLE evaFila;menor que 
                JMP escucha

        evaFila:
            CMP filaEvento,0 ;suma
                JE suma 
            CMP filaEvento,1 ;resta
                JE resta
            CMP filaEvento,2 ;cadenas comp
                JE cadenas
            CMP filaEvento,3 ;Vocal
                JE escaner
            CMP filaEvento,4 ;sali
                JE salir    
                JMP escucha
                ;limpPantalla

        ;;------------------------SUMA--------------------------------------------------
        suma: ;{
            limpPantalla
            posicionCurso 0,10
            imprimir sumaTitutlo

            posicionCurso 1,10
            imprimir num1Text
            leer num1

            posicionCurso 2,10
            imprimir num2Text
            leer num2

            MOV AL,num1   
            ADD AL, num2

            SUB AL,48D;
            MOV numRes,AL

            posicionCurso 3,10
            imprimir resultNum
            imprimirChar numRes

            JMP continua
        ;}  


        ;;------------------------RESTA--------------------------------------------------
        resta: ;{
            limpPantalla
            posicionCurso 0,10
            imprimir restaTitutlo

            posicionCurso 1,10
            imprimir num1Text
            leer num1

            posicionCurso 2,10
            imprimir num2Text
            leer num2

            MOV AL,num1
            ;;----Zona de evaluacion
            CMP AL,num2
                JLE segundo  ;num1<=num2
                JMP mainResta
            segundo:
                MOV numRes, AL
                MOV AL,num2
                MOV num1,AL
                MOV AL,numRes
                MOV num2,AL
                JMP mainResta    
            
            mainResta:
                MOV AL,num1
                SUB AL,num2
                MOV numRes,AL
            
            ADD AL,48D;
            MOV numRes,AL

            posicionCurso 3,10
            imprimir resultNum
            imprimirChar numRes
                
            JMP continua
        ;} 
        
        ;;------------------------CADENAS--------------------------------------------------
        cadenas: ;{
            limpPantalla
            posicionCurso 0,10
            imprimir stringTitulo
            ;;----Cadena 1
            posicionCurso 1,10
            imprimir stringText
            leer cadena

            posicionCurso 2,10
            imprimir stringText
            leer cadena2

            CLD  
            mov AX,DS
            mov ES,AX
            MOV CX, LENGTHOF cadena
            lea di,cadena2 
            lea si,cadena  
            REPE CMPSB  
            JE igualesString
            JNE diferente1 

            posicionCurso 3,10
            igualesString:    
                imprimir srtg
                JMP continua
            diferente1:
                imprimir srtg2
                JMP continua

            JMP continua
        ;}
        ;;------------------------ESCANER--------------------------------------------------
        escaner: ;{
            limpPantalla
            posicionCurso 0,10
            imprimir stringTitulo2

            posicionCurso 1,10
            imprimir stringText
            leer cadena

            posicionCurso 2,10
            imprimir stringLetra
            leerChar letra

            CLD 
            mov AX,DS
            mov ES,AX
			MOV DI, OFFSET cadena
			MOV AL, letra
			MOV CX, LENGTHOF cadena
           
            MOV posicion,1 

            inicioCiclo:
				SCASB 
				JE encontrado ;;SI ENCUENTRA EL CARACTER EN LA CADENA
                INC posicion
            LOOP inicioCiclo ;;SI NO  ENCUENTRA EL CARACTER EN LA CADENA SIGUE CON EL CICLO Y DA EL SALTO A NOENCONTRADO
			JMP noEncontrado ;;

            encontrado:
                MOV AL,posicion
                ADD AL,48D
                MOV posicion,AL

                posicionCurso 3,10
                imprimir stringIgual
                imprimirChar posicion
                JMP continua
            noEncontrado:
                posicionCurso 3,10
                imprimir stringNoIgual
                JMP continua
            JMP continua
        ;}

        continua: ;{
            oculatarMouse
            leer basura
            JMP inicio
        ;}

        salir:
            oculatarMouse

        MOV AH,4CH
		INT 21H	
.exit
END