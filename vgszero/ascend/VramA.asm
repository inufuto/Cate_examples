include "vgszero.inc"
include "Vram.inc"

dseg
HScroll_: public HScroll_
    defb 0
VScroll_: public VScroll_
    defb 0

cseg
PaletteValues:
	defb	00h, 00h, 0dah, 28h, 00h, 7ch, 5ah, 6ah
	defb	0e0h, 03h, 0ffh, 5bh, 0e0h, 7fh, 0ffh, 7fh
	defb	00h, 00h, 0ceh, 39h, 4ah, 5eh, 4ah, 59h
	defb	0c0h, 01h, 52h, 01h, 0d2h, 6ah, 0d6h, 5ah
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


ext Background_
ext dotOffset_, topY_, yMod_

; void BackgroundToVram();
cseg
BackgroundToVram_: public BackgroundToVram_
    push af | push hl | push de | push bc
        do
            ld a,(VdpStatus)
            and 80h
        while z | wend
        do
            ld a,(VdpStatus)
            and 80h
        while nz | wend

        ld hl,VramRowSize*28
        ld de,Background_
        ld bc,BgNameTable
        out (memcpyDMA),a
        
        ; call UpdateOffset_
        ld a,(VScroll_)
        ld (BgScrollY),a
    pop bc | pop de | pop hl | pop af
ret


; void UpdateOffset();
cseg
UpdateOffset_: public UpdateOffset_
    push af | push de
        ld a,(dotOffset_)
        ld e,a
        ld a,(topY_)
        and 3
        add a,a | add a,a | add a,a
        sub e
        sub 8
        ld (VScroll_),a
    pop de | pop af
ret
; {
;     VScroll = ((topY & 3) << CoordShift) - dotOffset - 8;
;     UpdateScroll();
; }
