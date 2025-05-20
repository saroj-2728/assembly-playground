; Sort an array of 10 no.s stored in memory and display them after sorting

.MODEL SMALL
.STACK 100H

.DATA
    arr1 db 11,22,33,55,33,44,23,34

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        mov cx, 0007h
        
        outerLoop:
            lea si, arr1
            mov bl, 07h

            innerLoop:
                mov al, [si]
                mov ah, [si+1]
                cmp al, ah
                jbe skipSwap
                mov [si], ah
                mov [si+1], al
                skipSwap:
                    inc si
                    dec bl
                    jnz innerLoop
            loop outerLoop

        lea si, arr1
        mov cx, 0008h
        displayLoop:
            mov al, [si]
            aam
            or ax, 3030h
            mov bx, ax
            
            mov ah, 02h
            mov dl, bh
            int 21H

            mov dl, bl
            int 21H

            mov dl, 0
            int 21H

            inc si
            loop displayLoop

        mov ah, 4ch
        int 21h
        
        MAIN ENDP
END MAIN