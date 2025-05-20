.model small
.stack 100H
.data
max_len db 100
actual_len db ?
inputstring db 100 Dup("$")
max_len_2 db 100
actual_len_2 db ?
reversestring_2 db 100 Dup("$")
msg db "enter a string: $"
newline db 0Dh , 0Ah , "$"

.code 
main proc far 
mov ax , @data
mov ds , ax 

;input msg
mov ah , 09h
lea dx , msg
int 21H

;input string 
mov ah , 0Ah
lea dx, max_len
int 21H

mov cl , [actual_len]
lea si , inputstring
mov ch , 00h
add si , cx
dec si
lea di , reversestring_2
back:
mov al , [si]
mov [di], al
dec si
inc di 
loop back

mov ah , 09h
lea dx , newline
int 21H

mov ah , 09h
lea dx , reversestring_2
int 21H



mov ax , 4c00h
int 21h



main endp
end main