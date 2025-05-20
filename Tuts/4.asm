; Sort numbers in descending order

.MODEL SMALL
.STACK 100H

.DATA
    nums db 0ah, 00h, 01h, 02h, 44h, 0aah

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        mov cx, 0005h

        outerLoop:
            lea si, nums
            mov bl, 05h

            innerLoop:
                mov al, [si]
                mov ah, [si+1]            
                cmp al, ah
                jae skip
                mov [si], ah
                mov [si+1], al
                skip:
                    inc si
                    dec bl
                    jnz innerLoop
                
                loop outerLoop
        
        mov ax, 4c00h
        int 21h

        MAIN ENDP
END MAIN