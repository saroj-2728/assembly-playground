; Generate multiplication table

.MODEL SMALL
.STACK 100H

.DATA
    num1 db 8
    num2 db 2
    tab 11 dup ('$')    
    resultText db "Multiplication table of 8: $"
    newLine db 0ah, 0dh, "$"

.CODE
    MAIN PROC far
        MOV AX, @DATA
        MOV DS, AX
        
        

        MAIN ENDP
END MAIN