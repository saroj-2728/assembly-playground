; Add first 100 even numbers and display ther result

.MODEL SMALL
.STACK 100H

.DATA
    resultText db "Sum of first 100 even numbers: $"
    sum dw ?
    Ten dw 10
    newLine db 0ah, 0dh, "$"

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        lea dx, resultText
        MOV AH, 09H
        INT 21H
        
        mov cx, 0064h
        mov ax, 0000h
        mov bx, 0002h

        addNumbers:
            add ax, bx
            add bx, 0002h
            loop addNumbers

        mov sum, ax
        mov cx, 0000h

        convertToDecimal:
            mov dx, 0000h
            ; mov bx, Ten  
            div Ten
            inc cx
            add dx, 0030h
            push dx
            cmp ax, 0000h
            jne convertToDecimal

        displayDecimal:
            pop dx
            mov ah, 02h
            int 21h
            loop displayDecimal

        lea dx, newLine
        mov ah, 09H
        int 21h

        mov ah, 4ch
        int 21h

        MAIN ENDP
END MAIN    