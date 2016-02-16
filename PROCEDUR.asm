; -========PROCEDUR.asm========-
; ���� � �᭮��묨 ��楤�ࠬ�.
;
; ��� �ᯮ�짮����� �������� � ��� ��ப�:
; (����⥫쭮 � ����� ����)
;     include procedur.asm
;
; �⮡� �맢��� ��楤��� GETCH ��� ���� �����:
;     call GETCH
; -============================-



; ������� ������ �� �������
; �����頥� � AL ��� ᨬ����.
;
; �᫨ �뫠 ����� ���� �� ᯥ樠���� ������, ⨯�
; ESC, ENTER � ��. � � ��� ᨬ���� �㤥� � AH
GETCH proc
        mov ah, 10h
        int 16h
        ret
GETCH endp

; ����頥� ᨬ��� �� �࠭ �� ���� �����. ����� ᤢ�������.
; �� �室 �������� ��� ᨬ���� � AL
PUTCH proc
        push ax
        mov ah, 0Eh
        int 10h
        pop ax
        ret
PUTCH endp

; ���⠥� � ���� ����� ��ப�.
; DX - ���� ��砫� ��ப�.
; ��ப� �㤥� �뢮����� ���� �� ������ � ���� '$' - ����� ��ப�
; �ਬ��:
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

; ���室 �� ᫥������ ��ப� � ������� �뢮�� ���� ᯥ�. ᨬ����� �� �࠭
CLRF proc
        mov dx, offset ClearLine
        call WRITE_LINE
        ret
        ClearLine db 0Dh, 0Ah, '$'
CLRF endp

; ���⪠ �࠭�.
CLS proc
        push ax
        mov ax, 03h
        int 10h
        pop ax
        ret
CLS endp