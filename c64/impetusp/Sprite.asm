include "Zeropage.inc"
include "Vram.inc"

Sprite_End equ 38
Top equ CharHeight*1

Color1 equ 14
Color2 equ 2

Patterns equ VicRam+$07F8
Positions equ $D000
UpperBits equ $D010
EnableBits equ $D015
Colors equ $D027
MaxSprites equ 8

pMovable equ ZW0

dseg
Sprite_x:
    defs Sprite_End
Sprite_y:
    defs Sprite_End
Sprite_color: public Sprite_color
    defs Sprite_End
Sprite_pattern:
    defs Sprite_End
nextIndex:
    defb 0

dseg
ShowSpriteXY_@Param1: public ShowSpriteXY_@Param1
ShowSpriteXY_x:
    defb 0
ShowSpriteXY_@Param2: public ShowSpriteXY_@Param2
ShowSpriteXY_y:
    defb 0
ShowSprite_@Param1: public ShowSprite_@Param1
ShowSpriteXY_@Param3: public ShowSpriteXY_@Param3
ShowSprite_pattern:
ShowSpriteXY_pattern:
	defb 0
ShowSprite_@Param2: public ShowSprite_@Param2
ShowSpriteXY_@Param4: public ShowSpriteXY_@Param4
ShowSprite_color:
ShowSpriteXY_color:
	defb 0


cseg
InitSprites: public InitSprites
    lda #$ff | sta $D01C ; multicolor mode
    lda #Color1 | sta $D025
    lda #Color2 | sta $D026
    
    lda #0 | sta nextIndex
    jsr HideAllSprites_
rts


; void ShowSprite(ptrMovable> pMovable, byte pattern, byte color);
cseg
ShowSprite_: public	ShowSprite_
    pha
        sty pMovable | stx pMovable+1

        ldy #2
        lda (pMovable),y | tax; sprite
        sei
            ldy #0
            lda (pMovable),y ; x
            iny 
            sta Sprite_x,x
            lda (pMovable),y ; y
            clc|adc #Top
            sta Sprite_y,x
            lda ShowSprite_pattern
            sta Sprite_pattern,x
            lda ShowSprite_color
            sta Sprite_color,x
        cli
    pla
rts


; void ShowSpriteXY(byte index, byte x, byte y, byte pattern, byte color);
cseg
ShowSpriteXY_: public ShowSpriteXY_
    pha
        sei
            lda ShowSpriteXY_x
            sta Sprite_x,y
            lda ShowSpriteXY_y
            clc|adc #Top
            sta Sprite_y,y
            lda ShowSpriteXY_pattern
            sta Sprite_pattern,y
            lda ShowSpriteXY_color
            sta Sprite_color,y
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
            sta Sprite_color,x
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
                sta Sprite_color,x
                inx
                cpx #Sprite_End
            while ne | wend
        cli
    pla
; jmp UpdateSprites_
rts


scope
zseg
colorOffset:
    defb 0
xyOffset:
    defb 0
flagBit:
    defb 0
eBits:
    defb 0
uBits:
    defb 0
cseg
UpdateSprites: public UpdateSprites
    pha
        lda #0
        sta colorOffset
        sta xyOffset
        sta eBits
        sta uBits

        ldx nextIndex
        do
            lda Sprite_color,x ; color
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

        lda #$01
        sta flagBit
        ldx nextIndex
        do
            lda Sprite_color,x
            if ne
                and #$0f
                ldy colorOffset | sta Colors,y
                lda Sprite_pattern,x
                sta Patterns,y
                iny
                sty colorOffset
                
                ldy xyOffset
                lda Sprite_x,x ; x
                clc|adc #24
                sta Positions+0,y ; x
                if cs
                    lda uBits
                    ora flagBit
                    sta uBits
                endif
                lda Sprite_y,x ; y
                clc|adc #42
                sta Positions+1,y
                iny | iny
                sty xyOffset
                
                lda eBits
                ora flagBit
                sta eBits
                
                asl flagBit
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
        lda eBits
        sta EnableBits
        lda uBits
        sta UpperBits
        exit:
    pla
rts
endscope
