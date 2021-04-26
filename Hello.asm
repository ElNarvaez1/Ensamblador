Title
.286
spila SEGMENT STACK 
	DB 32 DUP('STACK____')	
spila ENDS
sdatos SEGMENT
	letrero DB 'HOLA MUNDO','$'
sdatos ENDS
scodigo SEGMENT
	Assume ss:spila,ds:sdatos,cs:scodigo

main PROC FAR			
	push DS			
	push 0			
	MOV AX,sdatos
	MOV ds,AX		
	MOV AH,09H		
	LEA DX,letrero		
	INT 21H			
	RET			
main ENDP
scodigo ENDS
	END main
