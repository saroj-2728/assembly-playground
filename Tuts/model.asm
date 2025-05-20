; Read a word and display all alphabets in alternate case

.model small
.stack 100h
.data
    inputStr db 20 dup('$')
    prompt db "Enter a word: $"
    newLine db 0ah, 0dh, "$"

.code
    main proc
        mov ax, @data
        mov ds, ax

        lea dx, prompt
        mov ah, 09h
        int 21h

        lea dx, inputStr
        mov ah, 0ah
        int 21H

        lea dx, newLine
        mov ah, 09H
        int 21h

        lea si, inputStr + 2
        mov cx, 00h
        convertString:
            mov al, [si]
            cmp al, 13
            je displayResult
;adItya
            cmp al, 'a'
            jb skipCase
            cmp al, 'z'
            ja skipCase
            sub al, 20h

            skipCase:
                TEST cx, 01h
                jnz skipFor
                or al, 20h
                skipFor:
                    mov [si], al
                    inc si
                    inc cx
                    jmp convertString
                    


        displayResult:


        lea dx, inputStr + 2
        mov ah, 09H
        int 21h



        mov ah, 4ch
        int 21h
    main endp
end main