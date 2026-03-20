include "Direct.inc "
include "Vram.inc"

ext topY_, dotOffset_

SpriteCount equ 5

Movable_x equ 0
Movable_y equ 1
Movable_xd equ 2
Movable_yd equ 3
Movable_index equ 4

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
        ldab Movable_index,x
        aslb | aslb ;*4
        stab pDestination+1
        
        ldab Movable_y,x
        subb topY_
        cmpb #WindowHeight
        if cs
            addb #StatusHeight
            aslb | aslb ;*4
            addb Movable_yd,x
            addb dotOffset_
            aslb

            ldaa Movable_x,x
            asla | asla
            adda Movable_xd,x

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
