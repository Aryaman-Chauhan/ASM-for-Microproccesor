.MODEL TINY
.DATA
    NUM1 DB 1
    NUM2 DB 1               ;First two terms of the fibonacci
    ALP1 DB 'A'             ;The first to be printed
    ROWSTR DW ?             ;For controlling row

.CODE
.STARTUP
    ;Setting display mode to 80x25, 16 colors mode
    MOV AH, 00H
    MOV AL, 03H
    INT 10H

    ;Loading the name and row controller
    MOV CX, 08H             ;No. of terms to be generated
    LEA DI,NUM1
    LEA SI,NUM2
    MOV ROWSTR,00H
    LEA BX,ROWSTR

    ;Writing the first character
    PUSH CX                 ; The BX,CX registers are required during the INT operation, so storing them in stack

    ;Setting the cursor
    MOV AH, 02H
    MOV DH, [BX]
    MOV DL, 00H
    PUSH BX
    MOV BH,00H
    INT 10H

    ;Write a single character with defined row and column spacing
    LEA BX, ALP1
    MOV AL,[BX]
    MOV CX, [DI]
    MOV CH,00H
    ADD AL,CL
    DEC AL
    MOV AH,09H
    MOV BH,00H
    MOV BL,00001111B
    INT 10H

    ;Retriving our registers and finally starting the program logic
    POP BX
    POP CX
    DEC CX
    INC WORD PTR[BX]

    ;Fibonacci Logic start
    LOGIC1:
        PUSH CX

        ;Setting the cursor
        MOV AH, 02H
        MOV DH, [BX]
        MOV DL, 00H
        PUSH BX
        MOV BH,00H
        INT 10H

        ;Write a single character with defined row and column spacing
        LEA BX, ALP1
        MOV AL,[BX]
        MOV CX, [DI]
        MOV CH,00H
        ADD AL,CL
        DEC AL
        MOV AH,09H
        MOV BH,00H
        MOV BL,00001111B
        INT 10H

        ;Main fibonacci logic
        MOV BL, [DI]
        MOV BH, [SI]
        ADD BH,BL
        MOV [DI],BH
        MOV [SI],BL
        POP BX
        POP CX
        INC WORD PTR[BX]
        DEC CX
        JNZ LOGIC1

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
.EXIT
END