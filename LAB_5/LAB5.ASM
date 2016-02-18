; Lab_4 - common
; Max 4 bytes for input

CSEG segment
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h
Init:

        call CLS

        lea di, Data    ; Move Data adress to di
        mov bx, di
        add bx, 4       ; This is the last adress of Data

Main_Loop:
        call GETCH

        cmp al, '*'
        jnz Main_Next1
        cmp Data, 0
        jz Main_Exit
Main_Next1:
        cmp al, '$'
        jz Main_Hex_Converter
        cmp di, bx     ; If Data is full -> Print
        jz Main_Hex_Converter

        call PUTCH
        stosb          ; Move the byte of input letter from al to es:[di]
                       ; It's the adress of Data
        jmp Main_Loop
Main_Hex_Converter:
        mov al, '='
        call PUTCH
        lea si, Data   ; Move the adress of Data to si
Main_HC_Loop:
        lodsb          ; Move the byte from adress = si to al
        cmp al, 0      ; If al = 0 -> do not show
        jz Main_HC_End

        xor ah, ah     ; ah must be = 0 for HEX
        call HEX
        call WRITE_LINE

        mov al, ' '
        call PUTCH

        cmp si, bx     ; If adress si = the last adress of Data -> exit
        jnz Main_HC_Loop
Main_HC_END:
        lea di, Data   ;  \
        mov al, 0      ;   > Clear the Data
        mov cx, 4      ;  /
        rep stosb      ; /
        lea di, Data
        xor si, si     ; SI = 0
        call CLRF      ; Next line
        jmp Main_Loop

Main_Exit:
        call CLS
        int 20h

Data db 4 dup(0)

include C:\labs\lab_4\hex.asm
include C:\labs\procedur.asm

CSEG ends
end Init


