.model small
.stack
.data
    ;Datos
    texto DB 'Son iguales','$'
    texto1 DB 'El primero es Mayor','$'
    texto2 DB 'El segundo es Mayor','$'
    valor1 DB 6
    valor2 DB 7

.code
        Main:
        ;Codigo
        MOV AX,@data
        MOV DS,AX

        ;Inicio de la condicion.
            ;JZ cuando los datos (destino,origen) son iguales.
            ;JC cuando el destino es menor que el origen
            ;JNZ cuando el origen es mayor que el destino
        MOV AL,valor1
        CMP AL,valor2
        ;Saltos para la condicion
        JZ iguales
        JC destino
        JNZ origen

        ;Lugares donde caera el salto.
        iguales:
                MOV AH,09H		
                LEA DX,texto		
                INT 21H
                JMP continua
        destino:
                MOV AH,09H		
                LEA DX,texto2		
                INT 21H
                JMP continua
        origen:
                MOV AH,09H		
                LEA DX,texto1		
                INT 21H      
        
        continua:

.exit
END   