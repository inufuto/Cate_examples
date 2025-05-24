include "neo6502.inc"
include "ZeroPage.inc"
include "Vram.inc"

Sprite_End equ 15
InvalidY equ $d0
Top equ CharHeight*1

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


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
dseg
ShowSprite_@Param1:	public	ShowSprite_@Param1
ShowSprite_pattern:
	defb 0
cseg
ShowSprite_: public	ShowSprite_
    pha
        sty <pMovable | stx <pMovable+1

        ldy #Movable_sprite
        lda (<pMovable),y; sprite
        tax

        ldy #Movable_x | lda (<pMovable),y
        sta Sprites_x,x

        ldy #Movable_y | lda (<pMovable),y
        clc|adc #Top
        sta Sprites_y,x

        lda ShowSprite_pattern
        sta Sprites_pattern,x
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


; void UpdateSprites();
cseg
UpdateSprites_: public UpdateSprites_
    pha
        ldy #0
        ldx nextOffset
        do
            lda Sprites_y,x
            cmp #InvalidY
            if ne
                sty API_PARAMETERS+0 ; Number
                sta API_PARAMETERS+3 ; low Y
                lda Sprites_x,x | sta API_PARAMETERS+1 ; low X
                lda Sprites_pattern,x | sta API_PARAMETERS+5 ; Image
                stz API_PARAMETERS+2 ; high X
                stz API_PARAMETERS+4 ; high Y
                stz API_PARAMETERS+6 ; Flip
                stz API_PARAMETERS+8 ; Flags
                lda #7 | sta API_PARAMETERS+7 ; Anchor
                lda #API_FN_SPRITE_SET | sta API_FUNCTION
                lda #API_GROUP_SPRITES | sta API_COMMAND

                iny
                cpy #$10
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
            cpy #$10
        while ne | wend
        UpdateSprites_full:
        ldx nextOffset | inx
        cpx #Sprite_End
        if eq
            ldx #0
        endif
        stx nextOffset
    pla
rts
