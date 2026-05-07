include "Vram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 16
RowCount equ 11

; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    push af | push bc
        srl a
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        add a,c
        ld l,a | ld h,0
        ld bc,StageMap_ | add hl,bc
    pop bc | pop af
ret


cseg
MapPtr:
    ld b,a
    rrca | rrca | and 0fh 
    ld d,a
    ld a,e
    add a,a ;*2
    add a,a ;*4
    add a,d
    add a,low StageMap_ | ld l,a
    ld a,high StageMap_ | adc a,0 | ld h,a
    ld a,b
    and 3
ret

; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    push af | push hl | push de | push bc
        call MapPtr
        ld e,0fch
        or a
        do | while nz
            sla c | sla c
            rlc e | rlc e
            dec a
        wend
        ld a,(hl)
        and e
        or c
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push hl | push de | push bc
        call MapPtr
        ld e,(hl)
        or a
        do | while nz
            srl e | srl e
            dec a
        wend
        ld a,e
        and 03h
    pop bc | pop de | pop hl
ret