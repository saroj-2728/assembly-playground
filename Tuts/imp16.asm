; Read a string, display each word in separate line in a clear screen, display word count oo

.MODEL SMALL
.STACK 100H

.DATA
    prompt db "Enter a string: $"
    inputStr db 100 dup ('$')
    newLine db 0ah, 0dh, "$"
    wordsCount dw 1

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09h
        int 21h

        lea dx, inputStr
        mov ah, 0ah
        int 21h

        lea dx, newLine
        mov ah, 09h
        int 21h

        ; Clear the screen
        mov ax, 0600h
        mov bh, 07h
        mov cx, 0000h
        mov dx, 184fh
        int 10h

        ; Cursor to center
        ; mov ah, 02h
        ; mov bh, 00h
        ; mov dh, 12
        ; mov dl, 30
        ; int 10h

        lea si, inputStr + 2
        mov bl, 00h
        textDisplayLoop:
            mov al, [si]
            cmp al, '$'
            je endTextDisplay

            mov ah, 02h
            mov dl, al
            int 21h

            cmp al, ' '
            jne skipNewLine
            lea dx, newLine
            mov ah, 09h
            int 21h
            add wordsCount, 1

            skipNewLine:
                inc si
                jmp textDisplayLoop


        endTextDisplay:

            lea dx, newLine
            mov ah, 09H
            int 21H

            mov cx, 0000h
            mov ax, wordsCount
            countLoop:
                mov dx, 0000h
                mov bx, 10
                div bx
                add dx, 30h
                push dx
                inc cx
                cmp ax, 0000h
                jne countLoop


            displayCount:
                pop dx
                mov ah, 02h
                int 21H
                loop displayCount

        mov ah, 4ch
        int 21h


        MAIN ENDP
END MAIN