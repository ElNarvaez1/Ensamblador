.model small
.stack 64
.data
    ;Simples mensajes
    msj1 db 0ah,0dh, 'Ingrese Una Palabra : '', '$'
    msj2 db 0ah,0dh, 'Ingrese Una Letra: ', '$'
    Numero db 0ah,0dh, 'La Letra Se Repite: ', '$'

    Palabra db 100 dup('$')
    Letra db 100 dup('$')
    Veces db 100 dup('$')
    Contador db 0

    salto db 13,10,13,10,'$' ;salto de linea
    .code
        inicio:
        mov si,0
        mov ax,@data
        mov ds,ax
        mov ah,09
        mov dx,offset msj1
        int 21h

        call saltodelinea

        Ciclo:
            mov ah,01h
            int 21h

            cmp al,0DH
            je PedirLetra

            mov Palabra[si],al
            inc si
        jmp Ciclo
        PedirLetra:
            mov si,0h
            call saltodelinea

            mov ah,09
            mov dx,offset msj2
            int 21h

            mov ah,01h
            int 21h

        Ciclo2:
            cmp Palabra[si],24h
            je Imprimir

            cmp al,Palabra[si]
            je incrementar
            inc si
            jmp Ciclo2

        incrementar:
            inc contador
            inc si
            jmp Ciclo2
        imprimir:
            call saltodelinea
            mov ah,09
            mov dx,offset Numero
            int 21h
            add contador,30h
            mov ah,09
            mov dx,offset Contador
            int 21h
        jmp exit
    ;********************************METODOS*****************************************

    saltodelinea:
    mov dx, offset salto ;Salto de linea
    mov ah, 9
    int 21h
    ret

    exit:
    mov ax, 4c00h;utilizamos el servicio 4c de la interrupcion 21h
    int 21h ;para termianr el programa
ends