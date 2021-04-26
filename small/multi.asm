.model small
.stack
.data
    ;Datos
    texto DB 'Hola mundo pequeño','$'
    valor1 DB 1
    valor2 DB 4
    resultado DB 0
.code
        Main:
        ;Codigo
        MOV AX,@data
        MOV DS,AX

        ;Necesitamos restar 48d para que lo represente el valor en 
        ; el codigo ASCII corectamente
        MOV AL, valor1
        ;SUB AL,30h
        MOV valor1,AL
        
        ;Movemos el valor de "Valor2" a AL - para realizar el ajuste
        MOV AL,valor2
        ;SUB AL,30h
        MOV valor2,AL
        
        MOV AL, valor1
        MOV BL,valor2

        MUL BL
        ADD AL,30h
        MOV resultado,AL

        MOV AH,02H
        MOV DL,resultado

        INT 21H 
.exit
END