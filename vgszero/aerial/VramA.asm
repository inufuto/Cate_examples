include "vgszero.inc"
include "Vram.inc"
include "Chars.inc"

ext CellMap_,LeftX_,DotOffset_

; dseg
; HScroll_: public HScroll_
;     defb 0

cseg
PaletteValues:
	defb	00h, 00h, 1fh, 00h, 00h, 7ch, 0ffh, 7dh
	defb	0e0h, 03h, 7bh, 03h, 0e0h, 7fh, 0ffh, 7fh
	defb	00h, 00h, 0efh, 6eh, 07h, 6ch, 0ebh, 5dh
	defb	77h, 5fh, 0efh, 01h, 6bh, 7eh, 73h, 4eh
InitVram: public InitVram
    ld hl,PaletteValues
    ld de,PaletteTable
    ld bc,16*2
    ldir

    ld a,PatternBank
    ld (BgDirectPatternMapping),a
    ld (FgDirectPatternMapping),a
    ld (SpriteDirectPatternMapping),a
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearA:
    do
        ld (hl),80h | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,BgNameTable
        ld bc,32*32
        call Clear

        ld hl,FgNameTable
        ld bc,32*32
        call Clear

        ld hl,BgAttribute
        ld bc,32*32
        call ClearA

        ld hl,FgAttribute
        ld bc,32*32
        call ClearA

        xor a | ld (BgScrollX),a
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    inc hl
ret


; word VramOffset(byte x, byte y);
VramOffset_: public VramOffset_
    push de
        ld l,e
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,a
        ld d,0
        add hl,de
    pop de
ret

ext Ground_, DotOffset_, mapX_

; void GroundToVram();
cseg
GroundToVram_: public GroundToVram_
    push af | push hl | push de | push bc
        ld hl,VramBack+VramRowSize*2
        ld bc,VramRowSize*10
        do
            ld (hl),Char_Space | inc hl
            dec bc
            ld a,c | or b
        while nz | wend

        ld de,Ground_
        ex de,hl
        ld bc,VramRowSize*10
        ldir
        ex de,hl

        ld bc,VramRowSize*2
        do
            ld (hl),Char_Ground | inc hl
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
; ret


; void UpdateScroll();
cseg
UpdateScroll_: public UpdateScroll_
    push af | push bc
        ; ld a,(mapX_)
        ; rlca | rlca | rlca
        ; and 8
        ; ld c,a

        ld a,(DotOffset_)
        ; add a,c
        sub 8
        ld (BgScrollX),a
    pop bc | pop af
ret
