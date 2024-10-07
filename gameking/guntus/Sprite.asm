include "GameKing.inc"
include "ZeroPage.inc"
include "Vram.inc"

ext SpritePattern
ext SpriteLayer

SpriteCount equ 31
InvalidPattern equ $ff
; Top equ 0

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

dseg
Sprite_x:
    defs SpriteCount
Sprite_y:
    defs SpriteCount
Sprite_pattern:
    defs SpriteCount


pSource equ ZW0
pDestination equ ZW1
charWord equ ZW2
maskWord equ ZW3
charOffset equ ZB0
vramOffset equ ZB1
xMod equ ZB2
yCount equ ZB3
yPos equ ZB4
xPos equ ZB5

; void HideAllSprites();
cseg
HideAllSprites_: public	HideAllSprites_
    pha
        lda #InvalidPattern
        ldx #0
        do
            sta Sprite_pattern,x
            inx
            cpx #SpriteCount
        while ne | wend
    pla
rts


; void ShowSprite(byte index, byte x, byte y, sbyte pattern);
dseg
ShowSprite_@Param1:	public	ShowSprite_@Param1
ShowSprite_x:
	defb 0
ShowSprite_@Param2:	public	ShowSprite_@Param2
ShowSprite_y:
	defb 0
ShowSprite_@Param3:	public	ShowSprite_@Param3
ShowSprite_pattern:
	defb 0
cseg
ShowSprite_: public	ShowSprite_
    pha
        tya | tax
        lda ShowSprite_y
        ; clc|adc #Top
        sta Sprite_y,x
        lda ShowSprite_x
        sta Sprite_x,x
        lda ShowSprite_pattern | sta Sprite_pattern,x
    pla
rts


; void HideSprite(byte index);
cseg
HideSprite_: public	HideSprite_
    pha
        lda #InvalidPattern
        sta Sprite_pattern,y
    pla
rts


cseg
DrawSprites: public DrawSprites
    pha
        ldx #0
        do
            lda Sprite_pattern,x
            cmp #InvalidPattern
            if ne
                lda Sprite_y,x | sta <yPos
                asl a ;*2
                clc|adc Sprite_y,x ;*3
                stz <pDestination+1
                asl a | rol <pDestination+1 ;*6
                asl a | rol <pDestination+1 ;*12
                sta <pDestination
                
                lda Sprite_x,x
                tay
                lsr a ;/2
                lsr a ;/4
                sta <xPos
                clc|adc <pDestination | sta <pDestination
                lda <pDestination+1 | adc #0 | sta <pDestination+1
                lda <pDestination | clc|adc #low SpriteLayer | sta <pDestination
                lda <pDestination+1 | adc #high SpriteLayer | sta <pDestination+1
                stz <vramOffset

                tya ; x
                and #3
                sta <xMod

                lda Sprite_pattern,x | stz <pSource+1
                asl a | rol <pSource+1 ;*2
                asl a | rol <pSource+1 ;*4
                asl a | rol <pSource+1 ;*8
                adc #low SpritePattern | sta <pSource
                lda <pSource+1 | adc #high SpritePattern | sta <pSource+1
                stz <charOffset

                phx
                    lda #CharHeight*2 | sta <yCount
                    do
                        lda <yPos
                        cmp #32
                        if cc
                            ldy <charOffset
                            lda (<pSource),y | iny | sta <maskWord
                            lda (<pSource),y | iny | sta <charWord
                            sty <charOffset
                            stz maskWord+1 | stz charWord+1
                            ldx <xMod
                            do | while ne
                                lsr <maskWord | ror <maskWord+1
                                lsr <maskWord | ror <maskWord+1
                                lsr <charWord | ror <charWord+1
                                lsr <charWord | ror <charWord+1
                                dex
                            wend

                            ldy <vramOffset
                            lda <xPos
                            cmp #VramWidth
                            if cc
                                lda <maskWord
                                if ne
                                    eor #$ff | sta <maskWord
                                    lda (<pDestination),y
                                    and <maskWord | ora <charWord
                                    sta (<pDestination),y
                                endif
                            endif
                            iny
                            lda <xPos
                            inc a
                            cmp #VramWidth
                            if cc
                                lda <maskWord+1
                                if ne
                                    eor #$ff | sta <maskWord+1
                                    lda (<pDestination),y
                                    and <maskWord+1 | ora <charWord+1
                                    sta (<pDestination),y
                                endif
                            endif
                            tya | clc|adc #VramWidth-1 | sta <vramOffset
                        endif
                        inc <yPos
                        dec <yCount
                    while ne | wend
                plx
            endif
            inx
            cpx #SpriteCount
        while ne | wend
    pla
rts
