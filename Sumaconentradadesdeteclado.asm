TITLE Suma
.286
stack SEGMENT STACK 
	DB 32 DUP('STACK____')	;DUP: repite n veces la exprecion(32 veces en este caso)
stack ENDS

data SEGMENT
	x DB ? ; El sigo interrogante(?) indica que reserva espacio en la memoria
	a DB 3 ; Defininos valor 3
	b DB 5 ; Definimos valor 5

	numero1 db 0
	numero2 db 0
	suma db 0

	msjn1 db 10,13, "Ingrese el 1ER numero= ",'$';ingrese n1
	msjn2 db 10,13, "Ingrese el 2DO numero= ",'$';ingrese n2

	msjnS db 10,13, "La suma es= ",'$';mensaje para mostrar los resultados
data ENDS

code SEGMENT
	Assume ss:stack,ds:data,cs:code

main PROC FAR	; Comienza procedimiento lejano		
	PUSH DS			
	PUSH 0		

	;direccionamiento del procedimiento
	MOV AX, data
	MOV DS, AX

	;solicitamos desde teclado el numero1
	MOV AH, 09		;peticion para desplegar, la funcion 09h despliega una cadena en el area de datos, utiliza LEA para cargar la direccion de cadena
	LEA DX,msjn1	;cargar la dirrecion  de cadena en DX; la operacion despliega los caracteres de izquierda a derecha
	INT 21H			;Despiliega el mensaje llamando al DOS

	MOV AH,01		;peticion para leer caracter desde teclado
	INT 21H			;

	SUB AL,30H		;Operacion Resta AL = AL - 30H
	MOV numero1,AL	;Movemos el valor del registro AL a la variable numero2(numero2 = AL)

	;solicitamos desde teclado el numero2
	MOV AH, 09		;peticion para desplegar, la funcion 09h despliega una cadena en el area de datos, utiliza LEA para cargar la direccion de cadena
	LEA DX,msjn2	;cargar la dirrecion  de cadena en DX; la operacion despliega los caracteres de izquierda a derecha
	INT 21H			;

	MOV AH,01		;peticion para leer caracter desde teclado
	INT 21H			;

	SUB AL,30H		;Operacion Resta AL = AL - 30H
	MOV numero2,AL	;Movemos el valor del registro AL a la variable numero2(numero2 = AL)

	;Operacion suma
	MOV AL,numero1	;Movemos el valor de numero1 al registro AL(AL = numero1)
	ADD AL,numero2	;Operacion suma AL = AL + numero2
	MOV suma,AL 	;Movemos el valor del registro AL a la variable suma(suma = AL)

	;mostramos resultado de la suma
	MOV AH,09		;peticion para desplegar
	LEA DX,msjnS	;cargar la dirrecion  de la indicacion
	INT 21H

	MOV DL,Suma 	;Movemos el valor de suma al registro DL(DL = suma)
	ADD DL,30H
	MOV AH,02		;Indica la operacion que coloca al cursor, se carga el numero de pagina o pantalla, y la fila y columna en que se colocara
	INT 21H

	MOV AH,4CH		;indica terminacion del programa 
	INT 21H			
main ENDP
code ENDS
	END main