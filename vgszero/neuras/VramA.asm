include "vgszero.inc"
include "Vram.inc"

dseg
HScroll_: public HScroll_
    defb 0

cseg
PaletteValues:
	defb	00h, 00h, 0fbh, 2ch, 00h, 7ch, 7bh, 6eh
	defb	0e0h, 03h, 0fbh, 03h, 67h, 7fh, 0ffh, 7fh
	defb	00h, 00h, 0efh, 3dh, 67h, 4dh, 6bh, 5dh
	defb	0e0h, 01h, 73h, 01h, 67h, 7fh, 0f7h, 5eh
InitVram: public InitVram
    ld hl,PaletteValues
    ld de,PaletteTable
    ld bc,16*2
    ldir

    ld a,TileBank
    ld (BgDirectPatternMapping),a
    ld (FgDirectPatternMapping),a

    ld a,SpriteBank
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
