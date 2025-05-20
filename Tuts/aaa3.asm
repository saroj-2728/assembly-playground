.model small
.stack 100H
.data

msg db "enter a number: $"

newline db 0Dh , 0Ah , "$"

.code 
main proc far 
mov ax , @data
mov ds , ax 

;input msg
mov ah , 09h
lea dx , msg
int 21H

mov bx ,00h
mov cx , 10

back: 
mov ah , 01h
int 21H
; al = 23
cmp al , 0DH
je exit
mov ah , 00h
sub al , "0"
add bx , ax
mov ax , bx
mul cx 
mov bx , ax 
jmp back 
exit:
; bx ,230
mov ax , bx
mov cx, 10
div cx
; ax has value 23

;output

mov cx , 0000h
mov bx , 0010
loop1:
mov dx , 0000h 
div bx
add dx , "0"
push dx 
inc cx 
cmp ax , 0
jne loop1

loop2:
pop dx 
mov ah , 02h 
int 21H
loop loop2





mov ah , 09h
lea dx , newline
int 21H


mov ah, 4ch
int 21h




main endp
end main