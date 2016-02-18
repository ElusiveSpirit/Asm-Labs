CSEG segment
assume cs: CSEG, ds: CSEG, es:CSEG, ss:CSEG
org 100h

Begin:
        call CLS

Getch_Loop:             ; Считываем символ только выше 20h
        call GETCH
        cmp al, 20h
        jna Getch_Loop

        mov ah, 07h                     ; Цвет
        mov cx, 0000h                   ; Координата левого верхнего угла
        mov dx, 0615h                   ; Координата правого нижнего угла
        call DRAW_BORDER                ; Отрисовка рамки

        xchg dx, cx
        inc dh

        mov cx, 20   ; Выводится будет 20 символов
                     ; Специальная команда loop сначала
                     ; уменьшает cx на 1, а потом сравнивает с нулём
                     ; И если cx = 0, то переходит на метку.

Main_Loop:
        push ax             ; Сохраняем в стек значение регистра AX

        cmp al, 20h
        ja Skip_Change
        mov al, '?'
Skip_Change:

        inc dl
        mov ah, 07h
        call DRAW_CHAR            ; Рисуем символ
        pop ax
        push ax

        inc dh
        xchg ch, al
        mov bx, offset Separator  ; \ Рисуем разделитель
        call DRAW_TEXT            ; /   " = "
        xchg al, ch
        xchg ah, ch

        push dx
        call HEX                  ; Тёрки вокруг числа в AL
        mov bx, dx
        pop dx
        xchg ah, ch
        xor ch, ch
        add dh, 3
        call DRAW_TEXT
        sub dh, 4

        pop ax               ; Восстанавливаем регистр AX из стека
        inc al               ; Увеличиваем AL на 1. Получается следующая буква

        loop Main_Loop       ; Тот самый луп, который проверяет CX


        call GETCH

        mov ah, 04Ch
        int 21h

include procedur.asm
; Все подробности внутри файла
include hex.asm
include draw.asm

Separator db ' = $'

CSEG ends
end Begin