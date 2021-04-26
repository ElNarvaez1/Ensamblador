.model small
.stack
.data
    ;Datos
    texto DB 'Hola mundo pequeño','$'
.code
        Main:
        ;Codigo
        MOV AX,@data
        MOV DS,AX

        ; 440Hz sound
        mov al, 86h
        out 43h, al
        mov ax, (1193180 / 440)
        out 42h, al
        mov al, ah
        out 42h, al 

        IN AL,61H      ;Direccion de la bocina   IN: leer informacion
        OR AL,3D       
        OUT 61H,AL     ;OUT:enviar informacion al Puerto
	  
        MOV CX,999999H   ;Duracion de la Emision de sonido
        C1:  LOOP C1  ;el progrma debe  pararse ese determinado tiempo 

        IN AL,61H
	    AND AL,0FCH
	    OUT 61H,AL

        ;INT 21H ; Llamar a la interrupción del DOS
        MOV AH,4CH ; Función para terminar el programa
        INT 21H ; y volver al DOS  
.exit
END