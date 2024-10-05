include "GameKing.inc"
include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, SpritePattern
ext DrawSprites
ext VVram_

VramSize equ VramRowSize*VramHeight
LcdBottom equ $0200
LcdTop equ LcdBottom+VramSize-VramWidth
AsciiHeight equ 5

dseg
Vram_: public Vram_
    defs VramSize
ScorePane_: public ScorePane_
    defs VramWidth*AsciiHeight
StagePane_: public StagePane_
    defs VramWidth*AsciiHeight
SpriteLayer: public SpriteLayer
    defs VramSize
pStatusPane:
    defw 0
Backup: public Backup
    defs VVramWidth*VVramHeight
Param_pVram:
    defw 0
PrintC_@Param1: public PrintC_@Param1
Put_@Param1: public Put_@Param1
Param_c:
    defb 0
Put_@Param2: public Put_@Param2
Param_right:
    defb 0


pSource equ ZW0
pDestination equ ZW1
charWord equ ZW2
charOffset equ ZB0
vramOffset equ ZB1
pVVram equ ZW0
pBackup equ ZW3
pVVram equ ZW0
yCount equ ZB2

; ptr<byte> VramPtr(byte x, byte y);
dseg
VramPtr_@Param1: public VramPtr_@Param1
VramPtr_y:
	defs 1
cseg
VramPtr_: public VramPtr_
	pha
        lda	VramPtr_y
        asl a ;*2
        clc|adc VramPtr_y ;*3
        stz <pDestination+1
        asl a | rol <pDestination+1 ;*6
        asl a | rol <pDestination+1 ;*12
        asl a | rol <pDestination+1 ;*24
        sta <pDestination
        tya | lsr a
        clc|adc <pDestination | tay
        lda <pDestination+1 | adc #0 | tax
        tya | clc|adc #low Vram_ | tay
        txa | adc #high Vram_ | tax
	pla
rts


; void ClearScreen();
cseg
Clear:
    ldx #VVramHeight
    do
        lda #0
        ldy #0
        do
            sta (<pDestination),y
            iny
            cpy #VVramWidth
        while ne | wend
        lda <pDestination | clc|adc #VVramWidth | sta <pDestination
        lda <pDestination+1 | adc #0 | sta <pDestination+1
        dex
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram_ | sta <pDestination
        lda #high Vram_ | sta <pDestination+1
        ldx #VramHeight*(CharHeight+AsciiHeight*2)
        do
            ldy #0 | tya
            do
                sta (<pDestination),y
                iny
                cpy #VramWidth
            while ne | wend
            lda <pDestination | clc|adc #VramWidth | sta <pDestination
            lda <pDestination+1 | adc #0 | sta <pDestination+1
            dex
        while ne | wend

        lda #low Backup | sta <pDestination
        lda #high Backup | sta <pDestination+1
        jsr Clear

        lda #low VVram_ | sta <pDestination
        lda #high VVram_ | sta <pDestination+1
        jsr Clear
    pla
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " 0123456789ABCDEFGHIJKLMNOPQRSTUVWYXZ"
PrintC_: public PrintC_
    pha
        sty Param_pVram | sty <pDestination
        stx Param_pVram+1 | stx <pDestination+1

        lda Param_c
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_break
            inx
            cpx #37
        while ne | wend
        ldx #0
        PrintC_break:
        txa
        sta <pSource
        asl a ;*2
        asl a ;*4
        adc <pSource ;*5
        adc #low AsciiPattern | sta <pSource
        lda #0 | adc #high AsciiPattern | sta <pSource+1

        stz <charOffset | stz <vramOffset
        ldx #AsciiHeight
        do
            ldy <charOffset
            lda (<pSource),y
            iny | sty <charOffset
            ldy <vramOffset | sta (<pDestination),y
            tya | clc|adc #VramWidth | sta <vramOffset
            dex
        while ne | wend
        ldy Param_pVram | ldx Param_pVram+1
        iny
        if eq
            inx
        endif
    pla
rts


; ptr<byte> Put(ptr<byte> pVram, byte c, bool right);
cseg
Put_: public Put_
    pha
        sty Param_pVram | sty <pDestination
        stx Param_pVram+1 | stx <pDestination+1
        lda Param_c
        jsr Put
        ldy <pDestination
        ldx <pDestination+1
    pla
