.model tiny

.data
prompt db 'Enter the string: $'
max_input db 20h
Act1 db ?
input_string db 20h dup(00h)
output_string db 20h dup('$'), '$'

.code
.startup

    ; Print prompt for user input
    mov ah, 9
    lea dx, prompt
    int 21h

    lea dx, max_input
    mov ah, 0ah
    int 21h   ; read user input string

    lea si, input_string 
    lea di, output_string

convert_loop:
    mov al, byte ptr [si]
    cmp al, 0dh
    je end_convert
    cmp al, 'a'
    jb next_char
    cmp al, 'z'
    ja next_char
    sub al, 20h 
next_char:
    mov byte ptr [di], al
    inc si
    inc di
    loop convert_loop

end_convert:    
    lea dx, output_string
    mov ah, 09h
    int 21h  ; display converted string

    
.exit
end
