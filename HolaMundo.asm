Title
.286
spila SEGMENT STACK 
	DB 32 DUP('STACK____')	;DEFINIMOS EL TAMAÑO DE LA PILA Y DUPLICAMOS EL TEXTO
spila ENDS

sdatos SEGMENT DATA
	letrero DB 'HOLA MUNDO','$' ;DB ES UN TAMAÑO DE 8 BITS = 1 BYTE,  ($) NOS MARCA QUE ESTAMOS HACIENDO UN LETRERO
sdatos ENDS

scodigo SEGMENT CODE
	Assume ss: spila, ds:sdatos, cs:scodigo ;Assume nos guarda la direccion de memoria de los segmentos (ss, ds, cs, es:sextra)

	main PROC FAR		; puede ser FAR(Se usa mas,Cuando se llamda de lejos) O NEAR(cuando es cerca, lo que se necesita esta dentro del codigo)
		push DS			; Instruccion de pila, DS guarda la direccion de retorno del SO
		push 0			;
		MOV AX,sdatos
		MOV ds,AX		;
		MOV AH,09H		;
		LEA DX,letrero		; Imprime el letrero
		INT 21H			; Interrupccion 21H 
		RET			
	main ENDP
scodigo ENDS
	END main

