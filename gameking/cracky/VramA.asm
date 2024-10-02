include "GameKing.inc"
include "ZeroPage.inc"
include "Vram.inc"

ext AsciiPattern, SpritePattern
ext DrawSprites_

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
            ldy Param_pVram | ldx Param_pVram+1
            ldy Param_pVram | ldx Param_pVram+1
            iny
            if eq
                inx
            endif
        endif
    pla
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

; void DrawAll();
cseg
DrawAll_: public DrawAll_
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

        jsr DrawSprites_

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


; ; void DrawSprite(byte x, byte y, byte pattern);
; dseg
; Param_x:
;     defb 0
; DrawSprite_@Param1: public DrawSprite_@Param1
; Param_y:
;     defb 0
; DrawSprite_@Param2: public DrawSprite_@Param2
; Param_pattern:
;     defb 0
; cseg
; DrawSprite_: public DrawSprite_
;     pha
;         lda Param_y
;         asl a ;*2
;         clc|adc Param_y ;*3
;         asl a ;*6
;         asl a ;*12
;         sta <pDestination
        
;         tya ; x
;         lsr a ;/2
;         lsr a ;/4
;         clc|adc <pDestination | sta <pDestination
;         lda #0 | adc #0 | sta <pDestination+1
;         lda <pDestination | clc|adc #low SpriteLayer | sta <pDestination
;         lda <pDestination+1 | adc #high SpriteLayer | sta <pDestination+1
;         stz <vramOffset

;         tya ; x
;         and #3
;         sta <xMod

;         lda Param_pattern | stz <pSource+1
;         asl a | rol <pSource+1 ;*2
;         asl a | rol <pSource+1 ;*4
;         asl a | rol <pSource+1 ;*8
;         adc #low SpritePattern | sta <pSource
;         lda <pSource+1 | adc #high SpritePattern | sta <pSource+1
;         stz <charOffset

;         lda #CharHeight*2 | sta <yCount
;         do
;             ldy <charOffset
;             lda (<pSource),y | iny | sta <maskWord
;             lda (<pSource),y | iny | sta <charWord
;             sty <charOffset
;             stz maskWord+1 | stz charWord+1
;             ldx <xMod
;             do | while ne
;                 lsr <maskWord | ror <maskWord+1
;                 lsr <maskWord | ror <maskWord+1
;                 lsr <charWord | ror <charWord+1
;                 lsr <charWord | ror <charWord+1
;                 dex
;             wend

;             ldy <vramOffset
;             lda <maskWord
;             if ne
;                 eor #$ff | sta <maskWord
;                 lda (<pDestination),y
;                 and <maskWord | ora <charWord
;                 sta (<pDestination),y
;             endif
;             iny
;             lda <maskWord+1
;             if ne
;                 eor #$ff | sta <maskWord+1
;                 lda (<pDestination),y
;                 and <maskWord+1 | ora <charWord+1
;                 sta (<pDestination),y
;             endif
;             tya | clc|adc #VramWidth-1 | sta <vramOffset
            
;             dec <yCount
;         while ne | wend
;     pla
; rts
