include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext SpritePattern

PatternSize equ 16*4*2
Sprite_End equ 23
UnitSize equ 4

Top equ 64+8*2
Left equ 32

InvalidPattern equ $ff
SATB equ $7f00


dseg
Sprites: public Sprites
Sprites_y:
    defs Sprite_End
Sprites_x:
    defs Sprite_End
Sprites_pattern:
    defs Sprite_End
nextOffset:
    defb 0
zseg
xHigh:
    defb 0

pSource equ ZW0

cseg
InitSprites: public InitSprites
    pha
        sei
            defb $03,0 ; st0
            lda #low SpritePatternRam | sta >$0002
            lda #high SpritePatternRam | sta >$0003

            lda #low SpritePattern | sta <pSource
            lda #high SpritePattern | sta <pSource+1
            ldx #Pattern_End
            do
                ldy #0
                do
                    defb $03,2 ; st0
                    lda (<pSource),y | iny
                    sta >$0002
                    lda (<pSource),y | iny
                    sta >$0003
                    cpy #PatternSize
                while ne | wend
                lda <pSource | clc|adc #PatternSize | sta <pSource
                lda <pSource+1 | adc #0 | sta <pSource+1
                dex
            while ne | wend
        cli
        stz nextOffset
    pla
    jsr HideAllSprites_
rts


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    pha
        ldx #0
        lda #InvalidPattern
        do
            sta Sprites_pattern,x | inx
            cpx #Sprite_End
        while ne | wend
    pla
rts


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
dseg
ShowSprite_@Param1:	public ShowSprite_@Param1
	defs 1
cseg
ShowSprite_: public ShowSprite_
    pha
        sty <pSource | stx <pSource+1

        ldy #2 | lda (<pSource),y | tax ; index
        sei
            dey | lda (<pSource),y | clc|adc #8 | sta Sprites_y,x
            dey | lda (<pSource),y | sta Sprites_x,x
            lda ShowSprite_@Param1 | sta Sprites_pattern,x
        cli
    pla
rts


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    pha
        tya | tax ; index
        lda #InvalidPattern
        sei
            sta Sprites_pattern,x
        cli
    pla
rts


zseg
countAll:
    defb 0
countDone:
    defb 0
cseg
UpdateSprites: public UpdateSprites
    defb $03,0 ; st0
    defb $13,low SATB ; st1
    defb $23,high SATB ; st2

    lda #Sprite_End | sta <countAll | sta <countDone
    ldx nextOffset
    do
        lda Sprites_pattern,x
        cmp #InvalidPattern
        if ne
            lda Sprites_pattern,x
            and #$80
            if ne
                lda #-1
            endif
            sta <xHigh
            defb $03,$02 ; st0
            lda Sprites_y,x | clc|adc #Top | sta >$0002
            lda #0 | adc #0 | sta >$0003
            defb $03,$02 ; st0
            lda Sprites_x,x | clc|adc #Left | sta >$0002
            lda #0 | adc <xHigh | sta >$0003
            defb $03,$02 ; st0
            lda Sprites_pattern,x | and #$7f | asl a | sta >$0002
            defb $23,$01 ; st2
            
            defb $03,$02 ; st0
            defb $13,$80 ; st1
            defb $23,$00 ; st2
            dec <countDone
        endif
        inx
        cpx #Sprite_End
        if cs
            ldx #0
        endif
        dec <countAll
    while ne | wend

    do
        lda <countDone
    while ne
        defb $03,$02 ; st0
        defb $13,$00 ; st1
        defb $23,$00 ; st2
        
        defb $03,$02 ; st0
        defb $13,$00 ; st1
        defb $23,$00 ; st2

        defb $03,$02 ; st0
        defb $13,$00 ; st1
        defb $23,$00 ; st2

        defb $03,$02 ; st0
        defb $13,$80 ; st1
        defb $23,$00 ; st2

        dec <countDone
    wend

    defb $03,$13 ; st0
    defb $13,low SATB ; st1
    defb $23,high SATB ; st2

    ldx nextOffset | inx
    cpx #Sprite_End
    if cs
        ldx #0
    endif
    stx nextOffset
rts
