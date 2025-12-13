include "ngp.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern

dseg
CharColors: public CharColors
    defs Char_End
VScroll: public VScroll
    defb 0
BackVram: public BackVram
    defs VramRowSize*BackVramHeight
BackVramChanged:
    defb 0

cseg
MonoPaletteValues:
    defb	00h, 02h, 05h, 07h
	defb	00h, 00h, 03h, 07h
ColorPaletteValues:
    defb	00h, 00h, 11h, 01h, 0d3h, 0fh, 0ffh, 0fh ; Fighter
    defb	00h, 00h, 0bfh, 00h, 0bbh, 0bh, 0ffh, 0fh ; Sand
	defb	00h, 00h, 70h, 00h, 0b0h, 00h, 0f0h, 00h ; Grass
    defb	0b0h, 00h, 0f0h, 00h, 0f0h, 0fh, 0b0h, 0fh ; Water
    defb	00h, 00h, 11h, 01h, 99h, 09h, 0ffh, 0fh ; GroundEnemy
	defb	00h, 00h, 0fh, 00h, 0bfh, 00h, 0ffh, 00h ; Bang
	defb	00h, 00h, 11h, 01h, 0dh, 03h, 0d3h, 0fh ; SkyEnemy
    defb	0b0h, 00h, 84h, 08h, 0f0h, 0fh, 00h, 0ah ; Item
	defb	00h, 00h, 0fh, 00h, 0d3h, 0fh, 0f0h, 00h ; Fort
ColorSource:
defb 45, 0h ;Ascii
defb 2, 1h ;Sand
defb 6, 2h ;Grass
defb 5, 3h ;Water
defb 12, 14h ;GroundEnemy
defb 24, 15h ;Bang
defb 52, 16h ;SkyEnemy
defb 4, 10h ;Fighter
defb 4, 17h ;Item
defb 84, 8h ;Fort
defb 0

cseg
InitVram: public InitVram
    ld (WBA.H),0
    ld (WBA.V),0
    ld (WSI.H),160
    ld (WSI.V),152
    ld (BackVramChanged),0

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
        ld bc,8*16/2
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

        xor l,l | ld (VScroll),l
        ld (S2SO.V),l
        
        di | ld (BackVramChanged),0 | ei
    pop hl
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


; word PrintC(word vram, byte c);
cseg
CharTable:
    defb " -0123456789:ABCEFGHIMNORSTUV"
PrintC_: public PrintC_
    push bc | push e | push xhl
        ld b,29
        xor e,e
        ld xhl,CharTable
        do
            cp c,(xhl)
            jr z,PrintC_break
            inc 1,xhl
            inc 1,e
        dwnz b
        xor e,e
        PrintC_break:
        ld c,e
        call Put_
    pop xhl | pop e | pop bc
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    di | ld (BackVramChanged),1 | ei
ret


SwitchVram: public SwitchVram
    cp (BackVramChanged),0
    ret z
    push a | push xhl | push xde | push bc
        ld xhl,BackVram
        ld xde,VramBack
        ld bc,VramWidth*BackVramHeight
        ldirw

        ld a,(VScroll)
        ld (S2SO.V),a

        ld (BackVramChanged),0
    pop bc | pop xde | pop xhl | pop a
ret
