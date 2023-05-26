.model tiny
.data
    name1 db 'Aryaman Chauhan'  ;Name to be printed in revese order
    cnt db 15                   ;Lenght of name
    colstr dw ?                 ;Column position 
    rowstr dw ?                 ;Row position
.code
.startup
    ;Setting display mode to 80x25, 16 colors mode
    MOV AH, 00H
    MOV AL, 03H
    INT 10H

    ;Loading the name and row and column controller
    LEA SI, name1
    LEA DI, cnt
    ADD SI, [DI]
    DEC SI
    MOV CH, 00H
    MOV CL, [DI]
    MOV rowstr, 00H             ;Setting inital postion as 00 for row
    MOV colstr, 00H             ;Setting inital postion as 00 for column
    LEA DI, colstr
    LEA BX, rowstr

    ;Write the characters on the screen
    WRITE1:
        PUSH CX                 ; The BX,CX registers are required during the INT operation, so storing them in stack

        ;Setting the cursor
        MOV AH, 02H
        MOV DH, [BX]
        MOV DL, [DI]
        PUSH BX
        MOV BH,00H
        INT 10H

        ;Write a single character with defined row and column spacing
        MOV AH,09H
        MOV AL,[SI]
        MOV BH,00H
        MOV BL,00001111B
        MOV CX, 01H
        INT 10H

        ;Changing vertices
        POP BX
        POP CX
        INC WORD PTR[BX]
        DEC SI
        INC WORD PTR[DI]
        DEC CL
        JNZ WRITE1

    ; BLOCKING FUNCTION
    ; Wait for the user to press the '%' key to exit
    END1:
    MOV AH, 07H
    INT 21h
    CMP AL, "%"
    JNZ END1

    ; TERMINATE PROGRAM
    TERM:
    MOV AH, 4CH ; Exit function
    INT 21H

.exit
end