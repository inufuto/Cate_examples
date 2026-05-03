include "Vram.inc"
include "Chars.inc"

ext ReadVram_, WriteVram_

ColumnCount equ 16
RowCount equ 11

cseg
MapPtr:
    srl r0,8 ; column
    mov r0,r3
        srl r0,2 ; column/4
        srl r1,8-2 ; row*4
        a r0,r1
        ai r1,StageMap
    mov r3,r0
rt

; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
    dect r10 | mov r3,*r10
        bl @MapPtr
        li r3,>0300 ; mask
        andi r0,3 ; column mod 4
        if ne
            do
                sla r3,2
                sla r2,2 ; cell
                dec r0
            while ne | wend
        endif
        mov r1,r0
        bl @ReadVram_
        szcb r3,r0
        socb r2,r0
        movb r0,r3
        mov r1,r0
        mov r3,r1
        bl @WriteVram_
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r0
    mov *r10+,r11
rt


; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    dect r10 | mov r11,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
    dect r10 | mov r3,*r10
        bl @MapPtr

        mov r0,r2
        mov r1,r0
        bl @ReadVram_
        movb r0,r3
        mov r2,r0
        andi r0,3 ; column mod 4
        if ne
            do
                srl r3,2
                dec r0
            while ne | wend
        endif
        andi r3,3 shl 8
        mov r3,r0
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r11
rt
