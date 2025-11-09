include "vgszero.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern
ext VVram_

dseg
HScroll_: public HScroll_
    defb 0
TerrainCharOffset: public TerrainCharOffset
    defb 0


cseg
PaletteValues:
	defb	00h, 00h, 1fh, 00h, 00h, 7ch, 1fh, 7ch
	defb	0e0h, 03h, 0ffh, 03h, 0e0h, 7fh, 0ffh, 7fh
	defb	00h, 00h, 14h, 00h, 00h, 50h, 40h, 01h
	defb	80h, 02h, 9fh, 02h, 80h, 7eh, 94h, 52h
ColorSource:
defb 29, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
    ld hl,PaletteValues
    ld de,PaletteTable
    ld bc,16*2
    ldir

    ld a,CharPatternBank
    out (RomToCharacterDma),a
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

        ld a,TerrainCharCount | ld (TerrainCharOffset),a
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    inc hl
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    push af | push de | push bc
        push hl
            ld a,e
            ld bc,29*256
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
        pop hl
        ld (hl),c
        inc hl
    pop bc | pop de | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld de,VramBack
        ld bc,VVramWidth*VVramHeight
        ldir

        ld a,(TerrainCharOffset)
        xor TerrainCharCount
        ld (TerrainCharOffset),a
    pop bc | pop de | pop hl | pop af
ret
