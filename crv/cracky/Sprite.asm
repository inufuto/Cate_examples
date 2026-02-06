include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "Chars.inc"

ext SpritePattern

Top equ 8*1-1

SpriteCount equ 5

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
                nop | nop | nop
                cpy #8*4
            while ne | wend
            lda <pSource | clc|adc #8*4 | sta <pSource
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
            nop | nop | nop
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
                                    _deb: public _deb
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
                cmp #192
                if cc
                    sta VdpWritePort
                    nop | nop | nop
                    lda SpriteX,x | sta VdpWritePort
                    nop | nop | nop
                    lda SpritePatternNum,x | sta VdpWritePort
                    nop | nop | nop
                    lda SpriteColor,x | sta VdpWritePort
                endif
                inx
                cpx #SpriteCount
                if eq
                    ldx #0
                endif
                dey
            while ne | wend
            lda #$d0 | sta VdpWritePort
        cli
        stx FirstIndex
    pla
rts