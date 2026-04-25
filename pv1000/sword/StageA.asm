include "VVram.inc"
include "Chars.inc"

ext StageMap_
ext VVram_

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

; void SetCell(byte column, byte row, byte cell);
cseg
SetCell_: public SetCell_
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


; void DrawStage();
cseg
DrawStage_: public DrawStage_
    push af | push hl | push de | push bc
        ld de,StageMap_
        ld hl,VVram_
        ld c,RowCount
        do
            ld b,ColumnCount/4
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        ld c,4
                        do
                            ld de,VVramWidth-1
                            push af
                                and 3
                                if z
                                    ld a,Char_Space
                                    ld b,2
                                    do
                                        ld (hl),a | inc hl
                                        ld (hl),a
                                        add hl,de
                                    dwnz
                                else
                                    dec a
                                    add a,a | add a,a
                                    add a,Char_Wall
                                    ld b,2
                                    do
                                        ld (hl),a | inc hl
                                        inc a
                                        ld (hl),a
                                        inc a
                                        add hl,de
                                    dwnz
                                endif
                    _deb: public _deb
                                ld de,2-VVramWidth*2 | add hl,de
                            pop af
                            rrca | rrca
                            dec c
                        while nz | wend
                    pop de
                pop bc
            dwnz
            push de
                ld de,VVramWidth | add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret