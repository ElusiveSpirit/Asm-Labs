CSEG segment
assume cs: CSEG, ds: CSEG, es:CSEG, ss:CSEG
org 100h

Begin:
        call CLS
        mov al, '�'  ; ��稭��� � �㪢� "�"

        mov cx, 20   ; �뢮����� �㤥� 20 ᨬ�����
                     ; ���樠�쭠� ������� loop ᭠砫�
                     ; 㬥��蠥� cx �� 1, � ��⮬ �ࠢ������ � ���
                     ; � �᫨ cx = 0, � ���室�� �� ����.

Main_Loop:
        push ax             ; ���࠭塞 � �⥪ ���祭�� ॣ���� AX
        call PUTCH

        mov dx, offset Separator  ; \ ���㥬 ࠧ����⥫�
        call WRITE_LINE           ; /   " = "

        mov ah, 0                 ; �᫨ AH �� �㤥� = 0, � � ��� ��ॢ����
        call HEX                  ;\
                                  ; > ��ન ����� �᫠ � AL
        call WRITE_LINE           ;/

        call CLRF                 ; �������� ��ப�
        pop ax             ; ����⠭�������� ॣ���� AX �� �⥪�
        inc al             ; �����稢��� AL �� 1. ����砥��� ᫥����� �㪢�
        loop Main_Loop       ; ��� ᠬ� ��, ����� �஢���� CX


        call GETCH

        mov ah, 04Ch
        int 21h

include procedur.asm
; �� ���஡���� ����� 䠩��
include hex.asm

Separator db ' = $'

CSEG ends
end Begin