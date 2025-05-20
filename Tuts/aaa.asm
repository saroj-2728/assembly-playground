.Model small
.stack 100H

.data
max_len db 100
actual_len db ?
inputstring db 100 DUP('$')
msg db "Enter a string : $"
newline db 0Dh , 0Ah , "$"

.code 
main proc far
mov ax , @data
mov ds , ax

mov ah , 09h
lea dx , msg
int 21H

mov ah , 0Ah
lea dx , max_len
int 21H

mov cl , actual_len
mov bx , 0001h
lea si , inputstring

back: 
mov al , [si]
cmp al , 'a'
jb skip
cmp al , 'z'
ja skip
sub al , 32
skip:
ror bx , 1
jnc evensoskip
add al , 32
evensoskip:
rol bx , 1 
mov [si] , al
inc si 
inc bx 
loop back

lea dx , newline
mov ah , 09h
int 21H


lea dx , inputstring
mov ah , 09h
int 21h


main endp
end main