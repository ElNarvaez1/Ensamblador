;---------------------------------------------------------------
;FILE: SOUND.ASM                                            
;Programa que origina un sonido en la bocina del  Pc         
;---------------------------------------------------------------

.MODEL SMALL          ;Directiva, define el tamaño en memoria   
.STACK                ;Asigana tamaño al segmento de Pila
.DATA                 ;Reserva un espacio para DS
.CODE

INICIO:               ;Define etiqueta de inicio
       MOV AX,@DATA   ;Referencia al registro de datos
       MOV DS,AX      ;Pasa de AX a DS 
	   
		mov ax, (1193180 / 440)
		out 42h, al
		mov al, ah
		out 42h, al 


	  IN AL,61H      ;Direccion de la bocina   IN: leer informacion
	  OR AL,3D       
	  OUT 61H,AL     ;OUT:enviar informacion al Puerto
	  MOV CX,9999H   ;Duracion de la Emision de sonido
    C1:
	  LOOP C1
	  IN AL,61H
	  AND AL,0FCH
	  OUT 61H,AL

       MOV AH,4CH     ;Interrupcion, devuelve el control al usuario
       INT 21H        ;Int. del sistema

END INICIO            ;Fin etiqueta