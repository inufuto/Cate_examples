include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "Chars.inc"
include "Sprite.inc"

ext SpritePattern
ext WaitVdp

Top equ 8*2-1
PatternSize equ 8*4

dseg
Sprites: public Sprites
SpriteY:
    defs Sprite_End
SpriteX:
    defs Sprite_End
SpritePatternNum:
    defs Sprite_End
SpriteColor:
    defs Sprite_End
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
        sty <pSource | stx <pSource+1
        ldy #2 | lda (<pSource),y | tax

        sei
            dey | lda (<pSource),y | clc|adc #Top | sta SpriteY,x
            dey | lda (<pSource),y
            ldy ShowSprite_color
            if mi
                clc|adc #32
            endif
            sta SpriteX,x
            lda ShowSprite_pattern | asl a | asl a | sta SpritePatternNum,x
            lda ShowSprite_color | sta SpriteColor,x
        cli
    pla
rts
        

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
                cpx #Sprite_End
            while ne | wend
        cli
    pla
rts


UpdateSprites: public UpdateSprites
    ; pha
    ;     sei
            lda #low VRAM_SpriteAttribute | sta VdpWritePort+1
            lda #$40 or high VRAM_SpriteAttribute | sta VdpWritePort+1

            ldx FirstIndex
            ldy #Sprite_End
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
                cpx #Sprite_End
                if eq
                    ldx #0
                endif
                dey
            while ne | wend
        ; cli
        stx FirstIndex
    ; pla
rts