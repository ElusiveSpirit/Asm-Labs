; -=About==============================-
; Lib to draw text and different borders
;                             V1.0
;                             by Solleks
; ---------------------------------------
; Procedures:
;    1. DRAW_TEXT:
;
;
; ---------------------------------------


CurBorderID db 0
Border0 db '⁄ƒƒƒƒƒƒƒø$'
Border1 db '…ÕÕÕÕÕÕÕª$'
Border2 db '*********$'

; BX - text
; CX - left-top
; DX - right-bottom
; AH - color
DRAW_TEXT_WITH_BORDER proc
        mov al, 1
        xchg cx, bx
        push bx
        call DRAW_TOP
        call DRAW_MID
        call DRAW_BOTTOM
        pop bx
        xchg cx, bx
        xchg dx, cx
        inc dh
        inc dl
        call DRAW_TEXT
        dec dh
        dec dl
        xchg dx, cx
        ret
DRAW_TEXT_WITH_BORDER endp

; CX - left-top
; DX - right-bottom
; AH - color
DRAW_BORDER proc
        xchg cx, bx
        push bx
        call DRAW_TOP
        call DRAW_MID
        call DRAW_BOTTOM
        pop bx
        xchg cx, bx
        ret
DRAW_BORDER endp

DRAW_CHAR proc

        ; Set ES
        push 0B800h
        pop es
        ; Set DI
        push ax
        push cx
        mov al, dh
        mov cx, 0002h
        mul cl
        mov di, ax
        mov al, dl
        mov cl, 0A0h
        mul cl
        add di, ax
        pop cx
        pop ax

        stosw

        ret
DRAW_CHAR endp

; BX - text
; AH - properties
; AL - should add ' ' up the end of box? 0 - no, else - yes
; DX - coords
DRAW_TEXT proc
        push es
        push di
        push si
        push cx
        push dx
        push ax
        push bx

        ; Set ES
        push 0B800h
        pop es
        ; Set DI
        push ax
        push cx
        mov al, dh
        mov cx, 0002h
        mul cl
        mov di, ax
        mov al, dl
        mov cl, 0A0h
        mul cl
        add di, ax
        pop cx
        pop ax
        mov cl, al ; Save the al

Print_Text_Loop:
        mov al, byte ptr [bx]
        cmp al, '$'
        jz Exit_Print_Loop
        stosw
        inc bx

        jmp Print_Text_Loop
Exit_Print_Loop:
        cmp cl, 0
        jz End_Print

        ; Set bx
        mov bx, offset BorderData
        mov ax, 7
        xor ch, ch
        mov cl, CurBorderID
        mul cl
        add bx, ax
        add bx, 3
Add_Probels:
         mov al, ' '
         mov al, byte ptr [bx]
         cmp es:[di], al        ; if a wall -> exit
         jz End_Print
         stosw

        jmp Add_Probels
End_Print:

        pop bx
        pop ax
        pop dx
        pop cx
        pop si
        pop di
        pop es
        ret
DRAW_TEXT endp

; BX - left top corner
; DX - right bottom corner
; DH - x
; DL - y
; AH - color
DRAW_TOP proc
        push es
        push cx
        push ax
        push dx
        push bx

        ; Length of the middle line
        xor ch, ch
        mov cl, dh
        sub cl, bh

        xchg ax, bx
        push bx         ; save the text color

        push cx
        xor cx, cx
        mov bl, 2       ; X * 2
        mov cl, al
        xchg ah, al
        mul bl
        and ax, 00FFh
        mov di, ax
        mov al, cl
        mov bl, 160  ; Y * 160
        mul bl
        add di, ax   ; add coords to DI
        pop cx

        mov ax, 0B800h
        mov es, ax

        mov bx, offset BorderData
        mov al, 7
        xor dh, dh
        mov dl, CurBorderID
        mul dl
        add bx, ax
        pop ax
        ; Left corner
        mov al, byte ptr [bx]
        inc bx
        stosw
        ; Mid line
        mov al, byte ptr [bx]
        rep stosw
        ; Right corner
        inc bx
        mov al, byte ptr [bx]
        stosw

        pop bx
        pop dx
        pop ax
        pop cx
        pop es
        ret
DRAW_TOP endp

DRAW_MID proc
        push ax
        push dx
        push bx
        push cx

        push ax
        xchg ax, bx

        mov bl, dh
        sub bl, ah
        and bx, 00FFh
        mov si, bx ; SI - ë¨•È•≠®• ØÆ X
        xchg ax, si
        mov bx, 2
        mul bl
        xchg ax, si
        add si, 2

        xor ch, ch
        mov cl, dl
        sub cl, al ; CX - ë¨•È•≠®• ØÆ Y

        push cx
        ; DI - ¢ÎÁ®·´•≠®• §´Ô Ø•‡¢Æ£Æ ·®¨¢Æ´†
        inc al
        dec dl

        mov bl, 2       ; X * 2
        mov cl, al
        xchg ah, al
        mul bl
        and ax, 00FFh
        mov di, ax
        add si, ax ; Dobavim smesenie
        mov al, cl
        mov bl, 160  ; Y * 160
        mul bl
        add di, ax   ; add coords to DI
        add si, ax

        pop cx

        mov bx, offset BorderData
        mov al, 7
        xor dh, dh
        mov dl, CurBorderID
        mul dl
        add bx, ax
        add bx, 3

        mov ax, 0B800h
        mov es, ax
        pop ax
        mov al, byte ptr [bx]

MID_LOOP:
        ; è•Á†‚Ï
        mov es:[di], ax
        mov es:[si], ax
        ; è•‡•¨•È•≠®• DI
        add di, 160
        add si, 160
        loop MID_LOOP

        pop cx
        pop bx
        pop dx
        pop ax
        ret
DRAW_MID endp

DRAW_BOTTOM proc

        push es
        push cx
        push ax
        push dx
        push bx

        ; Length of the middle line
        xor ch, ch
        mov cl, dh
        sub cl, bh

        push ax
        xchg ax, bx

        push cx
        xor cx, cx
        mov bl, 2       ; X * 2
        mov cl, al
        xchg ah, al
        mul bl
        and ax, 00FFh
        mov di, ax
        mov al, dl
        mov bl, 160  ; Y * 160
        mul bl
        add di, ax   ; add coords to DI
        pop cx

        mov ax, 0B800h
        mov es, ax

        mov bx, offset BorderData
        mov ax, 7
        mov dl, CurBorderID
        mul dl
        add bx, ax
        add bx, 4

        pop ax
        ; Left corner
        mov al, byte ptr [bx]
        stosw
        inc bx
        ; Mid line
        mov al, byte ptr [bx]
        rep stosw
        inc bx
        ; Right corner
        mov al, byte ptr [bx]
        stosw

        pop bx
        pop dx
        pop ax
        pop cx
        pop es
         ret
DRAW_BOTTOM endp

; -=DATA==================---
; length = 7
BorderData db '⁄ƒø≥¿ƒŸ'
           db '…Õª∫»Õº'
           db '*******'

; ---------------------------
