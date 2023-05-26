.model tiny
.386
.data
colStart    dw 10
colEnd      dw 410
rowStart    dw 10
rowEnd      dw 20
usn1        db 14 dup(?)
fuser       db "lab1.txt",0
handle1     dw ?
.code
.startup
    ; Opening user file
        lea DX,fuser
        mov AH,3Dh
        mov AL,00h
        int 21h
        mov handle1,AX
    ; Reading file
        lea DX,usn1
        mov AH,3Fh
        mov BX,handle1
        mov CX,14
        int 21h
    ; Closing file
        mov AH,3Eh
        mov BX,handle1
        int 21h
        
        mov AH,00h
        mov AL,12h
        int 10h         ; set graphics video mode

        mov AH,02h
        mov DH,20
        mov DL,20
        mov BH,00h
        int 10h         ;set cursor
        mov BL,25

        lea BP,usn1
        mov CL,[BP]+11

        mov AH,08h
        int 21h
        cmp AL,CL      ;start the prog
        jnz PAINT2      ;If character not matched, print opposite pattern, start from 2nd
    
    PAINT1:
        mov DI,rowStart
    COLM1:
        mov SI,colEnd
    ROW1:
        mov AH,0Ch
        mov AL,00000010b
        mov CX,SI
        mov DX,DI
        int 10h         ;set pixel
        dec SI
        cmp SI,colStart
        jnz ROW1

        inc DI
        cmp DI,rowEnd
        jnz COLM1
        
        add rowEnd,10
        add rowStart,10
        dec BL
        jz blockF

    PAINT2:
        mov DI,rowStart
    COLM2:
        mov SI,colEnd
    ROW2:
        mov AH,0Ch
        mov AL,00000101b
        mov CX,SI
        mov DX,DI
        int 10h         ;set pixel
        dec SI
        cmp SI,colStart
        jnz ROW2

        inc DI
        cmp DI,rowEnd
        jnz COLM2

        add rowEnd,10
        add rowStart,10
        dec BL
        jz blockF
        jmp PAINT1

    blockF:
        mov AH,07h
    X1: int 21h
        cmp AL,'%'      ; Press % to close
        jnz X1
        mov AH,00h
        mov AL,03h
        int 10h         ; regain the normal display
.exit
end