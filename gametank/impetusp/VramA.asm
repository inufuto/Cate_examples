include "ZeroPage.inc"
include "gametank.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext AsciiPattern,MonoPattern,ColorPattern,SpritePattern,FortPattern
ext VVram_

AsciiPalette equ 7
AsciiCount equ 29

pVram equ ZW0
pSource equ ZW1
pPattern equ ZW2
pVVram equ ZW3
charCount equ ZB0
monoColor equ ZB1
xCount equ ZB1
yCount equ ZB2
sourceByte equ ZB3
yCount2 equ ZB4

dseg
AsciiPatternRam: public AsciiPatternRam
    defs CharWidth*AsciiHeight*AsciiCount
CharPatternRam: public CharPatternRam
    defs CharWidth*CharHeight*Char_End
Backup:
    defs VVramWidth*VVramHeight
ScrollY_: public ScrollY_
    defb 0

zseg
BankRegValue:; public BankRegValue
    defb 0
DmaFlagsValue:; public DmaFlagsValue
    defb 0
BltBusy:; public BltBusy
    defb 0
pBackup:
    defw 0
cseg
PaletteValues:
	defb	$00, $98, $5b, $7f, $fe, $bf, $1f, $07
	defb	$01, $06, $3b, $f9, $fb, $bc, $3f, $05
ColorTable:
defb 16,5 ; Logo
defb 0
    

cseg
IrqHandler: public IrqHandler
    pha
        stz BLT_START
        stz <BltBusy
    pla
rti


cseg
InitVram: public InitVram
    lda #DMA_NMI or DMA_GCARRY
    sta <DmaFlagsValue | sta DMA_FLAGS

    lda #BANK_SECOND_FRAMEBUFFER or BANK_CLIP_X or BANK_CLIP_Y
    sta <BankRegValue | sta BANK_REG

    jsr InitAsciiPattern
    jsr InitMonoPattern
    jsr InitColorPattern
    jsr InitSpritePattern
    jsr InitFortPattern
rts

MonoByte:
    ldy #0
    do
        asl <sourceByte
        if cs
            lda <monoColor
        else
            lda #0
        endif
        sta (pPattern),y
        iny
        cpy #CharWidth*2
    while ne | wend
    lda <pPattern | clc|adc #CharWidth*2 | sta <pPattern
    lda <pPattern+1 | adc #0 | sta <pPattern+1
rts

InitAsciiPattern:
    lda #AsciiPalette | sta <monoColor
    lda #low AsciiPatternRam | sta <pPattern
    lda #high AsciiPatternRam | sta <pPattern+1
    ldx #0
    lda #AsciiHeight/2*AsciiCount | sta <yCount
    do
        lda AsciiPattern,x | inx | sta <sourceByte
        jsr MonoByte
        dec <yCount
    while ne | wend
rts

InitMonoPattern:
    lda #low CharPatternRam | sta <pPattern
    lda #high CharPatternRam | sta <pPattern+1

    lda #low MonoPattern | sta <pSource
    lda #high MonoPattern | sta <pSource+1

    ldx #0
    do
        lda ColorTable,x
    while ne
        inx
        sta <charCount
        lda ColorTable,x | inx
        phx
            tay | lda PaletteValues,y | sta <monoColor
            do
                ldy #0
                do
                    lda (<pSource),y | iny | sta <sourceByte
                    phy
                        jsr MonoByte
                    ply
                    cpy #CharHeight/2
                while ne | wend
                lda <pSource | clc|adc #CharHeight/2 | sta <pSource
                lda <pSource+1 | adc #0 | sta <pSource+1

                dec <charCount
            while ne | wend
        plx
    wend
rts

