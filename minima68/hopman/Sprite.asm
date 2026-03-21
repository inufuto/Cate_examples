include "Direct.inc "
include "Vram.inc"

ext DotOffset_, LeftX_

Sprite_End equ 13
Top equ CharHeight*(StatusHeight+1)

Movable_x equ 0
Movable_y equ 1
Movable_xd equ 2
Movable_sprite equ 3

; dseg
; SpriteLextX_: public SpriteLextX_
;     defb 0

cseg
; void HideAllSprites();
HideAllSprites_: public HideAllSprites_
InitSprites: public InitSprites
    ldx #SpriteAttributeRam
    ldaa #-SpriteHeight
    do
        staa 0,x | inx
        cpx #SpriteAttributeRam+4*MaxSpriteCount
    while ne | wend
rts

scope
pMovable equ @Temp@Word
pDestination equ @Temp@Word2

; void ShowSprite(ptr<Movable> pMovable, byte pattern);
dseg
ShowSprite_@Param0: public ShowSprite_@Param0
ShowSprite_pMovable:
    defw 0
ShowSprite_@Param1: public ShowSprite_@Param1
ShowSprite_pattern:
    defb 0
cseg
ShowSprite_: public ShowSprite_
    psha | pshb
        ldx ShowSprite_pMovable | stx pMovable
        ldaa #high SpriteAttributeRam | staa pDestination
        ldab Movable_sprite,x
        aslb | aslb ;*4
        stab pDestination+1
        
        ldaa Movable_x,x
        suba LeftX_
        cmpa #WindowWidth-1
        if cs
            asla | asla ;*4
            adda Movable_xd,x
            suba DotOffset_

            ldab Movable_y,x
            aslb
            addb #Top

            ldx pDestination
            stab 0,x ;y
            staa 1,x ;x
            ldaa ShowSprite_pattern
            staa 2,x ;pattern
        else
            ldx pDestination
            ldab #-SpriteHeight
            stab 0,x ;y
        endif
    pulb | pula
rts

scope
; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    psha | pshb
        tab
        ldaa #high SpriteAttributeRam | staa pDestination
        aslb | aslb ;*4
        stab pDestination+1
        ldx pDestination
        ldaa #-SpriteHeight
        staa 0,x ;y
    pulb | pula
rts