rts
Put:
    ldx Param_right
    if eq
        tay
        and #$f0 | sta <charWord
        tya
        asl a | asl a | asl a | asl a | sta <charWord+1
        lda (<pDestination)
        and #$0f | ora <charWord
        sta (<pDestination)
        ldy #VramWidth
        lda (<pDestination),y
        and #$0f | ora <charWord+1
        sta (<pDestination),y
        ldy Param_pVram | ldx Param_pVram+1
    else
        tay
        lsr a | lsr a | lsr a | lsr a | sta <charWord
        tya
        and #$0f | sta <charWord+1
        lda (<pDestination)
        and #$f0 | ora <charWord
        sta (<pDestination)
        ldy #VramWidth
        lda (<pDestination),y
        and #$f0 | ora <charWord+1
        sta (<pDestination),y
        inc <pDestination
        if eq
            inc <pDestination+1
        endif
    endif
rts

; void SwitchStatus(byte mode);
cseg
SwitchStatus_: public SwitchStatus_
    pha
        cpy #0
        if eq
            lda #low ScorePane_ | sta pStatusPane
            lda #high ScorePane_ | sta pStatusPane+1
        else
            lda #low StagePane_ | sta pStatusPane
            lda #high StagePane_ | sta pStatusPane+1
        endif
    pla
rts


; void PresentVram();
cseg
PresentVram_: public PresentVram_
    pha
        lda #low Vram_ | sta <pSource
        lda #high Vram_ | sta <pSource+1
        lda #low SpriteLayer | sta <pDestination
        lda #high SpriteLayer | sta <pDestination+1
        ldx #VramHeight*CharHeight/16
        do
            ldy #0
            do
                lda (<pSource),y
                sta (<pDestination),y
                iny
                cpy #VramWidth*16
            while ne | wend
            lda <pSource | clc|adc #VramWidth*16 | sta <pSource
            lda <pSource+1 | adc #0 | sta <pSource+1
            lda <pDestination | clc|adc #VramWidth*16 | sta <pDestination
            lda <pDestination+1 | adc #0 | sta <pDestination+1
            dex
        while ne | wend

        jsr DrawSprites

        lda pStatusPane | sta <pSource
        lda pStatusPane+1 | sta <pSource+1
        lda #low SpriteLayer | sta <pDestination
        lda #high SpriteLayer | sta <pDestination+1
        ldy #0
        do
            lda (<pDestination),y
            ora (<pSource),y
            sta (<pDestination),y
            iny
            cpy #VramWidth*AsciiHeight
        while ne | wend

        lda #low SpriteLayer | sta <pSource
        lda #high SpriteLayer | sta <pSource+1
        lda #low LcdTop | sta <pDestination
        lda #high LcdTop | sta <pDestination+1
        ldx #VramHeight*CharHeight
        do
            ldy #0
            do
                lda (<pSource),y
                sta (<pDestination),y
                iny
                cpy #VramWidth
            while ne | wend
            lda <pSource | clc|adc #VramWidth | sta <pSource
            lda <pSource+1 | adc #0 | sta <pSource+1
            lda <pDestination | sec|sbc #VramWidth | sta <pDestination
            lda <pDestination+1 | sbc #0 | sta <pDestination+1
            dex
        while ne | wend
    pla
rts


VramTop equ Vram_+VramRowSize*StatusHeight

; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        
        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #low VramTop | sta <pDestination
        lda #high VramTop | sta <pDestination+1
        ldx #VVramHeight
        do
            phx
                ldy #0 | sty Param_right
                do
                    lda (<pVVram),y
                    cmp (<pBackup),y
                    if ne
                        sta (<pBackup),y
                        phy
                            jsr Put
                        ply
                        lda Param_right | eor #1 | sta Param_right
                    else
                        lda Param_right | eor #1 | sta Param_right
                        if eq
                            inc <pDestination
                            if eq
                                inc <pDestination+1
                            endif
                        endif
                    endif
                    iny
                    cpy #VVramWidth
                while ne | wend
                lda <pVVram | clc | adc #low VVramWidth | sta <pVVram
                lda <pVVram+1 | adc #high VVramWidth | sta <pVVram+1

                lda <pBackup | clc | adc #low VVramWidth | sta <pBackup
                lda <pBackup+1 | adc #high VVramWidth | sta <pBackup+1

                lda <pDestination | clc | adc #low(VramRowSize-VVramWidth/2) | sta <pDestination
                lda <pDestination+1 | adc #0 | sta <pDestination+1
            plx
            dex
        while ne | wend
    pla
rts
