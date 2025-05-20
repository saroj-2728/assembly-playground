; Sort in ascending orders and display

.MODEL SMALL
.STACK 100H

.DATA
    arr db 12, 13, 11, 92, 3, 5

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        mov cx, 0005h
        outerLoop: 
            mov bl, 05h
            lea si, arr

            innerLoop:
                mov ax, [si]
                cmp al, ah
                jc skipSwap
                mov [si], ah
                mov [si+1], al

                skipSwap:
                    inc si
                    dec bl
                    jnz innerLoop

            loop outerLoop

        mov cx, 0006h
        lea si, arr
        displayLoop:
            mov al, [si]
            aam
            or ax, 3030h
            mov bx, ax

            mov ah, 02h
            mov dl, bh
            int 21H

            mov dl, bl
            int 21h

            mov dl, 0
            int 21h

            inc si
            loop displayLoop

        mov ah, 4ch
        int 21h



        MAIN ENDP
END MAIN