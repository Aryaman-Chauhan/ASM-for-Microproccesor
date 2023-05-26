.model tiny
.data
msg1 db "aryaman$"
cnt     db  07h
.code
.startup
    lea si,msg1
    lea di,cnt
    mov al,[di]
    LOOP1:
    PUSH [si]
    inc WORD PTR si
    dec al
    jnz LOOP1
    lea si,msg1
    mov al,[di]
    LOOP2:
    POP [si]
    inc WORD PTR si
    dec al
    jnz LOOP2  
.exit
end