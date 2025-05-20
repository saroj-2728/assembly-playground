; read a string from user, convert to uppercase, count no. of words and display each word in each line
.model small
.stack 100h
.data
    inputStr db 100h dup('$')
    prompt db "Enter a string: $"
    newLine db 0ah, 0dh, '$'
    noOfWords db "No. of words = $"
    wordsCount db 1

.code
    main proc
        mov ax, @data
        mov ds, ax

        lea dx, prompt
        mov ah, 09h
        int 21h

        lea dx, inputStr
        mov ah, 0ah
        int  21h

        lea si, inputStr + 1
        mov cl, [si]
        mov ch, 00h
        lea si, inputStr + 2
        
        convertToUppercase:
            mov al, [si]
            cmp al, ' '
            jne notASpace
            add wordsCount, 1

            notASpace:
                cmp al, 'a'
                jl skipCase
                cmp al, 'z'
                ja skipCase
                sub al, 20h
                mov [si], al

            skipCase:
                inc si
                loop convertToUppercase

        lea dx, newLine
        mov ah, 09h
        int 21h
                
        lea dx, inputStr + 2
        mov ah, 09h
        int 21h

        lea dx, newLine
        mov ah, 09h
        int 21h

        lea dx, noOfWords
        mov ah, 09h
        int 21h

        mov al, wordsCount
        mov ah, 00h
        mov bx, 0ah
        mov cx, 00h
        processNoOfWords:
            mov dx, 0000h
            div bx
            add dx, 30h
            push dx
            inc cx
            cmp ax, 0000h
            jne processNoOfWords

        showNoOfWords:
            pop dx
            mov ah, 02h
            int 21h
            loop showNoOfWords

        
        lea dx, newLine
        mov ah, 09H
        int 21h


        lea si, inputStr + 2
        displayString:
            mov al, [si]
            cmp al, '$'
            je endDisplayingString
            cmp al, ' '
            jne skipNewLine

            lea dx, newLine
            mov ah, 09H
            int 21H
            jmp doNotDisplaySpace

            skipNewLine:
                mov dl, [si]
                mov ah, 02h
                int 21H

                doNotDisplaySpace:
                    inc si
                    jmp displayString

        endDisplayingString:


        mov ah, 4ch
        int 21h

    main endp
end main