InitColorPattern:
    lda #low ColorPattern | sta <pSource
    lda #high ColorPattern | sta <pSource+1
    
    lda #Char_End-Char_Color | sta <charCount
    do
        ldy #0
        lda #CharHeight*CharWidth/2 | sta <yCount
        do
            lda (<pSource) | sta <sourceByte
            lsr a | lsr a | lsr a | lsr a
            tax | lda PaletteValues,x
            sta (<pPattern),y
            iny

            lda <sourceByte
            and #$0f
            tax | lda PaletteValues,x
            sta (<pPattern),y
            iny

            inc <pSource
            if eq
                inc <pSource+1
            endif
            dec <yCount
        while ne | wend
        lda <pPattern | clc|adc #CharHeight*CharWidth | sta <pPattern
        lda <pPattern+1 | adc #0 | sta <pPattern+1

        dec <charCount
    while ne | wend
rts

InitSpritePattern:
    ldy #VramHeight | jsr DummyBlt

    lda <DmaFlagsValue
    and #not(DMA_ENABLE or DMA_CPU_TO_VRAM)
    sta <DmaFlagsValue | sta DMA_FLAGS

    lda #low SpritePattern | sta <pSource
    lda #high SpritePattern | sta <pSource+1

    lda #low VramOrg | sta <pVram
    lda #high VramOrg | sta <pVram+1
    
    lda #(Pattern_End+15)/16 | sta <charCount
    do
        lda #16 | sta <xCount
        do
            lda #SpriteHeight | sta <yCount
            do
                ldy #0
                ldx #SpriteWidth/2
                do
                    lda (<pSource) | sta <sourceByte
                    lsr a | lsr a | lsr a | lsr a
                    phx
                        tax | lda PaletteValues,x
                    plx
                    sta (<pVram),y
                    iny

                    lda <sourceByte
                    and #$0f
                    phx
                        tax | lda PaletteValues,x
                    plx
                    sta (<pVram),y
                    iny

                    inc <pSource
                    if eq
                        inc <pSource+1
                    endif

                    dex
                while ne | wend

                lda <pVram | clc|adc #VramWidth | sta <pVram
                lda <pVram+1 | adc #0 | sta <pVram+1

                dec <yCount
            while ne | wend
            lda <pVram | clc|adc #low(SpriteWidth-VramWidth*SpriteHeight) | sta <pVram
            lda <pVram+1 | adc #high(SpriteWidth-VramWidth*SpriteHeight) | sta <pVram+1

            dec <xCount
        while ne | wend
        lda <pVram | clc|adc #low(VramWidth*SpriteHeight-SpriteWidth*16) | sta <pVram
        lda <pVram+1 | adc #high(VramWidth*SpriteHeight-SpriteWidth*16) | sta <pVram+1

        dec <charCount
    while ne | wend
rts

FortPatternY equ CharHeight*2*2
FortWidth equ 6
FortHeight equ 6

InitFortPattern:
    lda #low FortPattern | sta <pSource
    lda #high FortPattern | sta <pSource+1

    lda #low(VramOrg+VramWidth*FortPatternY) | sta <pVram
    lda #high(VramOrg+VramWidth*FortPatternY) | sta <pVram+1
    
    lda #FortHeight | sta <yCount
    do
        lda #FortWidth | sta <xCount
        do
            lda #CharHeight | sta <yCount2
            do
                ldy #0
                ldx #CharWidth/2
                do
                    lda (<pSource) | sta <sourceByte
                    lsr a | lsr a | lsr a | lsr a
                    phx
                        tax | lda PaletteValues,x
                    plx
                    sta (<pVram),y
                    iny

                    lda <sourceByte
                    and #$0f
                    phx
                        tax | lda PaletteValues,x
                    plx
                    sta (<pVram),y
                    iny

                    inc <pSource
                    if eq
                        inc <pSource+1
                    endif

                    dex
                while ne | wend

                lda <pVram | clc|adc #VramWidth | sta <pVram
                lda <pVram+1 | adc #0 | sta <pVram+1

                dec <yCount2
            while ne | wend
            lda <pVram | clc|adc #low(CharWidth-VramWidth*CharHeight) | sta <pVram
            lda <pVram+1 | adc #high(CharWidth-VramWidth*CharHeight) | sta <pVram+1

            dec <xCount
        while ne | wend
        lda <pVram | clc|adc #low(VramWidth*CharHeight-CharWidth*FortWidth) | sta <pVram
        lda <pVram+1 | adc #high(VramWidth*CharHeight-CharWidth*FortWidth) | sta <pVram+1

        dec <yCount
    while ne | wend
