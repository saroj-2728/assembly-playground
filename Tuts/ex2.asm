; arrange in ascending order
.MODEL SMALL
.STACK 100H

.DATA
    array db 4, 36, 13, 50, 2, '$'

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        mov bl, 00h

        sortInAscending:
            lea si, array
            mov al, [si]
            innerLoop:
                mov ah, [si+1]
                cmp al, ah
                jnc 




        MAIN ENDP
END MAIN