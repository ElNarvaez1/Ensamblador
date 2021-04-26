.model small
.stack
.data
    ;Datos
    texto DB 'Hola mundo ','$'
.code
        Main:
        ;Codigo
        MOV AX,@data
        MOV DS,AX

        MOV CX,20  ;Numero de vueltas
        vueltas:;Nombre del ciclo
            MOV AH,09H		
	        LEA DX,texto	    
            INT 21H 
        loop vueltas

.exit
END