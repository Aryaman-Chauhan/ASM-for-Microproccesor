.model tiny
.data
string1 db 'BITSIOTLAB'
string2 db 'IOT'
string1length db 0ah

.code
.startup
        mov cx, 00h
        mov di, 00h
        lea si, string1
        mov ax, 2ah
        mov 4[si],ax
        add si, 5
    top:
        cmp cx, 3
        je done
        mov al, 2[si]
        stosb
        inc cx
        inc si
        jmp top
    done:
        mov si, 00h
        lea di, string1
        add di, 05h
        mov cx, 00h
    top1:
        cmp cx, 03h
        je fin
        lodsb
        mov [di],al
        inc di
        inc si
        inc cx
        jmp top1
        je fin
    fin:
.exit
end