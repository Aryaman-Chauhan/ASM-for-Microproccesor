.model tiny
.data
dat1 db 'wasitcatisaw'
dat1length db 0ch
dat2 db 'wasitactisaw'
res dw 00h
.code
.startup

        lea si,dat1
        lea di,dat2
        mov cx,0ch
        cld
        REPE CMPSB
        sub di, offset dat2
        mov bx, di
        dec bx
        lea si, res
        mov [si],bx
    CMP CX,0ch
    
        mov [res],01h 
        JMP E
        JLE NOTPALINDROME
    NOTPALINDROME:
        MOV [res],00h
    E:        
.exit
end
