; -========PROCEDUR.asm========-
; Файл с основными процедурами.
;
; Для использования добавить в код строку:
; (Желательно в конец кода)
;     include procedur.asm
;
; Чтобы вызвать процедуру GETCH или любую другую:
;     call GETCH
; -============================-



; Ожидает нажатия на клавишу
; Возвращает в AL код символа.
;
; Если была нажата одна из специальных клавиш, типа
; ESC, ENTER и др. то в код символа будет в AH
GETCH proc
        mov ah, 10h
        int 16h
        ret
GETCH endp

; Помещает символ на экран на место курсора. Курсор сдвигается.
; На вход подаётся код символа в AL
PUTCH proc
        push ax
        mov ah, 0Eh
        int 10h
        pop ax
        ret
PUTCH endp

; Печатает в месте курсора строку.
; DX - Адрес начала строки.
; Строка будет выводится пока не упрётся в знак '$' - конец строки
; Пример:
;         mov dx, offset Message
;         call WRITE_LINE
;         ...
;         Message db 'Hello World$'
WRITE_LINE proc
        push ax
        mov ah, 09h
        int 21h
        pop ax
        ret
WRITE_LINE endp

; Переход на следующую строку с помощью вывода двух спец. символов на экран
CLRF proc
        mov dx, offset ClearLine
        call WRITE_LINE
        ret
        ClearLine db 0Dh, 0Ah, '$'
CLRF endp

; Очистка экрана.
CLS proc
        push ax
        mov ax, 03h
        int 10h
        pop ax
        ret
CLS endp