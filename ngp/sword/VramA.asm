include "ngp.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern

dseg
CharColors: public CharColors
    defs Char_End


cseg
MonoPaletteValues:
    defb	00h, 01h, 03h, 07h
	defb	00h, 00h, 02h, 07h
ColorPaletteValues:
    defb	00h, 00h, 00h, 00h, 0f0h, 0dh, 0ffh, 0fh; 0:man
	defb	00h, 00h, 0bh, 00h, 0fh, 00h, 0cfh, 03h; 1:box
	defb	00h, 00h, 00h, 0bh, 0b0h, 0fh, 0ffh, 0fh; 2:wall
	defb	00h, 00h, 0f0h, 0bh, 8fh, 04h, 0ffh, 0fh ; 3:item
	defb	00h, 00h, 00h, 00h, 0cch, 0ch, 0ffh, 0fh ; 4:ball
	defb	00h, 00h, 00h, 00h, 11h, 0fh, 0f8h, 00h ; 5:ball
ColorSource:
defb 64, 0h ;Ascii
defb 15, 1h ;Logo
defb 4, 2h ;Wall
defb 4, 1h ;Box
defb 4, 3h ;Item
defb 64, 10h ;Man
defb 32, 10h ;Monster
defb 4, 14h ;Ball
defb 16, 10h ;Point
defb 4, 15h ;Oneup
defb 0

cseg
InitVram: public InitVram
    ld (WBA.H),0
    ld (WBA.V),0
    ld (WSI.H),160
    ld (WSI.V),152

    ld a,(Version)
    or a,a
    if z
        call InitMono
        ld e,10h
    else
        call InitColor
        ld e,0fh
    endif

    ld xix,ColorSource
    ld xiy,CharColors
    do
        ld w,(xix+)
        or w,w
    while nz
        ld a,(xix+)
        and a,e
        do
            ld (xiy+),a
        dwnz w
    wend
ret

InitMono: public InitMono
    ld xhl,MonoPattern
    ld xde,0a000h
    ld bc,16*Char_End/2
    ldirw

    ld xde,MonoPalette
    ld c,3
    do
        ld xhl,MonoPaletteValues
        ld b,2
        do
            inc 1,xhl | inc 1,xde
            ld a,(xhl+) | ld (xde+),a
            ld a,(xhl+) | ld (xde+),a
            ld a,(xhl+) | ld (xde+),a
        dwnz b
    dwnz c
ret

InitColor: public InitColor
    ld (ModeSelectionRegister),0

    ld xhl,ColorPattern
    ld xde,0a000h
    ld bc,16*Char_End/2
    ldirw

    ld xde,ColorPalette
    ld a,4
    do
        ld xhl,ColorPaletteValues
        ld bc,16*8/2
        ldirw
    dwnz a
    ld xde,BackgroundColorPalette
    ld xhl,ColorPaletteValues
    ld bc,16/2
    ldirw
ret


; void ClearScreen();
cseg
ClearScreen_:  public ClearScreen_
    push hl
        ld xhl,VramFrontOrg
        do
            ldw (xhl+),0
            cp hl,VramFrontOrg+1000h
        while nz | wend
    pop hl
ret


; word VramOffset(byte x, byte y);
VramOffset_: public VramOffset_
    push bc
        mul bc,VramWidth
        xor w,w
        add wa,bc
        sll 1,wa
    pop bc
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push b | push xhl
        ld xhl,CharColors
        xor b,b
        ld b,(xhl+bc)
        sll 1,b
        ld qwa,0
        ld (xwa+),bc
    pop xhl | pop b
ret
