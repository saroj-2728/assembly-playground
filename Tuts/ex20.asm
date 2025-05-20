; read a num, calculate and display the factorial
.MODEL SMALL
.STACK 100H

.DATA
    prompt db "Enter a number: $"
    newLine db 0ah, 0dh, '$'
    inputNum dw 0
    fact dw 1

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        lea dx, prompt
        mov ah, 09H
        int 21H

        mov cx, 0ah
        takeInputNum:
            mov ah, 01h
            int 21h

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
            call displayNumberFn
            
            lea dx, newLine
            mov ah, 09H
            int 21h

            mov ax, inputNum
            mov bx, 1
            calcFactorial:
                cmp ax, 0
                je endFactorialCalculation
                mov cx, ax
                mul bx
                mov bx, ax
                mov ax, cx
                dec ax
                jmp calcFactorial

            endFactorialCalculation:
            mov ax, bx
            call displayNumberFn

            mov ah, 4ch
            int 21h

        MAIN ENDP


        displayNumberFn proc
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
            
            displayNum:
                pop dx
                mov ah, 02h
                int 21H
                loop displayNum
            
            RET
        displayNumberFn endp

            
END MAIN