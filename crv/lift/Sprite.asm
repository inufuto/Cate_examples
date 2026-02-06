include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "Chars.inc"

ext SpritePattern
ext WaitVdp

Top equ 8*0-1

SpriteCount equ 13

dseg
Sprites: public Sprites
SpriteY:
    defs SpriteCount
SpriteX:
    defs SpriteCount
SpritePatternNum:
    defs SpriteCount
SpriteColor:
    defs SpriteCount
FirstIndex:
    defs 1

pSource equ ZW0


cseg
InitSprites: public InitSprites
    jsr HideAllSprites_
    sei
        lda #low Vram_SpriteGenerator | sta VdpWritePort+1
        lda #$40 or high Vram_SpriteGenerator | sta VdpWritePort+1
        lda #low SpritePattern | sta <pSource
        lda #high SpritePattern | sta <pSource+1
        ldx #Pattern_End
        do
            ldy #0
            do
                lda (<pSource),y | iny
                sta VdpWritePort
                jsr WaitVdp
                cpy #8
            while ne | wend
            lda <pSource | clc|adc #8 | sta <pSource
            lda <pSource+1 | adc #0 | sta <pSource+1
            dex
        while ne | wend

        lda #0 | sta FirstIndex

        lda #low Vram_SpriteAttribute | sta VdpWritePort+1
        lda #$40 or high Vram_SpriteAttribute | sta VdpWritePort+1
        lda #$d0
        ldx #4*32
        do
            sta VdpWritePort
            jsr WaitVdp
            dex
        while ne | wend
    cli
rts


; void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
dseg
ShowSprite_@Param1:	public	ShowSprite_@Param1
ShowSprite_pattern:
	defs 1
ShowSprite_@Param2: public	ShowSprite_@Param2
ShowSprite_color:
	defs 1
cseg
ShowSprite_: public	ShowSprite_
    pha
        sty <pSource
        stx <pSource+1
        ldy #2 | lda (<pSource),y | tax

        sei
            dey | lda (<pSource),y | clc|adc #Top | sta SpriteY,x
            dey | lda (<pSource),y | sta SpriteX,x
            lda ShowSprite_pattern | sta SpritePatternNum,x
            lda ShowSprite_color | sta SpriteColor,x
        cli
    pla
rts
        

; void HideSprite(byte sprite);
dseg
cseg
HideSprite_: public HideSprite_
    pha
        tya | tax
        lda #192
        sei
            sta SpriteY,x
        cli
    pla
rts


; void HideAllSprites()
cseg
HideAllSprites_: public HideAllSprites_
    pha
        sei
            lda #192
            ldx #0
            do
                sta SpriteY,x
                inx
                cpx #SpriteCount
            while ne | wend
        cli
    pla
rts


; void UpdateSprites();
UpdateSprites_: public UpdateSprites_
    pha
        sei
            lda #low VRAM_SpriteAttribute | sta VdpWritePort+1
            lda #$40 or high VRAM_SpriteAttribute | sta VdpWritePort+1

            ldx FirstIndex
            ldy #SpriteCount
            do
                lda SpriteY,x
                sta VdpWritePort
                jsr WaitVdp
                lda SpriteX,x | sta VdpWritePort
                jsr WaitVdp
                lda SpritePatternNum,x | sta VdpWritePort
                jsr WaitVdp
                lda SpriteColor,x | sta VdpWritePort
                inx
                cpx #SpriteCount
                if eq
                    ldx #0
                endif
                dey
            while ne | wend
        cli
        stx FirstIndex
    pla
rts