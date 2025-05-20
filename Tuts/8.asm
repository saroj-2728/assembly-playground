;Display string at (10, 40) position with green background and red foreground

.MODEL SMALL
.STACK 100H

.DATA
    str1 db "Red text green screen $"
    rows db 12
    columns db 40

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        mov ax, 0600h
        mov bh, 07h
        mov cx, 0000h
        mov dx, 184fh
        int 10h
        
        lea si, str1

        ; Set initial cursor position at (row=12, col=40)
        MOV AH, 02h
        MOV DH, rows
        MOV DL, columns
        MOV BH, 00h
        INT 10h

        displayLoop:
            mov ah, 02h
            mov dh, rows
            mov dl, columns
            int 10h
            mov al, [si]
            cmp al, '$'
            je skip

            mov ah, 09H
            mov dh, rows
            mov dl, columns
            mov bl, 24h             ; 2 for green bg, 4 for red foreground
            mov bh, 00h             ; page
            mov cx, 01h
            int 10h
            
            inc si
            inc columns
            jmp displayLoop

        skip:
            mov ah, 4ch
            int 21h            

        MAIN ENDP
END MAIN