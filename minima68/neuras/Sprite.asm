include "Direct.inc "
include "Vram.inc"

SpriteCount equ 6

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

cseg
ToDestination:
    tab
    ldaa #high SpriteAttributeRam | staa pDestination
    aslb | aslb ;*4
    stab pDestination+1
    ldx pDestination
rts

; void ShowSprite(byte index, byte x, byte y, byte pattern);
dseg
ShowSprite_@Param1: public ShowSprite_@Param1
ShowSprite_x:
    defb 0
ShowSprite_@Param2: public ShowSprite_@Param2
ShowSprite_y:
    defb 0
ShowSprite_@Param3: public ShowSprite_@Param3
ShowSprite_pattern:
    defb 0
cseg
ShowSprite_: public ShowSprite_
    psha | pshb
        bsr ToDestination
        ldaa ShowSprite_x
        lsra
        
        ldab ShowSprite_y
        addb #CharHeight*3
        
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
        bsr ToDestination
        ldaa #-SpriteHeight
        staa 0,x ;y
    pulb | pula
rts
