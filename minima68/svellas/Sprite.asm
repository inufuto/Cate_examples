include "Direct.inc "
include "Vram.inc"

SpriteCount equ 5

Sprite_x equ 0
Sprite_y equ 1
Sprite_index equ 2

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
; void ShowSprite(ptr<Movable> pMovable, byte pattern);
pMovable equ @Temp@Word
pDestination equ @Temp@Word2
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
        ldab Sprite_index,x
        aslb | aslb ;*4
        stab pDestination+1
        ldaa Sprite_x,x
        lsra
        
        ldab Sprite_y,x
        addb #CharHeight*2
        
        ldx pDestination
        stab 0,x ;y
        staa 1,x ;x
        ldaa ShowSprite_pattern
        staa 2,x ;pattern
    pulb | pula
rts

scope
; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    psha | pshb
        tab
        ldaa #high SpriteAttributeRam | staa pDestination
        ldab Sprite_index,x
        aslb | aslb ;*4
        stab pDestination+1
        ldx pDestination
        ldaa #-SpriteHeight
        staa 0,x ;y
    pulb | pula
rts
