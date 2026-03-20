include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext MonoChars, ColorPattern, SpritePattern
ext VVram_

PagePort equ $ff30

CharPatternSize equ CharWidth*CharHeight/2
SpritePatternSize equ SpriteWidth*SpriteHeight/2

cseg
PaletteValues:
defb	$00, $00, $00, $00, $00, $ff, $ff, $00
defb	$00, $ff, $00, $ff, $00, $ff, $00, $00
defb	$ff, $ff, $ff, $ff, $00, $ff, $ff, $ff
defb	$00, $00, $00, $00, $55, $ff, $ff, $00
defb	$bb, $bb, $00, $bb, $00, $ff, $bb, $00
defb	$bb, $bb, $ff, $bb, $00, $bb, $bb, $bb

ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 1, 1 ; Fence
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

dseg
pNextPage_: public pNextPage_
    defw 0

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
        cpx #VramOrg+$800
    while ne | wend

    clr PagePort
    ldx #VramOrg+$400 | stx pNextPage_
rts


scope
; word VramOffset(byte x, byte y);
dseg
VramOffset_@Param1: public VramOffset_@Param1
VramOffset_y:
    defb 0
cseg
VramOffset_: public VramOffset_
    psha | pshb
        staa @Temp@Byte
        ldab VramOffset_y
        aslb | aslb | aslb  ;*8
        clra
        aslb | rola ;*16
        aslb | rola ;*32
        addb @Temp@Byte
        staa @Temp@Word | stab @Temp@Word+1
        ldx @Temp@Word
    pulb | pula
rts
endscope

scope
pVram equ @Temp@Word

cseg
Put:
    staa 0,x
    stx pVram
    ldab pVram
    addb #$04
    stab pVram
    ldx pVram
    staa 0,x
    subb #$04
    stab pVram
    ldx pVram
    inx
rts

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
    psha | pshb
        ldx Put_pVram
        ldaa Put_c
        bsr Put
    pulb | pula
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    psha | pshb
        ldx Put_pVram
        ldaa Put_c
        suba #$20
        bsr Put
    pulb | pula
rts
endscope


scope
; void ClearPage(); 
cseg
ClearPage_: public ClearPage_
    psha | pshb
        ldx pNextPage_ 
        ldab #VramHeight
        do
            pshb
                ldab #WindowWidth
                do
                    clr 0,x | inx
                    decb
                while ne | wend
            pulb
            decb
        while ne | wend
    pulb | pula
rts
endscope


; void SwitchPage();
cseg
SwitchPage_: public SwitchPage_
    psha | pshb
        ldaa pNextPage_
        tab
        lsra | lsra
        staa PagePort
        tba
        eora #$04 ; Toggle bit 2
        staa pNextPage_
    pulb | pula
rts
