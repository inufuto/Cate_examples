include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"

ext LeftX_
ext VVramPtr_,VVramPtr_@Param0,VVramPtr_@Param1

SpriteCount equ 9
InvalidCode equ $ff

dseg
Sprites: public Sprites
sprite_x:
    defs SpriteCount
sprite_y:
    defs SpriteCount
sprite_code:
    defs SpriteCount

pMovable equ ZW0
pVVram equ ZW0
xPos equ ZB0
yPos equ ZB1
code equ ZB2
xCount equ ZB3
yCount equ ZB4


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    pha
        lda #InvalidCode
        ldx #0
        do
            sta sprite_code,x | inx
            cpx #SpriteCount
        while ne | wend
    pla
rts


; void ShowSprite(ptr<Movable> pMovable, byte code);
dseg
ShowSprite_@Param0:	public	ShowSprite_@Param0
ShowSprite_pMovable:
    defs 2
ShowSprite_@Param1:	public	ShowSprite_@Param1
ShowSprite_code:
	defs 1
cseg
ShowSprite_: public ShowSprite_
    pha
        lda ShowSprite_pMovable | sta <pMovable
        lda ShowSprite_pMovable+1 | sta <pMovable+1
        ldy #2 | lda (<pMovable),y | tax ; index
        dey | lda (<pMovable),y | sta <yPos ; y
        dey | lda (<pMovable),y | sec|sbc LeftX_ | sta <xPos ; x
        cmp #VVramWidth
        bcs ShowSprite_hide
        lda <yPos
        cmp #VVramHeight
        if cc
            sta sprite_y,x
            lda <xPos | sta sprite_x,x
            lda ShowSprite_code | sta sprite_code,x
        else
            ShowSprite_hide:
            lda #InvalidCode | sta sprite_code,x
        endif
    pla
rts


; void HideSprite(byte index);
dseg
HideSprite_@Param0:	public	HideSprite_@Param0
HideSprite_index:
	defs 1
cseg
HideSprite_: public HideSprite_
    pha
        ldx HideSprite_index
        lda #InvalidCode | sta sprite_code,x
    pla
rts


; void DrawSprites();
cseg
DrawSprites_: public DrawSprites_
    pha
        ldx #0
        do
            lda sprite_code,x
            cmp #InvalidCode
            if ne
                lda sprite_x,x | sta <xPos
                sta VVramPtr_@Param0
                lda sprite_y,x | sta <yPos
                sta VVramPtr_@Param1
                stx <xCount
                jsr VVramPtr_
                sty <pVVram | stx <pVVram+1
                ldx <xCount
                lda sprite_code,x | sta <code

                ldy #0
                lda #2 | sta <yCount
                do
                    lda <yPos
                    cmp #VVramHeight
                    if cc
                        lda #2 | sta <xCount
                        do
                            lda <xPos
                            cmp #VVramWidth
                            if cc
                                lda <code | sta (<pVVram),y
                            endif
                            iny
                            inc <xPos
                            inc <code
                            dec <xCount
                        while ne | wend
                        tya | clc|adc #VVramWidth-2 | tay
                        lda <xPos | sec|sbc #2 | sta <xPos
                    else
                        lda <code | clc|adc #2 | sta <code
                        tya | clc|adc #VVramWidth | tay
                    endif
                    inc <yPos
                    dec <yCount
                while ne | wend
            endif
            inx
            cpx #SpriteCount
        while ne | wend
    pla
rts
