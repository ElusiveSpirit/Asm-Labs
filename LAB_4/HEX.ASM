; Конвертирует значение в hex
; AX - Значение передаётся через регистр AX.
; В нашем случае AH = 0, а в AL буква.
; BX - Здесь будет находится ссылка на конвертированную строку
; Эту функцию с небольшими изменениями я скопировал у Большакова
HEX proc
        push cx       ; Сохраняем регистры
        push ax
        push dx

        push ds
        pop es
        lea di, String          ; Загрузка в DI адреса строки String
        mov bx, offset HexTable ; Загрузка в BX адреса строки HexTable
                                ; lea - альтернатива offset'у.

        mov cx, 2         ; Сначала устанавливаем для перевода AH и AL
        cmp ah, 0         ;\ Если AH = 0, то переведём только одно число,
        jnz loop1         ;/ которое находится в al
        mov cx, 1
loop1:
       jz skip            ; Если переводим только AL, то пропускаем следующую
                          ; команду xchg
       xchg ah, al        ; Меняет значения двух регистров местами
skip:
       push ax
       shr al, 4          ; Побитовое смещение вправо на 4 бита.
       xlat               ; Переводит число по таблице по адресу BX в hex
                          ; представление
       stosb              ; Записывает по адресу DI бит, который находится в
                          ; AL. Увеличивает DI на 1.
       pop ax
       push ax
       and al, 00001111b  ; Затирает старшую тетраду.
       xlat               ; Повторяем операцию для второго числа
       stosb
       pop ax
       loop loop1         ; Если AH не было = 0, то поторяем всё ещё раз

       mov ax, '$'        ; Помещаем в строку для вывода символ конца строки
       stosw

       mov bx, offset String    ; Записываем в BX адрес строки

       pop dx
       pop ax
       pop cx
       ret

HexTable db '0123456789ABCDEF'
String db   '           $', 0

HEX endp



; Мои функции для перевода без XLAT
; На вход подаётся символ в AL
; На выходе в AH - его первое число в hex представлении
;             AL - второе число
; Соотвественно выводить в обратном порядке.
; Ниже есть функция для вывода: PRINT_HEX
; Можно использовать подряд:
;       call ALT_HEX
;       call PRINT_HEX
ALT_HEX proc
        push bx
        mov bl, 10h
        mul bl

        push ax
        mov ah, 0
        div bl
        pop bx
        mov ah, bh

        ; to HEX
        add ax, 3030h
        cmp al, 39h
        jbe HEX_Next1
        add al, 7h
HEX_Next1:
        ; Check for rus symboles
        call HEX_RUS
        cmp ah, 39h
        jbe HEX_Next2
        add ah, 7h
HEX_Next2:
        call HEX_RUS
        pop bx
        ret
ALT_HEX endp

HEX_RUS proc
        cmp al, 0AFh
        JBE HEX_RUS_EXIT
        cmp al, 0E0h
        JNBE HEX_RUS_EXIT
        add al, 49
HEX_RUS_EXIT:
        ret
HEX_RUS endp

PRINT_HEX proc
        xchg ah, al
        call PUTCH
        xchg ah, al
        call PUTCH
        ret
PRINT_HEX endp
