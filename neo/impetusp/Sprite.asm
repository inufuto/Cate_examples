include "neo6502.inc"
include "ZeroPage.inc"
include "Vram.inc"

Sprite_End equ 32
InvalidY equ $df
; Top equ CharHeight*0
Max equ $10

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

pMovable equ ZW0

dseg
Sprites: public Sprites
Sprites_x:
    defs Sprite_End
Sprites_y:
    defs Sprite_End
Sprites_pattern:
    defs Sprite_End
nextOffset:
    defb 0


cseg
InitSprites: public InitSprites
    stz nextOffset

; void HideAllSprites()
cseg
HideAllSprites_: public HideAllSprites_
    pha
        lda #API_FN_SPRITE_RESET | sta API_FUNCTION
        lda #API_GROUP_SPRITES | sta API_COMMAND

        lda #InvalidY
        ldx #0
        do
            sta Sprites_y,x | inx
            cpx #Sprite_End
        while ne | wend
    pla
rts


dseg
ShowSpriteXY_@Param1: public ShowSpriteXY_@Param1
ShowSpriteXY_x:
    defb 0
ShowSpriteXY_@Param2: public ShowSpriteXY_@Param2
ShowSpriteXY_y:
    defb 0
ShowSprite_@Param1:	public	ShowSprite_@Param1
ShowSprite_pattern:
ShowSpriteXY_@Param3: public ShowSpriteXY_@Param3
ShowSpriteXY_pattern:
	defb 0

; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public	ShowSprite_
    pha
        sty <pMovable | stx <pMovable+1

        ldy #Movable_sprite
        lda (<pMovable),y; sprite
        tax

        ldy #Movable_x | lda (<pMovable),y
        asl a
        sta Sprites_x,x

        ldy #Movable_y | lda (<pMovable),y
        asl a
        ; clc|adc #Top
        sta Sprites_y,x

        lda ShowSprite_pattern
        sta Sprites_pattern,x
    pla
rts

; void ShowSpriteXY(byte index, byte x, byte y, byte pattern);
cseg
ShowSpriteXY_: public ShowSpriteXY_
    pha
        sei
            lda ShowSpriteXY_x
            asl a
            sta Sprites_x,y
            lda ShowSpriteXY_y
            asl a
            ; clc|adc #Top
            sta Sprites_y,y
            lda ShowSpriteXY_pattern
            sta Sprites_pattern,y
        cli
    pla
rts


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    pha
        tya | tax
        lda #InvalidY | sta Sprites_y,x
    pla
rts


zseg
highY:
    defb 0
oldOffset:
    defb 0
cseg
UpdateSprites: public UpdateSprites
    pha
        ldy #0
        ldx nextOffset
        do
            lda Sprites_y,x
            cmp #InvalidY
            if ne
                sty API_PARAMETERS+0 ; Number
                sta API_PARAMETERS+3 ; low Y
                stz highY
                cmp #-16
                if cs
                    dec highY
                endif
                lda Sprites_x,x | sta API_PARAMETERS+1 ; low X
                lda Sprites_pattern,x | sta API_PARAMETERS+5 ; Image
                stz API_PARAMETERS+2 ; high X
                lda highY | sta API_PARAMETERS+4 ; high Y
                stz API_PARAMETERS+6 ; Flip
                stz API_PARAMETERS+8 ; Flags
                lda #7 | sta API_PARAMETERS+7 ; Anchor
                lda #API_FN_SPRITE_SET | sta API_FUNCTION
                lda #API_GROUP_SPRITES | sta API_COMMAND

                iny
                cpy #Max
                beq UpdateSprites_full
            endif
            inx
            cpx #Sprite_End
            if eq
                ldx #0
            endif
            cpx nextOffset
        while ne | wend
        do
            sty API_PARAMETERS+0 ; index
            lda #API_FN_SPRITE_HIDE | sta API_FUNCTION
            lda #API_GROUP_SPRITES | sta API_COMMAND
            iny
            cpy #Max
        while ne | wend
        UpdateSprites_full:
        ldx nextOffset | stx oldOffset
        do
            inx
            cpx #Sprite_End
            if eq
                ldx #0
            endif
            cpx oldOffset
            beq UpdateSprites_exit
            lda Sprites_y,x
            cmp #InvalidY
        while eq | wend
        UpdateSprites_exit:
        stx nextOffset
    pla
rts
