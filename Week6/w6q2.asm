.model tiny
.data
fname1	db	'name.txt',0
handle1 dw ?
fname2 	db	'id.txt',0
handle2	dw ?
fname3	db	'splice.txt',0
handle3	dw ?

msg1 db 'Aryaman'
len1 dw 07h
msg2 db '2020B5A72006P'
len2 dw 0dh

part1 db 7 dup('$')
part2 db 13 dup('$')

.code
.startup
    ;Storing data into files
        ;Creating name file
        MOV AH, 3Ch
        LEA DX, fname1
        MOV CL, 00h
        INT 21h
        MOV handle1, AX
        ;Open the file
        MOV AH,3Dh
        MOV AL,1h
        LEA DX,fname1
        INT 21h
        MOV handle1,AX
        ;Writing into the file
        MOV AH,40h
        LEA BX,len1
        MOV CX,[BX]
        MOV BX,handle1
        LEA DX,msg1
        INT 21h
        ;Close the file
        MOV AH,3Eh
        INT 21h
        ;Creating id file
        MOV AH, 3Ch
        LEA DX, fname2
        MOV CL, 00h
        INT 21h
        MOV handle2, AX
        ;Open the file
        MOV AH,3Dh
        MOV AL,1h
        LEA DX,fname2
        INT 21h
        MOV handle2,AX
        ;Writing into the file
        MOV AH,40h
        LEA BX,len2
        MOV CX,[BX]
        MOV BX,handle2
        LEA DX,msg2
        INT 21h
        ;Close the file
        MOV AH,3Eh
        INT 21h
    ;Opening name file for reading
        ;Open name file
        MOV AH,3Dh
        MOV AL,0h
        LEA DX,fname1
        INT 21h
        MOV handle1,AX
        ;Reading file
        MOV AH,3Fh
        LEA BX,len1
        MOV CX,[BX]
        MOV BX,handle1
        LEA DX,part1
        INT 21h
        ;Close the file
        MOV AH,3Eh
        INT 21h
        ;Open ID file
        MOV AH,3Dh
        MOV AL,0h
        LEA DX,fname2
        INT 21h
        MOV handle2,AX
        ;Reading file
        MOV AH,3Fh
        LEA BX,len2
        MOV CX,[BX]
        MOV BX,handle2
        LEA DX,part2
        INT 21h
        ;Close the file
        MOV AH,3Eh
        INT 21h
        ;Creating splice file
        MOV AH, 3Ch
        LEA DX, fname3
        MOV CL, 00h
        INT 21h
        MOV handle3, AX
        ;Open the file
        MOV AH,3Dh
        MOV AL,1h
        LEA DX,fname3
        INT 21h
        MOV handle3,AX
        ;Since part1 and part2 are continuous we only need to give the corrct length
        LEA BX,len1
        MOV CX,[BX]
        LEA BX,len2
        ADD CX,[BX]
        ;Writing into the file
        MOV AH,40h
        MOV BX,handle3
        LEA DX,part1
        INT 21h
        ;Closing the file
        MOV AH,3Eh
        INT 21h
.exit
end

