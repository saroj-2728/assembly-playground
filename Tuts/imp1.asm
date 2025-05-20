; Program to read a string from use, convert tot uppercase, count no. of words and display each word in next line

.MODEL SMALL
.STACK 100H

.DATA
    inputStr db 100 dup ('$')
    prompt db "Enter a string: $"
    newLine db 0ah, 0dh, "$"
    wordsCount dw 1

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
        mov ah, 09H
        int 21h

        lea si, inputStr + 2
        mov cl, inputStr + 1
        mov ch, 00h
        
        displayLoop:
            mov al, [si]
            cmp al, ' '
            jne skipNewLine
                lea dx, newLine
                mov ah, 09H
                int 21h

                add wordsCount, 1
            
            skipNewLine:
                mov dl, al
                mov ah, 02h
                int 21H

                inc si
                loop displayLoop
                
            lea dx, newLine
            mov ah, 09h
            int 21H

            mov ax, wordsCount
            mov cx, 0000h

            convertToDecimal:
                mov dx, 0000h
                mov bx, 10
                div bx
                add dx, 30h
                push dx
                inc cx
                cmp ax, 0000h
                jne convertToDecimal

            displayDecimal:
                pop dx
                mov ah, 02h
                int 21H
                loop displayDecimal


        mov ah, 4ch
        int 21h


        MAIN ENDP
END MAIN