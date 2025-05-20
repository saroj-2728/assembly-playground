; Program to reverse a string

.MODEL SMALL
.STACK 100H

.DATA
    maxLen db 100
    strLen db ?
    inputStr db 100 dup ('$')
    prompt db "Enter a string: $"
    newLine db 0ah, 0dh, "$"
    reversedStr db 100 dup ('$')

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09h
        int 21h

        lea dx, maxLen
        mov ah, 0ah
        int 21h

        mov cx, 0000h
        lea si, inputStr
        lea di, reversedStr

        getInputStringLength:
            mov al, [si]
            cmp al, '$'
            je startReversing
            inc si
            inc cx
            jmp getInputStringLength
        startReversing:
            add di, cx
            dec di
            lea si, inputStr

        reverseStr: 
            mov al, [si]
            mov ah, [di]
            cmp al, '$'
            je doneReversing
            mov [si], ah
            mov [di], al
            inc si
            dec di
            loop reverseStr

        doneReversing:
            lea dx, newLine
            mov ah, 09h
            int 21h

            lea dx, reversedStr
            mov ah, 09h
            int 21h

            mov ah, 4ch
            int 21h


        MAIN ENDP
END MAIN