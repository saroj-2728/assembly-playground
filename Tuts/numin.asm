.model small
.stack 100h
.data
.code
    main proc
        mov ax, @data
        mov dx, ax

        mov bx, 0000h
        inputLoop:
            mov ax, 0000h
            mov ah, 01h
            int 21h

            


        mov ah, 4ch
        int 21h

        main endp
    end main
