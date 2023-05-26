.model tiny
.data
str1	db	'Enter your name: $'

max1	db	32
act1	db	?
inp1 	db	32 dup('$')     ;Name gets stored locally in this variable

fname	db	'testing.txt',0
handle	dw	?
.code
.startup
        ;Displaying the str1
        LEA DX,str1
        MOV AH,09h
        INT 21h
        ;Inputting the name
        LEA DX,max1
        MOV AH,0Ah
        INT 21h
        ;Create the file
        MOV AH, 3Ch
        LEA DX, fname
        MOV CL, 00h
        INT 21h
        MOV handle, AX
        ;Open the file
        MOV AH,3Dh
        MOV AL,1h
        LEA DX,fname
        INT 21h
        MOV handle,AX
        ;Writing into the file
        MOV AH,40h
        MOV BX,handle
        MOV CX,7
        LEA DX,inp1
        INT 21h
        ;Close the file
        MOV AH,3Eh
        INT 21h
.exit
end