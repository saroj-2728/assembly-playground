; read a num and display its mul table
.MODEL SMALL
.STACK 100H

.DATA
    prompt db "Enter a number: $"
    newLine db 0ah, 0dh, '$'
    mulTable db "Multiplication table: $"
    inputNum dw 0
    counter db 1

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09H
        int 21H

        mov ax, 0000h
        mov cx, 0ah
        takeInputNum:
            mov ah, 01h
            int 21H

            cmp al, 0dh
            je endInput

            sub al, 30h
            mov bl, al
            mov bh, 00h
            mov ax, inputNum

            mul cx
            add ax, bx

            mov inputNum, ax
            jmp takeInputNum



        endInput:
            mov ax, inputNum
            call displayNumFn
  

        lea dx, newLine
        mov ah, 09H
        int 21H

        lea dx, mulTable
        mov ah, 09H
        int 21H

        lea dx, newLine
        mov ah, 09H
        int 21H


        mov ax, inputNum
        mov cx, 10
        calculateMulTable:
            push ax
            push cx
            mul counter
            call displayNumFn
            pop cx
            pop ax
            inc counter
            loop calculateMulTable



        mov ah, 4ch
        int 21H

        MAIN ENDP

        ; pass the number in ax
        displayNumFn proc
            mov cx, 0000h
            mov bx, 0ah
            processNumber:
                mov dx, 0000h
                div bx
                add dx, 30h
                push dx
                inc cx
                cmp ax, 0000h
                jne processNumber

            displayNumber:
                pop dx
                mov ah, 02h
                int 21H
                loop displayNumber

            mov ah, 02h
            mov dl, 0
            int 21h

            RET
        displayNumFn ENDP


END MAIN