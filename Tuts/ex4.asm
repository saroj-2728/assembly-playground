; sort an array and display
.MODEL SMALL
.STACK 100H

.DATA
    array db 34, 5, 23,44,1,3

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        mov cx, 0005h
        outerLoop:
            lea si, array
            mov bl, 05h

            innerLoop:
                mov ax, [si]
                cmp al, ah
                jc skip
                mov [si], ah
                mov [si+1], al
                skip:
                    inc si
                    dec bl
                    jnz innerLoop
            loop outerLoop

        lea si, array
        mov cx, 0006h
        displayArray:
            mov al, [si]
            aam
            or ax, 3030h
            mov bx, ax

            mov ah, 02h
            mov dl, bh
            int 21h

            mov dl, bl
            int 21h
            
            mov dl, 0
            int 21h

            inc si
            loop displayArray

        
            

        mov ax, 4c00h
        int 21h


        MAIN ENDP
END MAIN