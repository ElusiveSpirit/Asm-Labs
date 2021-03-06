; ���������� ���祭�� � hex
; AX - ���祭�� ��।����� �१ ॣ���� AX.
; � ��襬 ��砥 AH = 0, � � AL �㪢�.
; DX - ����� �㤥� ��室���� ��뫪� �� �������஢����� ��ப�
; ��� �㭪�� � ������訬� ��������ﬨ � ᪮��஢�� � ����蠪���
HEX proc
        push cx       ; ���࠭塞 ॣ�����
        push ax
        push bx

        push ds
        pop es
        lea di, String          ; ����㧪� � DI ���� ��ப� String
        mov bx, offset HexTable ; ����㧪� � BX ���� ��ப� HexTable
                                ; lea - ����ୠ⨢� offset'�.

        mov cx, 2         ; ���砫� ��⠭�������� ��� ��ॢ��� AH � AL
        cmp ah, 0         ;\ �᫨ AH = 0, � ��ॢ��� ⮫쪮 ���� �᫮,
        jnz loop1         ;/ ���஥ ��室���� � al
        mov cx, 1
loop1:
       jz skip            ; �᫨ ��ॢ���� ⮫쪮 AL, � �ய�᪠�� ᫥������
                          ; ������� xchg
       xchg ah, al        ; ����� ���祭�� ���� ॣ���஢ ���⠬�
skip:
       push ax
       shr al, 4          ; ����⮢�� ᬥ饭�� ��ࠢ� �� 4 ���.
       xlat               ; ��ॢ���� �᫮ �� ⠡��� �� ����� BX � hex
                          ; �।�⠢�����
       stosb              ; �����뢠�� �� ����� DI ���, ����� ��室���� �
                          ; AL. �����稢��� DI �� 1.
       pop ax
       push ax
       and al, 00001111b  ; ���ࠥ� ������ ��ࠤ�.
       xlat               ; �����塞 ������ ��� ��ண� �᫠
       stosb
       pop ax
       loop loop1         ; �᫨ AH �� �뫮 = 0, � ����塞 ��� ��� ࠧ

       mov ax, '$'        ; ����頥� � ��ப� ��� �뢮�� ᨬ��� ���� ��ப�
       stosw

       mov dx, offset String    ; �����뢠�� � BX ���� ��ப�

       pop bx
       pop ax
       pop cx
       ret

HexTable db '0123456789ABCDEF'
String db   '           $', 0

HEX endp



; ��� �㭪樨 ��� ��ॢ��� ��� XLAT
; �� �室 �������� ᨬ��� � AL
; �� ��室� � AH - ��� ��ࢮ� �᫮ � hex �।�⠢�����
;             AL - ��஥ �᫮
; ���⢥�⢥��� �뢮���� � ���⭮� ���浪�.
; ���� ���� �㭪�� ��� �뢮��: PRINT_HEX
; ����� �ᯮ�짮���� �����:
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
