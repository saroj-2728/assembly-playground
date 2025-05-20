; Input characters until q and display the entered string

.MODEL SMALL
.STACK 100H

.DATA
    maxLen db 100
    strLen db ?
    inputStr db 100 dup ('$')
    prompt db "Enter a string: $"
    newLine db 0ah, 0dh, "$"

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09h
        int 21h

        lea si, inputStr
        mov ah, 01h

        takeInput:
            int 21h
            cmp al, "q"
            je endInput
            mov [si], al
            inc si
            jmp takeInput

        endInput:
            lea dx, newLine
            mov ah, 09h
            int 21h

            lea dx, inputStr
            mov ah, 09h
            int 21h

            mov ah, 4ch
            int 21h

        MAIN ENDP
END MAIN