include "Direct.inc "
include "Vram.inc"

SpriteCount equ 28
InvalidY equ $e0

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

Sprite_y equ 0
Sprite_x equ 1
Sprite_pattern equ 2
Sprite_unitSize equ 3

dseg
Sprites: public Sprites
    defs Sprite_unitSize*SpriteCount
SpritesEnd: public SpritesEnd
pFirst:
    defw 0

cseg
InitSprites: public InitSprites
    ldx #Sprites | stx pFirst
; void HideAllSprites();
HideAllSprites_: public HideAllSprites_
    ldaa #InvalidY
    ldx #Sprites
    do
        staa 0,x | inx
        cpx #SpritesEnd
    while ne | wend
    ldx #SpriteAttributeRam
    do
        staa 0,x | inx
        cpx #SpriteAttributeRam+4*MaxSpriteCount
    while ne | wend
rts

scope
pMovable equ @Temp@Word
pSprite equ @Temp@Word2

cseg
ToPtr:
    tab
    asla ;*2
    aba ;*3
    tab | clra
    addb #low Sprites | adca #high Sprites
    staa pSprite | stab pSprite+1
    ldx pSprite
rts

; void ShowSprite(byte index, byte x, byte y, sbyte pattern);
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
        bsr ToPtr

        ldaa ShowSprite_x
        lsra
        
        ldab ShowSprite_y
        addb #CharHeight
        
        ldx pSprite
        stab Sprite_y,x
        staa Sprite_x,x
        ldaa ShowSprite_pattern
        staa Sprite_pattern,x
    pulb | pula
rts

; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    psha | pshb
        bsr ToPtr
        ldaa #InvalidY
        staa Sprite_y,x ;y
    pulb | pula
rts


scope
zseg
pSource:
    defw 0
pDestination:
    defw 0
cseg
UpdateSprites: public UpdateSprites
    ldx pFirst | stx pSource
    ldx #SpriteAttributeRam | stx pDestination
    ldab #SpriteCount
    do
        ldx pSource
        cpx #SpritesEnd
        if eq
            ldx #Sprites
        endif
        ldaa 0,x | inx ;y
        stx pSource
        ldx pDestination | staa 0,x | inx | stx pDestination
        ldx pSource | ldaa 0,x | inx | stx pSource ;x
        ldx pDestination | staa 0,x | inx | stx pDestination
        ldx pSource | ldaa 0,x | inx | stx pSource ;pattern
        ldx pDestination | staa 0,x | inx | inx | stx pDestination
        decb
    while ne | wend
    ldx pFirst
    inx | inx | inx
    cpx #SpritesEnd
    if eq
        ldx #Sprites
    endif
    stx pFirst
rts
endscope
