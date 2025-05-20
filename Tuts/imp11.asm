; Take a no. and display its multiplication table

.MODEL SMALL
.STACK 100H

.DATA
    prompt db "Enter a number: $"
    newLine db 0ah, 0dh, "$"
    mulTable dw 50 dup('$')
    ten dw 10

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09h
        int 21h

        mov bx, 0000h
        inputLoop:
            mov ah, 01h
            int 21h

            cmp al, 0dh
            je endInput

            sub al, 30h
            mov ah, 00h
            mov cx, ax

            mov ax, bx
            mul ten

            add ax, cx
            mov bx, ax
            
            jmp inputLoop

    
        endInput:      
            mov ah, 09h
            lea dx, newLine
            int 21h

            lea si, mulTable
            mov ax, 1
            mov cx, 10
            calculate:
                mul bx
                mov [si], ax

                inc ax
                inc si
                loop calculate
            

            lea si, mulTable

            displayTable:
                mov ah, 00
                mov al, [si]
                cmp al, '$'
                je endDisplay

                aam
                or ax, 3030h
                mov bx, ax

                mov dl, bh
                mov ah, 02h
                int 21h

                mov dl, bl
                mov ah, 02h
                int 21h

                mov dl, 0
                int 21h

                inc si
                jmp displayTable

        endDisplay:


        mov ah, 4ch
        int 21h


        MAIN ENDP
END MAIN