rts


cseg
ClearV:
    lda #low VramOrg | sta <pVram
    lda #high VramOrg | sta <pVram+1
    ldx #$40
    do
        ldy #0 | tya
        do
            sta (<pVram),y
            iny
        while ne | wend
        inc <pVram+1
        dex
    while ne | wend
rts
ClearB:
    do
        ldy #0 | tya
        do
            sta (<pVVram),y
            iny
            cpy #VVramWidth
        while ne | wend
        lda <pVVram | clc|adc #VVramWidth | sta <pVVram
        lda <pVVram+1 | adc #0 | sta <pVVram+1
        dex
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pha
        lda <DmaFlagsValue
        and #not DMA_ENABLE
        ora #DMA_CPU_TO_VRAM
        sta <DmaFlagsValue | sta DMA_FLAGS

        jsr ClearV
        jsr SwitchPage_
        jsr ClearV

        ldy #0 | jsr DummyBlt

        lda <DmaFlagsValue
        and #not(DMA_ENABLE or DMA_CPU_TO_VRAM)
        sta <DmaFlagsValue | sta DMA_FLAGS

        jsr ClearV

        lda #low Backup | sta <pVVram
        lda #high Backup | sta <pVVram+1
        ldx #VVramHeight
        jsr ClearB

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        ldx #VVramHeight
        jsr ClearB
    pla
rts


; void PresentBackground();
cseg
PresentBackground_: public PresentBackground_
    pha
        lda <DmaFlagsValue
        and #not(DMA_COLORFILL_ENABLE)
        ora #DMA_ENABLE or DMA_IRQ or DMA_GCARRY or DMA_OPAQUE
        sta <DmaFlagsValue | sta DMA_FLAGS

        lda #VramTopY | sta BLT_VY
        lda #AsciiHeight*2 | clc|adc ScrollY_ | sta BLT_GY
        lda #VramWidth-1 | sta BLT_WIDTH
        lda #CharHeight*WindowHeight | sta BLT_HEIGHT
        lda #1 | sta <BltBusy | sta BLT_START
        do
            lda <BltBusy
        while ne | wend
    pla
rts


; void PresentForeground();
cseg
PresentForeground_: public PresentForeground_
    pha
        lda <DmaFlagsValue
        and #not(DMA_COLORFILL_ENABLE or DMA_OPAQUE)
        ora #DMA_ENABLE or DMA_IRQ or DMA_GCARRY
        sta <DmaFlagsValue | sta DMA_FLAGS

        stz BLT_VX
        lda #VramTopY | sta BLT_VY
        stz BLT_GX
        stz BLT_GY
        lda #VramWidth-1 | sta BLT_WIDTH
        lda #AsciiHeight*2 | sta BLT_HEIGHT
        lda #1 | sta <BltBusy | sta BLT_START
        do
            lda <BltBusy
        while ne | wend
    pla
rts


; void EraseRightEnd();
cseg
EraseRightEnd_: public EraseRightEnd_
    pha
        lda <DmaFlagsValue
        ora #DMA_ENABLE or DMA_IRQ or DMA_GCARRY or DMA_OPAQUE or DMA_COLORFILL_ENABLE
        sta <DmaFlagsValue | sta DMA_FLAGS

        lda #VramWidth-1 | sta BLT_VX
        stz BLT_VY
        lda #1 | sta BLT_WIDTH
        lda #VramHeight-1 | sta BLT_HEIGHT
        lda #not 0 | sta BLT_COLOR
        lda #1 | sta <BltBusy | sta BLT_START
        do
            lda <BltBusy
        while ne | wend


        stz BLT_VX
        stz BLT_VY
        lda #VramWidth-1 | sta BLT_WIDTH
        lda #VramTopY | sta BLT_HEIGHT
        lda #1 | sta <BltBusy | sta BLT_START
        do
            lda <BltBusy
        while ne | wend

        stz BLT_VX
        lda #VramTopY+CharHeight*WindowHeight | sta BLT_VY
        lda #VramWidth-1 | sta BLT_WIDTH
        lda #VramHeight-(VramTopY+CharHeight*WindowHeight) | sta BLT_HEIGHT
        lda #1 | sta <BltBusy | sta BLT_START
        do
            lda <BltBusy
        while ne | wend
    pla
