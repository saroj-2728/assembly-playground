; Convert uppercase letters to uppercase

.model small
.stack 500h
.data
    maxLen db 100
    strLen db ?
    inputStr db 100 dup('$')
    prompt db "Enter a string: $"
    newLine db 0dh, 0ah, "$"
    normalMsg db "String you entered is: $"
    upperCaseMsg db "String converted to uppercase: $"

.code
    main proc
        mov ax, @data
        mov ds, ax    
        
        mov ah, 09h
        lea dx, prompt
        int 21h

        mov ah, 0ah
        lea dx, maxLen
        int 21h

        mov ah, 09h
        lea dx, newLine
        int 21h

        mov ah, 09h
        lea dx, normalMsg
        int 21h

        mov ah, 09h
        lea dx, inputStr
        int 21h

        lea si, inputStr
        mov cl, strLen
        xor ch, ch     

        loop_string:
            mov al, [si]
            cmp al, 'a'
            jl skip_conversion
            cmp al, 'z'
            jg skip_conversion
            sub al, 32  

        skip_conversion: 
            mov [si], al
            inc si
            loop loop_string

        lea dx, newLine
        mov ah, 09h
        int 21H

        lea dx, upperCaseMsg
        mov ah, 09h
        int 21H

        lea dx, inputStr
        mov ah, 09h
        int 21h

        mov ah, 4ch
        int 21h
    
    main endp
end main

Runs correctly
