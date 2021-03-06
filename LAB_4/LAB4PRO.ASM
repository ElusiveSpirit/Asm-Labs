CSEG segment
assume cs: CSEG, ds: CSEG, es:CSEG, ss:CSEG
org 100h

Begin:
        call CLS

Getch_Loop:             ; ���뢠�� ᨬ��� ⮫쪮 ��� 20h
        call GETCH
        cmp al, 20h
        jna Getch_Loop

        mov ah, 07h                     ; ����
        mov cx, 0000h                   ; ���न��� ������ ���孥�� 㣫�
        mov dx, 0615h                   ; ���न��� �ࠢ��� ������� 㣫�
        call DRAW_BORDER                ; ���ᮢ�� ࠬ��

        xchg dx, cx
        inc dh

        mov cx, 20   ; �뢮����� �㤥� 20 ᨬ�����
                     ; ���樠�쭠� ������� loop ᭠砫�
                     ; 㬥��蠥� cx �� 1, � ��⮬ �ࠢ������ � ���
                     ; � �᫨ cx = 0, � ���室�� �� ����.

Main_Loop:
        push ax             ; ���࠭塞 � �⥪ ���祭�� ॣ���� AX

        cmp al, 20h
        ja Skip_Change
        mov al, '?'
Skip_Change:

        inc dl
        mov ah, 07h
        call DRAW_CHAR            ; ���㥬 ᨬ���
        pop ax
        push ax

        inc dh
        xchg ch, al
        mov bx, offset Separator  ; \ ���㥬 ࠧ����⥫�
        call DRAW_TEXT            ; /   " = "
        xchg al, ch
        xchg ah, ch

        push dx
        call HEX                  ; ��ન ����� �᫠ � AL
        mov bx, dx
        pop dx
        xchg ah, ch
        xor ch, ch
        add dh, 3
        call DRAW_TEXT
        sub dh, 4

        pop ax               ; ����⠭�������� ॣ���� AX �� �⥪�
        inc al               ; �����稢��� AL �� 1. ����砥��� ᫥����� �㪢�

        loop Main_Loop       ; ��� ᠬ� ��, ����� �஢���� CX


        call GETCH

        mov ah, 04Ch
        int 21h

include procedur.asm
; �� ���஡���� ����� 䠩��
include hex.asm
include draw.asm

Separator db ' = $'

CSEG ends
end Begin