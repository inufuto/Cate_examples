include "Atari7800.inc"
include "ZeroPage.inc"
include "Vram.inc"

ext SpritePattern
ext DisplayListList0, DisplayListList1, CurrentDPP

Sprite_End equ 15
InvalidY equ $d0
Left equ 16
Top equ 16

pMovable equ ZW0
pPattern equ ZW0
pLists equ ZW1
pList equ ZW2
sCount equ ZB0
yMod equ ZB1
yCount equ ZB2
xCount equ ZB3


dseg
Sprites: public Sprites
Sprites_x:
    defs Sprite_End
Sprites_y:
    defs Sprite_End
Sprites_patternLow:
    defs Sprite_End
Sprites_patternHigh:
    defs Sprite_End
FirstOffset: public FirstOffset
    defb 0


cseg
InitSprites: public InitSprites
    jsr HideAllSprites_
rts

; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    pha
        lda #InvalidY
        ldx #0
        do
            sta Sprites_y,x | inx
            cpx #Sprite_End
        while ne | wend
        lda #0 | sta FirstOffset
    pla
rts    


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
dseg
ShowSprite_@Param1: public	ShowSprite_@Param1
ShowSprite_pattern:	
    defs 1
cseg
ShowSprite_: public ShowSprite_
    pha
        sty <pMovable | stx <pMovable+1
        ldy #2 | lda (<pMovable),y ; sprite index
        tax
        dey | lda (<pMovable),y ; y
        asl a
        clc|adc #Top
        sta Sprites_y,x
        dey | lda (<pMovable),y ; x
        clc|adc #Left
        sta Sprites_x,x

        lda #0 | sta <pPattern+1
        lda ShowSprite_pattern
        asl a
        asl a | rol <pPattern+1 ;*2
        sta Sprites_patternLow,x
        lda <pPattern+1 | adc #high SpritePattern | sta Sprites_patternHigh,x
    pla
rts


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    pha
        tya | tax
        lda #InvalidY
        sta Sprites_y,x
    pla
rts


; void UpdateSprites();
cseg
UpdateSprites_: public UpdateSprites_
    pha
        lda CurrentDPP
        cmp #low DisplayListList0
        if eq
            ldy #low DisplayListList1
            ldx #high DisplayListList1
            lda #high DisplayLists1
        else
            ldy #low DisplayListList0
            ldx #high DisplayListList0
            lda #high DisplayLists0
        endif
        sty CurrentDPP | stx CurrentDPP+1
        sta <pLists+1 | sta <pList+1
        lda #0 | sta <pLists | sta <pList

        lda #VramHeight | sta <yCount
        do
            ldy #5
            ldx #HorizontalSpriteCount
            lda #0
            do
                sta (<pList),y | iny
                sta (<pList),y | iny
                iny | iny
                dex
            while ne | wend
            lda <pList | clc|adc #DisplayListSize | sta <pList
            lda <pList+1 | adc #0 | sta <pList+1
            
            dec <yCount
        while ne | wend

        ldx FirstOffset
        lda #Sprite_End | sta <sCount
        do
            lda Sprites_y,x
            cmp #192
            if cc
                ldy #2 | sty <yCount
                tay
                    and #7
                    if ne
                        inc <yCount
                    endif
                    clc|adc #8 | sta <yMod
                    lda #0 | sta <pList+1
                tya
                and #$f8
                asl a | rol <pList+1 ;*16
                asl a | rol <pList+1 ;*32
                clc|adc <pLists | sta <pList
                lda <pList+1 | adc <pLists+1 | sta <pList+1
                
                do
                    ldy #5+1
                    lda #HorizontalSpriteCount | sta <xCount
                    do
                        lda (<pList),y ; color&size
                        if eq
                            dey
                            lda Sprites_patternLow,x | sta (<pList),y | iny
                            lda #-4 and $1f | sta (<pList),y | iny ; color&size
                            lda Sprites_patternHigh,x
                            clc|adc <yMod
                            sta (<pList),y | iny
                            lda Sprites_x,x | sta (<pList),y
                            jmp UpdateSprites_done
                        endif
                        iny | iny | iny | iny
                        dec <xCount
                    while ne | wend
                    UpdateSprites_done:
                    lda <yMod | sec|sbc #8 | sta <yMod

                    lda <pList | clc|adc #DisplayListSize | sta <pList
                    lda <pList+1 | adc #0 | sta <pList+1
                    
                    dec <yCount
                while ne | wend
            endif
            inx
            cpx #Sprite_End
            if cs
                ldx #0
            endif
            dec <sCount
        while ne | wend

        ldx FirstOffset
        inx
        cpx #Sprite_End
        if cs
            ldx #0
        endif
        stx FirstOffset

        do
            lda MSTAT
        while pl | wend
        lda CurrentDPP | sta <DPPL
        lda CurrentDPP+1 | sta <DPPH
    pla
rts