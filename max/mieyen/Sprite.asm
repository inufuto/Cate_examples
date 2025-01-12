include "Zeropage.inc"
include "Vram.inc"

; ext LastRaster_

Sprite_End equ 13
Top equ CharHeight*2+2


Patterns equ VicRam+$07F8
Positions equ $D000
UpperBits equ $D010
EnableBits equ $D015
Colors equ $D027
MaxSprites equ 8

pMovable equ ZW0

dseg
SpriteX:
    defs Sprite_End
SpriteY:
    defs Sprite_End
SpriteColor: public SpriteColor
    defs Sprite_End
SpritePattern:
    defs Sprite_End
nextIndex defb 0


cseg
InitSprites: public InitSprites
    lda #$ff | sta $D01C ; multicolor mode
    lda #0 | sta nextIndex
    jsr HideAllSprites_
rts


; void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
dseg
ShowSprite_@Param1:	public	ShowSprite_@Param1
ShowSprite_pattern:
	defb 0
ShowSprite_@Param2: public	ShowSprite_@Param2
ShowSprite_color:
	defb 0
cseg
ShowSprite_: public	ShowSprite_
    pha
        sty <pMovable
        stx <pMovable+1

        ldy #2
        lda (<pMovable),y | tax; sprite
        sei
            ldy #0
            lda (<pMovable),y ; x
            iny 
            sta SpriteX,x
            lda (<pMovable),y ; y
            clc|adc #Top
            sta SpriteY,x
            lda ShowSprite_pattern
            sta SpritePattern,x
            lda ShowSprite_color
            sta SpriteColor,x
        cli
    pla
rts


; void HideSprite(byte sprite);
cseg
HideSprite_: public HideSprite_
    pha
        tya | tax
        lda #0
        sei
            sta SpriteColor,x
        cli
    pla
rts


; void HideAllSprites()
cseg
HideAllSprites_: public HideAllSprites_
    pha
        sei
            ldx #0 | txa
            do
                sta SpriteColor,x
                inx
                cpx #Sprite_End
            while ne | wend
        cli
    pla
; jmp UpdateSprites_
rts


colorOffset equ ZB0
xyOffset equ ZB1
flagBit equ ZB2
eBits equ ZB3
uBits equ ZB4
cseg
UpdateSprites: public UpdateSprites
    pha
    lda <colorOffset | pha
    lda <xyOffset | pha
    lda <flagBit | pha
    lda <eBits | pha
    lda <uBits | pha
        lda #0
        sta <colorOffset
        sta <xyOffset
        sta <eBits
        sta <uBits

        ldx nextIndex
        do
            lda SpriteColor,x ; color
        while eq
            inx
            cpx #Sprite_End
            if eq
                ldx #0
            endif
            cpx nextIndex
            beq break1
        wend
        stx nextIndex

        lda #1
        sta <flagBit
        ldx nextIndex
        do
            lda SpriteColor,x
            if ne
                and #$0f
                ldy <colorOffset
                sta Colors,y
                lda SpritePattern,x
                sta Patterns,y
                iny
                sty <colorOffset
                
                ldy <xyOffset
                lda SpriteX,x ; x
                clc|adc #24
                sta Positions+0,y ; x
                if cs
                    lda SpriteColor,x
                    if pl
                        lda <uBits
                        ora <flagBit
                        sta <uBits
                    endif
                endif
                lda SpriteY,x ; y
                clc|adc #42
                sta Positions+1,y
                iny
                iny
                sty <xyOffset
                
                lda <eBits
                ora <flagBit
                sta <eBits
                
                asl <flagBit
                beq break2
            endif
            inx
            cpx #Sprite_End
            if eq
                ldx #0
            endif
            cpx nextIndex
        while ne | wend
        break2:
        ldx nextIndex
        inx
        cpx #Sprite_End
        if eq
            ldx #0
        endif
        stx nextIndex
        
        break1:
        lda <eBits
        sta EnableBits
        lda <uBits
        sta UpperBits
        exit:
    pla | sta <uBits
    pla | sta <eBits
    pla | sta <flagBit
    pla | sta <xyOffset
    pla | sta <colorOffset
    pla
rts
