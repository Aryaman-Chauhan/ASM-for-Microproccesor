.model tiny
.data
num1 equ 3
num2 equ 2
num2fact dw ?
.code
.startup
    mov ax,1
    mov bx, num1-num2
    call fact
    mov num2fact, ax
    mov ax,1
    mov bx,num1
    call fact

    div num2fact
    ret         ;RUN by G 0119

    fact proc
    mul bx 
    dec bx 
    jnz fact
    ret
    fact endp
.exit
end