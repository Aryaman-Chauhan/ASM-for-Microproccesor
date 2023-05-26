.model tiny
.data
max1 db "The character entered is not a$"
max2 db "The character entered is a$"




.code
.startup

MOV AH,08h
INT 21h
cmp al,"a"
jne l3

LEA DX,max2
mov AH,09h
INT 21h
JMP L2


l3:
LEA DX,max1
mov AH,09h
INT 21h
JMP L2

L2:
.exit
end
