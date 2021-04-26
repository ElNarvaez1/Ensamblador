TITLE 
.286 
spila SEGMENT stack 
    DB 32 DUP ('stack___') 
spila ENDS 
sdatos SEGMENT
    let1 DB 'El Narvaez','$' 
sdatos ENDS 
    scodigo SEGMENT 'CODE' 
        Assume ss:spila, ds:sdatos, cs:scodigo 
        Princ PROC FAR 
            PUSH DS 
            PUSH 0 
            MOV AX, sdatos 
            MOV ds,AX 
            LEA dx,offset let1 
            MOV AH, 09H 
            INT 21H 
        RET 
        Princ ENDP 
    scodigo ENDS 
END Princ 

