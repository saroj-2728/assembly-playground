; read a string, count no of vowels and display string and no of vowels in a clear screen
.MODEL SMALL
.STACK 100H

.DATA
    inputStr db 100h dup('$')
    prompt db "Enter a string: $"
    newLine db 0ah, 0dh, '$'
    vowelsCount db 0

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09h
        int 21H

        lea dx, inputStr
        mov ah, 0ah
        int 21H

        lea dx, newLine
        mov ah, 09h
        int 21H

        lea si, inputStr + 2
        countVowels:
            mov al, [si]
            cmp al, '$'
            je endCounting
            inc si
            cmp al, 'a'
            je increaseVowelsCount
            cmp al, 'A'
            je increaseVowelsCount
            cmp al, 'e'
            je increaseVowelsCount
            cmp al, 'E'
            je increaseVowelsCount
            cmp al, 'i'
            je increaseVowelsCount
            cmp al, 'I'
            je increaseVowelsCount
            cmp al, 'o'
            je increaseVowelsCount
            cmp al, 'O'
            je increaseVowelsCount
            cmp al, 'u'
            je increaseVowelsCount
            cmp al, 'U'
            je increaseVowelsCount
            jmp countVowels
            increaseVowelsCount:
                call incVowelCount
                jmp countVowels


        endCounting:

        mov ax, 0600h
        mov bx, 0700h
        mov cx, 0000h
        mov dx, 184fh
        int 10h

        lea dx, inputStr + 2
        mov ah, 09h
        int 21H

        lea dx, newLine
        mov ah, 09h
        int 21H

        mov al, vowelsCount
        mov ah, 00h
        mov cx, 0000h
        processVowelsCount:
            mov dx, 0000h
            mov bx, 0ah
            div bx
            add dx, '0'
            push dx
            inc cx
            cmp ax, 0000h
            jne processVowelsCount

        displayCount:
            pop dx
            mov ah, 02h
            int 21h
            loop displayCount

        mov ah, 4ch
        int 21H

        MAIN ENDP

        incVowelCount PROC
            inc vowelsCount
            RET
        incVowelCount ENDP

END MAIN