rts


; void SwitchPage();
cseg
SwitchPage_: public SwitchPage_
    pha
        lda <BankRegValue
        eor #BANK_SECOND_FRAMEBUFFER
        sta <BankRegValue | sta BANK_REG

        lda <DmaFlagsValue
        eor #DMA_PAGE_OUT
        sta <DmaFlagsValue | sta DMA_FLAGS
    pla
rts


DummyBlt:
    lda <DmaFlagsValue
    ora #DMA_ENABLE or DMA_IRQ or DMA_COLORFILL_ENABLE or DMA_OPAQUE
    sta <DmaFlagsValue | sta DMA_FLAGS

    stz BLT_VX
    lda #VramHeight-1 | sta BLT_VY
    stz BLT_GX
    sty BLT_GY
    lda #1 | sta BLT_WIDTH
    sta BLT_HEIGHT
    sta <BltBusy | sta BLT_START
    do
        lda <BltBusy
    while ne | wend
rts


dseg
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
Put_@Param1: public Put_@Param1
Put_c:
    defb 0

; word PrintC(word vram, byte c);
cseg
CharTable:
    defb " -0123456789:@ACEFGHIMNORSTUV"
PrintC_: public PrintC_
    pha
        sty <pVram | stx <pVram+1
        
        lda PrintC_c
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_break
            inx
            cpx #AsciiCount
        while ne | wend
        PrintC_break:
        txa
        sta <pPattern | stz <pPattern+1
        asl a ;*2
        adc <pPattern ;*3
        asl a | rol <pPattern+1 ;*6
        asl a | rol <pPattern+1 ;*12
        asl a | rol <pPattern+1 ;*24
        adc #low AsciiPatternRam | sta <pPattern
        lda <pPattern+1 | adc #high AsciiPatternRam | adc #0 | sta <pPattern+1
        
        ldy #0 | jsr DummyBlt

        lda <DmaFlagsValue
        and #not(DMA_ENABLE or DMA_CPU_TO_VRAM)
        sta <DmaFlagsValue | sta DMA_FLAGS

        lda #AsciiHeight | sta <yCount
        do
            jsr PutRow
            dec <yCount
        while ne | wend

        lda <pVram | clc|adc #low(CharWidth-VramWidth*AsciiHeight) | tay
        lda <pVram+1 | adc #high(CharWidth-VramWidth*AsciiHeight) | tax
    pla
rts

PutRow:
    ldy #0
    do
        lda (<pPattern),y
        sta (<pVram),y
        iny
        cpy #CharWidth
    while ne | wend
    lda <pPattern | clc|adc #CharWidth | sta <pPattern
    lda <pPattern+1 | adc #0 | sta <pPattern+1

    lda <pVram | clc|adc #VramWidth | sta <pVram
    lda <pVram+1 | adc #0 | sta <pVram+1
rts


; word Put(word vram, byte c);
cseg
Put1:
    sta <pPattern | stz <pPattern+1
    asl a | rol <pPattern+1 ;*2
    asl a | rol <pPattern+1 ;*4
    asl a | rol <pPattern+1 ;*8
    asl a | rol <pPattern+1 ;*16
    adc #low CharPatternRam | sta <pPattern
    lda <pPattern+1 | adc #high CharPatternRam | adc #0 | sta <pPattern+1
    
    lda <DmaFlagsValue
    and #not(DMA_ENABLE or DMA_CPU_TO_VRAM)
    sta <DmaFlagsValue | sta DMA_FLAGS

    lda #CharHeight | sta <yCount
    do
        jsr PutRow
        dec <yCount
    while ne | wend
