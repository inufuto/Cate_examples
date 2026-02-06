include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "Chars.inc"

ext SpritePattern
ext WaitVdp

Top equ 8*2-1
PatternSize equ 8*4
SpriteCount equ 6

dseg
Sprites: public Sprites
SpriteY:
    defs SpriteCount
SpriteX:
    defs SpriteCount
SpritePatternNum:
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
                cpy #PatternSize
            while ne | wend
            lda <pSource | clc|adc #PatternSize | sta <pSource
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


; void ShowSprite(byte index, byte x, byte y, sbyte pattern);
dseg
ShowSprite_@Param1: public	ShowSprite_@Param1
ShowSprite_x:
    defb 0
ShowSprite_@Param2:	public	ShowSprite_@Param2
ShowSprite_y:
    defb 0
ShowSprite_@Param3: public	ShowSprite_@Param3
ShowSprite_pattern:
	defb 0
cseg
ShowSprite_: public	ShowSprite_
    pha
        tya | tax
        sei
            lda ShowSprite_y | clc|adc #Top | sta SpriteY,x
            lda ShowSprite_x | sta SpriteX,x
            lda ShowSprite_pattern | asl a | asl a | sta SpritePatternNum,x
        cli
    pla
rts
SpriteColor:
	defb 0dh, 0dh, 0dh, 0dh, 07h, 0fh


; void HideSprite(byte sprite);
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