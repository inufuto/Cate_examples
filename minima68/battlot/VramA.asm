include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext MonoChars, ColorPattern, SpritePattern


CharPatternSize equ CharWidth*CharHeight/2
SpritePatternSize equ SpriteWidth*SpriteHeight/2

cseg
PaletteValues:
defb	$00, $00, $00, $77, $cc, $88, $99, $33
defb	$00, $ff, $bb, $bb, $22, $55, $00, $77
defb	$cc, $cc, $dd, $ff, $99, $ff, $ff, $ff
defb	$44, $44, $44, $dd, $99, $22, $ff, $00
defb	$00, $ff, $ff, $00, $99, $55, $33, $11
defb	$77, $77, $ff, $99, $55, $cc, $cc, $cc

ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 4, 12 ; Wall
defb 1, 15 ; HardWall
defb 2, 11 ; Meter
defb 0

scope
pSource equ @Temp@Word
pDestination equ @Temp@Word2
pColorTable equ @Temp@Word3
charCount equ @Temp@Byte
charColor equ @Temp@Byte2
byteCount equ @Temp@Byte3
dotCount equ @Temp@Byte4
nibbleCount equ @Temp@Byte5
charByte equ @Temp@Byte6

cseg
InitVram: public InitVram
    bsr InitPalette
    bsr InitMonoPattern
    bsr InitColorPattern
    bsr InitSpritePattern
rts

InitPalette:
    ldx #PaletteValues | stx pSource
    ldx #PaletteRam | stx pDestination
    ldab #3*ColorCount
    do
        ldx pSource | ldaa 0,x | inx | stx pSource
        ldx pDestination | staa 0,x | inx | stx pDestination
        decb
    while ne | wend
rts

InitMonoPattern:
    ldx #ColorTable | stx pColorTable
    ldx #MonoChars | stx pSource
    ldx #CharPatternRam | stx pDestination
    do
        ldx pColorTable
        ldaa 0,x
    while ne
        inx | staa charCount
        ldaa 0,x | inx | staa charColor
        stx pColorTable
        do
            ldaa #CharWidth*CharHeight/8 | staa byteCount
            do
                ldx pSource | ldab 0,x | inx | stx pSource
                ldx pDestination
                ldaa #8/2 | staa dotCount
                do
                    clr charByte
                    ldaa #2 | staa nibbleCount
                    do
                        ldaa charByte
                        asla | asla | asla | asla
                        staa charByte

                        ldaa charColor
                        aslb
                        if cc
                            lsra | lsra | lsra | lsra
                        endif
                        anda #$0f
                        oraa charByte
                        staa charByte

                        dec nibbleCount
                    while ne | wend
                    ldaa charByte
                    staa 0,x | inx | stx pDestination
                    dec dotCount
                while ne | wend
                dec byteCount
            while ne | wend
            dec charCount
        while ne | wend
    wend
rts

InitColorPattern:
    ldx #ColorPattern | stx pSource
    ldx #CharPatternRam+CharPatternSize*Char_Color | stx pDestination
    ldaa #Char_End-Char_Color | staa charCount
    do
        ldab #CharPatternSize
        do
            ldx pSource | ldaa 0,x | inx | stx pSource
            ldx pDestination | staa 0,x | inx | stx pDestination
            decb
        while ne | wend
        dec charCount
    while ne | wend
rts

InitSpritePattern:
    ldx #SpritePattern | stx pSource
    ldx #SpritePatternRam | stx pDestination
    ldaa #Pattern_End | staa charCount
    do
        ldab #SpritePatternSize
        do
            ldx pSource | ldaa 0,x | inx | stx pSource
            ldx pDestination | staa 0,x | inx | stx pDestination
            decb
        while ne | wend
        dec charCount
    while ne | wend

    ldaa #-SpriteHeight
    ldx #SpriteAttributeRam
    do
        staa 0,x | inx
        cpx #SpriteAttributeRam+4*MaxSpriteCount
    while ne | wend
rts
endscope


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    ldx #VramOrg
    do
        clr 0,x | inx
        cpx #VramOrg+VramRowSize*32
    while ne | wend
rts


scope
; ptr<byte> VramPtr(byte x, byte y);
dseg
VramPtr_@Param1: public VramPtr_@Param1
VramPtr_y:
    defb 0
cseg
VramPtr_: public VramPtr_
    psha | pshb
        staa @Temp@Byte
        ldab VramPtr_y
        aslb | aslb | aslb  ;*8
        clra
        aslb | rola ;*16
        aslb | rola ;*32
        addb @Temp@Byte
        addb #low Vram | adca #high Vram
        staa @Temp@Word
        stab @Temp@Word+1
        ldx @Temp@Word
    pulb | pula
rts
endscope

scope
; ptr<byte> Put(ptr<byte> pVram, byte c, byte color);
dseg
Put_@Param0: public Put_@Param0
PrintC_@Param0: public PrintC_@Param0
Put_pVram:
    defw 0
Put_@Param1: public Put_@Param1
PrintC_@Param1: public PrintC_@Param1
Put_c:
    defb 0
cseg
Put_: public Put_
    psha
        ldx Put_pVram
        ldaa Put_c
        staa 0,x
        inx
    pula
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    psha
        ldx Put_pVram
        ldaa Put_c
        suba #$20
        staa 0,x
        inx
    pula
rts
endscope