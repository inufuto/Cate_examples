include "vgszero.inc"
include "Vram.inc"
include "VVram.inc"

ext VVram_

cseg
PaletteValues:
	defb	00h, 00h, 1fh, 00h, 00h, 7ch, 1fh, 7ch
	defb	0e0h, 03h, 0ffh, 03h, 0e0h, 7fh, 0ffh, 7fh
	defb	00h, 00h, 7fh, 01h, 17h, 7ch, 17h, 5ch
	defb	0f7h, 03h, 0f7h, 02h, 0e0h, 7eh, 0f7h, 5eh
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


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld de,VramBack+VramRowSize*2
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(hl) | inc hl
                ld (de),a | inc de
            dwnz
            inc de | inc de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret