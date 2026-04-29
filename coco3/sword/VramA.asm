include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern, SpritePattern

INIT1 equ $FF91
VramTop equ Vram+VramRowSize*2

dseg
Backup: ;public Backup
    defs VVramWidth*VVramHeight
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
PatternRam:
    defs PatternSize*$100
NextSpriteChar:
    defb 0

zseg
charColor:
    defb 0
charCount:
    defb 0
yCount:
    defb 0
xCount:
    defb 0
pattern:
    defb 0
bitCount:
    defb 0

cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 14 ; Logo
defb 0
InitVram: public InitVram
    pshs u,cc | orcc #$50
        ldy #MonoPattern
        ldx #PatternRam
        ldu #ColorTable
        do
            ldb 0,u
        while ne
            leau 1,u
            lda 0,u
            leau 1,u
            bsr MakePatternMono
        wend
        ldy #ColorPattern
        ldx #PatternRam+PatternSize*Char_Color
        ldb #Char_End-Char_Color
        bsr MakePatternColor
    puls u,cc
rts

MakePatternMono:
    std charColor
    do
        lda #CharHeight | sta yCount
        do
            ldb ,y+
            lda #VramStep | sta xCount
            do
                clr pattern
                lda #2 | sta bitCount
                do
                    lda pattern
                    lsla | lsla | lsla | lsla
                    sta pattern

                    lda charColor
                    bitb #$80
                    if ne
                        lda charColor
                        anda #$0f
                    else
                        lsra | lsra | lsra | lsra
                    endif
                    ora pattern
                    sta pattern

                    lslb
                    dec bitCount
                while ne | wend
                lda pattern | sta ,x+
                dec xCount
            while ne | wend
            dec yCount
        while ne | wend
        dec charCount
    while ne | wend
rts


MakePatternColor:
    lda #PatternSize
    mul
    do
        pshs a,b
            lda ,y+ | sta ,x+
        puls a,b
        subd #1
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs a,b,x,y
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldx #Vram
            do
                clr ,x+
                cmpx #Vram+VramRowSize*VramHeight
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc

        ldx #Backup
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        ; ldx #VVram_
        ; ldd #VVramWidth*VVramHeight*2
        ; do
        ;     clr ,x+
        ;     subd #1
        ; while ne | wend
    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y
        lda #PatternSize
        mul
        ldy #PatternRam
        leay d,y
        
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldb #CharHeight
            do
                pshs b
                    ldb #VramStep
                    do
                        lda ,y+
                        sta ,x+
                        decb
                    while ne | wend
                    leax VramWidth-VramStep,x
                puls b
                decb
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc
    puls a,b,x,y    
    tfr	x,d
    addd #VramStep
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    pshs y
        ldy #CharTable
        clra
        do
            cmpb ,y+
            beq PrintC_break
            inca
            cmpa #30
        while cs | wend
        clra
        PrintC_break:
        tfr a,b
        bsr Put_
    puls y
rts


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    pshs a,b,x,y
        ldx #VVram_
        ldy #SpriteLayer
        do
            ldd ,x++
            std ,y++
            cmpx #VVram_+VVramWidth*VVramHeight
        while ne | wend

        lda #Char_End | sta NextSpriteChar
    puls a,b,x,y
rts


; void EndDraw();
zseg
pVram:
    defw 0
cseg
EndDraw_: public EndDraw_
    pshs a,b,x,y
        ldx #VramTop | stx pVram
        ldx #SpriteLayer
        ldy #Backup
        lda #VVramHeight | sta yCount
        do
            lda #VVramWidth | sta xCount
            do 
                ldb ,x+
                cmpb #Char_End
                bcc EndDraw_update
                cmpb ,y
                if ne
                    EndDraw_update:
                    stb ,y
                    pshs x
                        ldx pVram
                        bsr Put_
                        std pVram
                    puls x
                else
                    ldd pVram
                    addd #VramStep
                    std pVram
                endif
                leay 1,y
                dec xCount
            while ne | wend
            ldd pVram
            addd #VramRowSize-VVramWidth*VramStep
            std pVram
            dec yCount
        while ne | wend
    puls a,b,x,y
rts


; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
zseg
pSpriteLayer:
    defw 0
pSpritePattern:
    defw 0
pSource:
    defw 0
xCount2:
    defb 0
yCount2:
    defb 0
mixedByte:
    defb 0
cseg
DrawSprite_: public DrawSprite_
    pshs a,b,x,y
        sta pSpriteLayer+1 | clr pSpriteLayer ; x
        lda #VVramWidth | mul
        addd pSpriteLayer
        addd #SpriteLayer
        std pSpriteLayer

        lda DrawSprite_pattern | clrb
        lsra | rorb
        addd #SpritePattern
        std pSpritePattern

        lda #2 | sta yCount
        do
            lda #2 | sta xCount
            do
                ldx pSpriteLayer
                lda ,x

                ldb #PatternSize | mul
                addd #PatternRam
                std pSource

                lda NextSpriteChar
                inc NextSpriteChar
                sta ,x+
                stx pSpriteLayer

                ldb #PatternSize | mul
                addd #PatternRam
                tfr d,y

                lda #CharHeight | sta yCount2
                do
                    lda #VramStep | sta xCount2
                    do
                        clr mixedByte
                        ldx pSpritePattern | lda ,x+ | stx pSpritePattern
                        ldx pSource | ldb ,x+ | stx pSource
                        pshs a,b
                            anda #$f0
                            if eq
                                tfr b,a
                                anda #$f0
                            endif
                            sta mixedByte
                        puls a,b
                        anda #$0f
                        if eq
                            tfr b,a
                            anda #$0f
                        endif
                        ora mixedByte
                        sta ,y+

                        dec xCount2
                    while ne | wend
                    dec yCount2
                while ne | wend
                dec xCount
            while ne | wend
            ldx pSpriteLayer
            leax VVramWidth-2,x
            stx pSpriteLayer

            dec yCount
        while ne | wend
    puls a,b,x,y
rts
