TITLE Suma
.286
stack SEGMENT STACK 
	DB 32 DUP('STACK____')	;DUP: repite n veces la exprecion(32 veces en este caso)
stack ENDS

data SEGMENT
	x DB 0 ; El sigo interrogante(?) indica que reserva espacio en la memoria
	a DB 4 ; Defininos valor 4 (Guarda el valor de la poscion en el codigo ASCII)
	b DB 5 ; Definimos valor 5 (Guarda el valor de la poscion en el codigo ASCII)
data ENDS

	code SEGMENT
		Assume ss:stack,ds:data,cs:code

		main PROC FAR	; Comienza procedimiento lejano		
			push DS			
			push 0		

			;Direccionamineto del procedimiento
			MOV AX,data
			MOV DS,AX

			;MANIPULAMOS EL PRIMER NUMERO
			MOV AL,a

			;Movemos el valor a x
			MOV x,AL

			;MANIPULAMOS EL SEGUNDO NUMERO
			MOV AL,b

			;sumamos a y b
			ADD x,AL

			;MOSTRAMOS LA SUMA 
			MOV DL,x
			ADD DL,30H
			MOV AH,02
			INT 21H

			MOV AH,4CH
			INT 21H	
		main ENDP
	code ENDS
END main


_______________


