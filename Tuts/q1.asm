; Take a number input from user (max 3-digits) and find sum of the odd numbers upto that number

.MODEL SMALL
.STACK 100H

.DATA
    prompt db "Enter a number (max 3-digits): $"
    sum dw 0

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09h
        int 21h

        mov bx, 0000h
    
        takeInput:
        
            mov ah, 01h
            int 21h

            cmp al, 0dh
            je endInput

            sub al, 30h
            mov ah, 00h
            add bx, AX

            mov ax, bx
            mov cx, 10

            mul cx
            mov bx, ax
            
            jmp takeInput

        endInput:
            mov cx, 10
            mov ax, bx
            div cx

            ; mov bx, 0000h
            ; mov dx, 0001h
            ; oddSum:
            ;     add bx, dx
            ;     add dx, 0002h
            ;     cmp dx, ax
            ;     jne oddSum

            ; mov ax, bx
            mov cx, 0000h
            countLoop:
                mov dx, 0
                mov bx, 10
                div bx
                add dx, 30h
                push dx
                inc cx
                cmp ax, 0
                jne countLoop

            push cx

            displayLoop:
                pop dx
                mov ah, 02h
                int 21h
                loop displayLoop
            


        mov ah, 4ch
        int 21h


        MAIN ENDP
END MAIN