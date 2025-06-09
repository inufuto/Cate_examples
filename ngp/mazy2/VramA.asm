include "ngp.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern

dseg
CharColors: public CharColors
    defs Char_End


cseg
MonoPaletteValues:
    defb	00h, 02h, 04h, 07h
	defb	00h, 00h, 03h, 07h
ColorPaletteValues:
    defb	00h, 00h, 11h, 01h, 93h, 0fh, 0ffh, 0fh ; Logo/Wall
    defb	00h, 00h, 50h, 09h, 5bh, 05h, 0ffh, 0fh ; Man
    defb	00h, 00h, 11h, 01h, 9fh, 0dh, 0ffh, 0fh ; Chaser
    defb	00h, 00h, 11h, 01h, 7dh, 07h, 70h, 00h ; Disturber
    defb	00h, 00h, 0bbh, 0bh, 0bdh, 09h, 0ffh, 0fh ; Knife
    defb	00h, 00h, 59h, 03h, 0bbh, 0bh, 0ffh, 0fh ; Color16
ColorSource:
defb 64, 0h ;Ascii
defb 16, 0h ;Logo
defb 72, 11h ;Man
defb 4, 12h ;Chaser
defb 4, 13h ;Disturber
defb 16, 14h ;Knife
defb 16, 10h ;Point
defb 12, 5h ;Stair
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


; byte ReadVram(ptr<byte> pVram);
cseg
ReadVram_: public ReadVram_
    ld a,(xwa)
ret
