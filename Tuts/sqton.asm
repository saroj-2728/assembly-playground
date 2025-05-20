; Take n, find sum of squares up to n
; This works upto 57

.MODEL SMALL
.STACK 100H

.DATA
    prompt db "Enter a number: $"
    newLine db 0ah, 0dh, "$"
    sum dw 0
    sumAhead dw ?
    higherWord dw ?
    lowerWord dw 0
    ten dw 10
    summedOutput db "Sum of squares up to $"
    colon db ": $"

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        ; Display the prompt
        lea dx, prompt
        mov ah, 09h
        int 21h

        ; Take the number input from user, parse it and store in bx
        mov bx, 0000h
        takeInput:
            mov ah, 01h
            int 21h

            cmp al, 0dh
            je endInput

            sub al, 30h
            mov ah, 00h
            mov cx, AX

            mov ax, bx
            mul ten

            add ax, cx
            mov bx, ax

            jmp takeInput

        
        endInput:

            push bx

            ; Display the result text
            lea dx, summedOutput
            mov ah, 09h
            int 21h


            ; Push number to stack
            mov cx, 0000h
            mov ax, bx
            countLoop:
                mov dx, 0000h
                mov bx, 10
                div bx
                add dx, 30h
                push dx
                inc cx
                cmp ax, 00h
                jne countLoop

            ; Pop and display the number
            displayNum:
                pop dx
                mov ah, 02h
                int 21h
                loop displayNum


            ; Display the colon
            mov ah, 09h
            lea dx, colon
            int 21h

            
            ; Calculate the squared sum
            pop bx
            mov di,bx
            mov ax, 1
            mov cx, 0000h ; lower word
            mov bx, 0000h ; higher word
            calculateSquaredSum:
                mov si, ax
                mul si
                add sum, ax

                add cx, ax
                jnc skipDXAdd
                inc bx
                
                skipDXAdd:

                    cmp dx, 0
                    je skipHigherWord
                    add bx, dx

                    skipHigherWord:
                        mov ax, si
                        inc ax
                        dec di
                        jnz calculateSquaredSum
                        

        DisplayLongNumber:
            mov  si, 0           ; Digit counter
            mov  di, 10          ; Divisor
            
            ConvertLoop:
                ; Divide BX:CX by 10
                mov  ax, bx
                mov  dx, 0
                div  di          ; DX:AX / 10 = AX remainder DX
                mov  bx, ax      ; quotient back to bx
                
                mov  ax, cx      ; Remainder of previous division acts as the high word for this division i.e DX:AX / 10
                div  di          ; DX:AX / 10 = AX remainder DX
                mov  cx, ax      ; quotient back to cx
                
                add  dl, '0'     ; Convert remainder to ASCII
                push dx
                inc  si
                
                ; Continue till both words 0 i.e the whole number has been processed
                cmp  bx, 0
                jne  ConvertLoop
                cmp  cx, 0
                jne  ConvertLoop
            
            ; Display digits
            DisplayDigits:
                pop  dx
                mov  ah, 02h
                int  21h
                dec  si
                jnz  DisplayDigits
            

        mov ah, 4ch
        int 21h

        MAIN ENDP
END MAIN