rts
Put_: public Put_
    pha
        sty <pVram | stx <pVram+1

        ldy #0 | jsr DummyBlt
        lda Put_c
        jsr Put1

        lda <pVram | clc|adc #low(CharWidth-VramWidth*CharHeight) | tay
        lda <pVram+1 | adc #high(CharWidth-VramWidth*CharHeight) | tax
    pla
rts


; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param1: public DrawSprite_@Param1
DrawSprite_y:
    defb 0
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
cseg
DrawSprite_: public DrawSprite_
    pha
        lda <DmaFlagsValue
        and #not(DMA_COLORFILL_ENABLE or DMA_OPAQUE)
        ora #DMA_ENABLE or DMA_IRQ or DMA_GCARRY
        sta <DmaFlagsValue | sta DMA_FLAGS

        sty BLT_VX
        lda DrawSprite_y | clc|adc #VramTopY-5 | sta BLT_VY
        lda DrawSprite_pattern
        tax
            and #$0f
            asl a | asl a | asl a
            sta BLT_GX
        txa
        and #$f0
        lsr a
        clc|adc #VramHeight
        sta BLT_GY
        lda #SpriteWidth | sta BLT_WIDTH
        lda #SpriteHeight | sta BLT_HEIGHT
        lda #1 | sta <BltBusy | sta BLT_START
        do
            lda <BltBusy
        while ne | wend
    pla
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        ldy #0 | jsr DummyBlt

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        lda #low BackgroundTop | sta <pVram
        lda #high BackgroundTop | sta <pVram+1
        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #VVramHeight | sta <yCount2
        do
            ldy #0
            do
                lda (<pVVram),y
                cmp (<pBackup),y
                if ne
                    sta (<pBackup),y
                    phy
                        jsr Put1
                    ply
                    lda <pVram | clc|adc #low(CharWidth-VramWidth*CharHeight) | sta <pVram
                    lda <pVram+1 | adc #high(CharWidth-VramWidth*CharHeight) | sta <pVram+1
                else
                    lda <pVram | clc | adc #low CharHeight | sta <pVram
                    lda <pVram+1 | adc #high CharHeight | sta <pVram+1
                endif

                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVram | clc | adc #low(CharHeight*VramWidth-VVramWidth*CharWidth)  | sta <pVram
            lda <pVram+1 | adc #high(CharHeight*VramWidth-VVramWidth*CharWidth) | sta <pVram+1

            lda <pVVram | clc | adc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #high VVramWidth | sta <pVVram+1

            lda <pBackup | clc | adc #low VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #high VVramWidth | sta <pBackup+1

            dec <yCount2
        while ne | wend
    pla
rts


ext dotOffset_

; void UpdateOffset();
cseg
UpdateOffset_: public UpdateOffset_
    pha
        lda #4
        sec|sbc dotOffset_
        sta ScrollY_
    pla
rts



ext FortDotOffset_

scope
; void DrawFort(byte x, byte y);
dseg
DrawFort_@Param1: public DrawFort_@Param1
DrawFort_y:
    defb 0
cseg
DrawFort_: public DrawFort_
    pha
        lda DrawFort_y
        asl a | asl a
        clc|adc FortDotOffset_
                                    if pl
                                        _deb: public _deb
                                        nop
                                    endif
        clc|adc #VramTopY-5 | sta BLT_VY
        lda #VramHeight+FortPatternY | sta BLT_GY
        lda #CharHeight*FortHeight | sta BLT_HEIGHT

        tya
        asl a | asl a
        sta BLT_VX
        stz BLT_GX
        lda #CharWidth*FortWidth | sta BLT_WIDTH

        lda <DmaFlagsValue
        and #not(DMA_COLORFILL_ENABLE or DMA_OPAQUE)
        ora #DMA_ENABLE or DMA_IRQ or DMA_GCARRY
        sta <DmaFlagsValue | sta DMA_FLAGS

        lda #1 | sta <BltBusy | sta BLT_START
        do
            lda <BltBusy
        while ne | wend
    pla
rts
endscope