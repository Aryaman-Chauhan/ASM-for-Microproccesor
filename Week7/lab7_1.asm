; This Assembly Language Program (ALP) checks the entered username and password, and displays a custom message accordingly.

.model tiny
.data
    fname1 db "user.txt",0
    handle1 dw ?
    usn1 db 11 dup("$")
    fname2 db "pswd.txt",0
    handle2 dw ?
    pass1 db 6 dup("$")
    msg1 db "Enter 10 character long Username: $" ; Message 1: Prompt to enter the username
    max1 db 20 ; Maximum length for input
    act1 db ? ; Placeholder for action
    inp1 db 20 dup("$") ; Buffer to store user's input for username

    msg2 db "Enter 5 character long Password: $" ; Message 2: Prompt to enter the password
    inp2 db 30 dup("$") ; Buffer to store user's input for password
    msg3 db "Hello $" ; Message 3: Greeting message when both inputs are correct
    msg4 db "Wrong Username$" ; Message 4: Wrong username input
    msg5 db "Wrong Password$" ; Message 5: Wrong password input
    nline db 0ah, 0dh, "$" ; New line characters

.code
.startup
    ;Open Username file
        mov ah,3dh
        mov al,0h
        lea dx,fname1
        int 21h
        mov handle1,ax

    ;Read username from file
        mov ah,3fh
        mov bx,handle1
        mov cx,11
        lea dx,usn1
        int 21h

    ; Display message 1 on the screen and go to the next line.
        lea dx, msg1
        mov ah, 09h
        int 21h

    ; Add a new line after the message.
        lea dx, nline
        mov ah, 09h
        int 21h

    ; Take input from the user and store it in inp1.
        lea dx, max1
        mov ah, 0ah
        int 21h

    ; Compare the entered username with the stored username.
        cld
        lea di, inp1
        lea si, usn1
        mov cx, 10
        repe cmpsb
        jcxz l1

    ; If the username is incorrect, display the "wrong username" message and exit.
        lea dx, nline
        mov ah, 09h
        int 21h

        lea dx, msg4
        mov ah, 09h
        int 21h

        mov ah, 4ch
        int 21h

    ;If username is correct, read password from file
    l1:
        ;Open password file
            mov ah,3dh
            mov al,0h
            lea dx,fname2
            int 21h
            mov handle2,ax

        ;Read password from file
            mov ah,3fh
            mov bx,handle2
            mov cx,6
            lea dx,pass1
            int 21h

    ; If the username is correct, display the "enter password" message.
        lea dx, nline
        mov ah, 09h
        int 21h

        lea dx, msg2
        mov ah, 09h
        int 21h

        lea dx, nline
        mov ah, 09h
        int 21h

    ; Take password input from the user, masking the characters.
        mov cx, 6
        lea di, inp2
    l2:
        mov ah, 08h
        int 21h
        mov [di], al
        mov dl, '*'
        mov ah, 02h
        int 21h
        inc di
        dec cx
    jnz l2

    ; Compare the entered password with the stored password.
        cld
        mov cx, 5
        lea di, inp2
        lea si, pass1
        repe cmpsb
        jcxz l3

    ; If the password is incorrect, display the "wrong password" message and exit.
        lea dx, nline
        mov ah, 09h
        int 21h

        lea dx, msg5
        mov ah, 09h
        int 21h

        mov ah, 4ch
        int 21h

    ; If the password is correct, display the greeting message and the username.
    l3:
        lea dx, nline
        mov ah, 09h
        int 21h

        lea dx, msg3
        mov ah, 09h
        int 21h

        lea dx, usn1
        mov ah,09h
        int 21h

        lea dx, nline
        mov ah, 09h
        int 21h
        NOP
.exit
end