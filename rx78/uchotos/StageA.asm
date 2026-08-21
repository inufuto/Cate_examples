include "VVram.inc"
include "Chars.inc"

ext StageMap_
ext VVram_

ColumnCount equ 16
; FloorCount equ 6
; RowCount equ FloorCount*2
; ColumnsPerByte equ 2
; Cell_Debri equ 0ch

cseg
MapPtr:
    ld b,a
    rrca | and 7fh 
    ld d,a
    ld a,e
    add a,a ;*2
    add a,a ;*4
    add a,a ;*8
    add a,d
    add a,low StageMap_ | ld l,a
    ld a,high StageMap_ | adc a,0 | ld h,a
    ld a,b
    and 1
ret

; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    push af | push de | push bc
        call MapPtr
    pop bc | pop de | pop af
ret


; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    push af | push hl | push de | push bc
        call MapPtr
        if nz
            ld a,(hl)
            and 0fh
            sla c | sla c | sla c | sla c
        else
            ld a,(hl)
            and 0f0h
        endif
        or c
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    push hl | push de | push bc
        call MapPtr
        ld a,(hl)
        if nz
            rrca | rrca | rrca | rrca
        endif
        and 0fh
    pop bc | pop de | pop hl
ret


; ; void DrawStage();
; cseg
; Chars:
;     defb Char_Space, Char_Space, Char_Space, Char_Space
;     defb Char_Floor, Char_Floor, Char_Space, Char_Space
;     defb Char_Ladder_Left, Char_Ladder_Right, Char_Ladder_Left, Char_Ladder_Right
;     defb Char_Item + 0, Char_Item + 1, Char_Item + 2, Char_Item + 3
; DrawStage_: public DrawStage_
;     push af | push hl | push de | push bc
;         exx
;             ld hl,VVram_
;         exx
;         ld de,StageMap_
;         ld h,RowCount-1
;         do
;             ld c,ColumnCount/ColumnsPerByte
;             do
;                 ld a,(de) | inc de
;                 ld l,a
;                 ld b,ColumnsPerByte
;                 do
;                     ld a,l
;                     and Cell_Debri
;                     if nz
;                         exx
;                             ld de,VVramWidth-2
;                             ld a,Char_Monster_Fall
;                             ld c,2
;                             do
;                                 ld b,2
;                                 do
;                                     ld (hl),a | inc hl
;                                     inc a
;                                 dwnz
;                                 add hl,de
;                                 dec c
;                             while nz | wend
;                             ld de,2-VVramWidth*2 | add hl,de
;                         exx
;                     else
;                         ld a,l
;                         exx
;                             and 3
;                             add a,a | add a,a
;                             add a,low Chars | ld e,a
;                             ld a,high Chars | adc a,0 | ld d,a
;                             ld c,2
;                             do
;                                 ld b,2
;                                 do
;                                     ld a,(de) | inc de
;                                     ld (hl),a | inc hl
;                                 dwnz
;                                 ld a,l | add a,VVramWidth-2 | ld l,a
;                                 ld a,h | adc a,0 | ld h,a
;                                 dec c
;                             while nz | wend
;                             ld de,2-VVramWidth*2 | add hl,de
;                         exx                             
;                     endif
;                     ld a,l
;                     rrca | rrca | rrca | rrca
;                     ld l,a
;                 dwnz
;                 dec c
;             while nz | wend
;             exx
;                 ld de,VVramWidth*2-2*ColumnCount | add hl,de
;             exx
;             dec h
;         while nz | wend
;     pop bc | pop de | pop hl | pop af
; ret