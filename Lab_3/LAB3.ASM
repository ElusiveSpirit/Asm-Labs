CSEG segment                                    ; ���뢠�� ��� ������
                                                ; ᥣ���� � ����� �㤥�
                                                ; ࠡ����.
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG       ; ��ᢠ�� �ᥬ ॣ���ࠬ,
                                                ; �⢥��騬 �� ����
                                                ; ᥣ���⮢ ��� ᥣ����.
org 100h         ; ��易⥫쭮� ��� .ᮬ 䠩��� ᬥ饭�� �� ��砫� ᥣ����.
                 ; ��� ���� �ய�ᠭ� ��㣨� �������, � ������ �� �����
                 ; ������ � ���୥� ��� ������ � ����蠪���
Init:     ; ��⪠ ��砫� �ணࠬ��

        ; ���뢠���� � �뢮� �� ��࠭
        call GETCH
        call PUTCH
        call CLRF

        call GETCH
        call PUTCH
        call CLRF

        call GETCH
        call PUTCH
        call CLRF

        mov ah, 04Ch    ; ����頥� � ॣ���� AH �᫮ 4Ch
        int 21h         ; �맮� ���뢠��� 21h

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

; ����頥� ᨬ��� �� ��࠭ �� ���� �����. ����� ᤢ�������.
; �� �室 �������� ��� ᨬ���� � AL
PUTCH proc
        push ax         ; ���࠭��� � �⥪� ���祭�� ॣ���� AX
                        ; �����! ����室��� ��易⥫쭮 ��ࠢ���� �⥪
                        ; �������� pop!!!
        mov ah, 0Eh
        int 10h
        pop ax          ; ���᪨���� �� �⥪� ��᫥���� ���祭�� � ����ᨬ
                        ; � AX
        ret
PUTCH endp

; ���室 �� ᫥������ ��ப� � ������� �뢮�� ���� ᯥ�. ᨬ����� �� ��࠭
CLRF proc
          ; �� �� ��� ᨬ���� ����� ���-����� ������
        mov al, 0Dh
        call PUTCH
        mov al, 0Ah
        call PUTCH
        ret
CLRF endp

CSEG ends
end Init