CSEG segment
assume cs: CSEG, ds: CSEG, es:CSEG, ss:CSEG
org 100h

Begin:
        call CLS
        mov al, 'А'  ; Начинаем с буквы "А"

        mov cx, 20   ; Выводится будет 20 символов
                     ; Специальная команда loop сначала
                     ; уменьшает cx на 1, а потом сравнивает с нулём
                     ; И если cx = 0, то переходит на метку.

Main_Loop:
        push ax             ; Сохраняем в стек значение регистра AX
        call PUTCH

        mov dx, offset Separator  ; \ Рисуем разделитель
        call WRITE_LINE           ; /   " = "

        mov ah, 0                 ; Если AH не будет = 0, то и его переведёт
        call HEX                  ;\
        mov dx, bx                ; > Тёрки вокруг числа в AL
        call WRITE_LINE           ;/

        call CLRF                 ; Следующая строка
        pop ax             ; Восстанавливаем регистр AX из стека
        inc al             ; Увеличиваем AL на 1. Получается следующая буква
        loop Main_Loop       ; Тот самый луп, который проверяет CX


        call GETCH

        mov ah, 04Ch
        int 21h

include procedur.asm
; Все подробности внутри файла
include hex.asm

Separator db ' = $'

CSEG ends
end Begin