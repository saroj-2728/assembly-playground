; Take a number input from user (max 3-digits) and find sum of the odd numbers upto that number

.MODEL SMALL
.STACK 100H

.DATA
    prompt db "Enter a number (max 3-digits): $"
    newLine db 0ah, 0dh, '$'
    preMessage db "Sum of odd numbers to  your entered number = $"
    sum dw 0

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09h
        int 21h

        lea dx, newLine
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
            
            ror ax, 1
            jc skip
            rol ax, 1
            dec ax
            jmp skip2

            skip:
                rol ax, 1
                skip2:

                mov bx, 0
                mov dx, 1

            add ax, 2
            oddSum:
                cmp dx, ax
                je skipSum
                add bx, dx
                add dx, 2
                jmp oddSum

            skipSum:
            mov ax, bx
            push ax

            lea dx, preMessage
            mov ah, 09h
            int 21h

            mov cx, 0000h
            pop ax
            countLoop:
                mov dx, 0
                mov bx, 10
                div bx
                add dx, 30h
                push dx
                inc cx
                cmp ax, 0
                jne countLoop

            displayLoop:
                pop dx
                mov ah, 02h
                int 21h
                loop displayLoop


        mov ah, 4ch
        int 21h


        MAIN ENDP
END MAIN