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

        mov dx, offset Message    ; � ॣ���� DX ����ᨬ ����
                                  ; �᫨ ���� ᫮�� offset
                                  ; � � DX �㤥� ��ࢠ� �㪢� - "�"
        call WRITE_LINE

Main_Loop:            ; ��⪠
        call GETCH

        cmp al, '*'   ; ����塞 ������ ���� � *
        jz End_Prog   ; �᫨ ��୮, � ���室 �� ���� End

        call PUTCH
        call CLRF

        jmp Main_Loop ; ��릮� �� ����
                      ; ������ goto

End_Prog:               ; ��⪠
        mov ah, 04Ch    ; ����頥� � ॣ���� AH �᫮ 4Ch
        int 21h         ; �맮� ���뢠��� 21h


Message db '����娭', 13, 10, '����⠭⨭', 13, 10, '����ᠭ�஢��', 10, 13, '------------------', 10, 13, '$'

; ��� ���� ��� �� ����� �� ����� ࠧ
; � �⮬ 䠩�� ����� �᭮��� ��楤���
include PROCEDUR.asm

CSEG ends
end Init