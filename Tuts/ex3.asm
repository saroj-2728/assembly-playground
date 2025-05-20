; read a string, display each word at center of each line of a clear screen with blue background and cyan foregraound
.MODEL SMALL
.STACK 100H

.DATA
    inputStr db 100 dup('$')
    prompt db "Enter a string: $"
    newLine db 0ah, 0dh, '$'


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

        mov ax, 0600h
        mov bx, 0700h
        mov cx, 0000h
        mov dx, 184fh
        int 10h

        lea si, inputStr + 1
        mov cl, [si]
        mov ch, 00h

        lea si, inputStr + 2
        displayString:
            mov al, [si]
            cmp al, '$'
            je endDisplay
            cmp al, ' '
            jne skipNewLine

            lea dx, newLine
            mov ah, 09h
            int 21h
            jmp doNotShowSpace

            skipNewLine:
                mov dl, [si]
                mov ah, 02h
                int 21h
                jmp doNotCenter
            
            doNotShowSpace:
                mov dh, 12
                mov dl, 40
                mov bl, 15
                int 10h; Incomplete

            doNotCenter:
                inc si
                jmp displayString

        endDisplay:
            mov ah, 4ch
            int 21h


        MAIN ENDP
END MAIN