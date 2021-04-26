TITLE Suma
.286
stack SEGMENT STACK 
	DB 32 DUP('STACK____')	;DUP: repite n veces la exprecion(32 veces en este caso)
stack ENDS

data SEGMENT
	x DB ? ; El sigo interrogante(?) indica que reserva espacio en la memoria
	a DB 4 ; Defininos valor 3
	b DB 5 ; Definimos valor 5
data ENDS

code SEGMENT
	Assume ss:stack,ds:data,cs:code

main PROC FAR	; Comienza procedimiento lejano		
	push DS			
	push 0		

	;Operacion a realizar (a+b)-(b+a)

	;Direccionamineto del procedimiento
	MOV AX,data
	MOV DS,AX

	;---------------- Primera Parte(a+b) -------------
	;MANIPULAMOS EL PRIMER NUMERO
	MOV AL,a
	ADD AL,b
	;Movemos el valor a x
	MOV x,AL

	;---------------- Segunda Parte(b+a) -------------
	;MANIPULAMOS EL PRIMER NUMERO
	MOV AL,b
	ADD AL,a

	;---------------- Tercera Parte(a+b)-(b+a) -------------
	SUB x,AL

	;MOSTRAMOS el resultado
	MOV DL,x
	ADD DL,30H
	MOV AH,02
	INT 21H

	MOV AH,4CH
	INT 21H	
main ENDP
code ENDS
	END main