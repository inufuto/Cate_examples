include "Lynx.inc"
include "ZeroPage.inc"
include "Vram.inc"

ext SpritePattern
zext CurrentPage

Sprite_End equ 36
BlockSize equ 24
Top equ CharHeight*0

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

Sprite_pNext equ 3
Sprite_pPattern equ 5
Sprite_x equ 7
Sprite_y equ 9

dseg
VramBackSprite: public VramBackSprite
    defs BlockSize
Sprites: public Sprites
    defs BlockSize*Sprite_End
VramFrontSprite: public VramFrontSprite
    defs BlockSize

pSprite equ ZW0
pMovable equ ZW1
pPrev equ ZW1
pBackup equ ZW1
wPos equ ZW2
pPattern equ ZW2

loopCount equ ZB0
xPos equ ZB1
yPos equ ZB2

cseg
BlockSource:
    defb $c5,$90,$00
    defw 0,0,HOffset+VramLeft,VOffset+VramTop
    defw $100,$100
    defb $01,$23,$45,$67,$89,$ab,$cd,$ef
    defb 0
; TopBlackBlock: public TopBlackBlock
;     defb $c1,$90,$00
;     defw BottomBlackBlock,HBlack,8,8
;     defw $100,$100
;     defb $01,$23,$45,$67,$89,$ab,$cd,$ef
; BottomBlackBlock: public BottomBlackBlock
;     defb $c1,$90,$00
;     defw 0,HBlack,8,8+102-VramTop
;     defw $100,$100
;     defb $01,$23,$45,$67,$89,$ab,$cd,$ef


; void HideAllSprites();
cseg
InitPane:
    do
        ldy #0
        lda #VramWidth | sta (<pPattern),y | iny
        lda #0
        do
            sta (<pPattern),y | iny
            cpy #VramWidth
        while ne | wend    
        lda <pPattern | clc|adc #VramWidth | sta <pPattern
        lda <pPattern+1 | adc #0 | sta <pPattern+1
        dex
    while ne | wend
    lda #0 | sta (<pPattern)
rts
HideAllSprites_: public	HideAllSprites_
    pha
        lda #low VramBackOrg | sta <pPattern
        lda #high VramBackOrg | sta <pPattern+1
        ldx #CharHeight*BackHeight
        jsr InitPane

        lda #low VramFrontOrg | sta <pPattern
        lda #high VramFrontOrg | sta <pPattern+1
        ldx #CharHeight*FrontHeight
        jsr InitPane

        lda #low VramBackSprite | sta <pSprite
        lda #high VramBackSprite | sta <pSprite+1
        ldx #1+Sprite_End+1
        do
            ldy #0
            do
                lda BlockSource,y
                sta (<pSprite),y
                iny
                cpy #BlockSize
            while ne | wend
            lda <pSprite | clc|adc #BlockSize | sta <pSprite
            lda <pSprite+1 | adc #0 | sta <pSprite+1
            dex
        while ne | wend

        lda #$c1 | sta VramBackSprite
        lda #low VramBackOrg | sta VramBackSprite+Sprite_pPattern
        lda #high VramBackOrg | sta VramBackSprite+Sprite_pPattern+1

        lda #low VramFrontOrg | sta VramFrontSprite+Sprite_pPattern
        lda #high VramFrontOrg | sta VramFrontSprite+Sprite_pPattern+1
    pla
rts


ToSpritePtr:
    sta <pSprite
    asl a ;*2
    clc|adc <pSprite ;*3
    stz <pSprite+1
    asl a | rol <pSprite+1 ;*6
    asl a | rol <pSprite+1 ;*12
    asl a | rol <pSprite+1 ;*24
    clc|adc #low Sprites | sta <pSprite
    lda <pSprite+1 | adc #high Sprites | sta <pSprite+1
rts

Scale:
    clc|adc #64
    sta wPos | stz wPos+1
    asl a | rol wPos+1 ;*2
    clc|adc wPos | sta wPos
    lda wPos+1 | adc #0 ;*3
    lsr a | ror wPos ;*3/2
    lsr a | ror wPos ;*3/4
    sta wPos+1
    lda wPos | sec|sbc #64*3/4 | sta wPos
    lda wPos+1 | sbc #0 | sta wPos+1
rts

dseg
ShowSpriteXY_@Param1: public ShowSpriteXY_@Param1
ShowSprite_x:
	defb 0
ShowSpriteXY_@Param2: public ShowSpriteXY_@Param2
ShowSprite_y:
	defb 0
ShowSprite_@Param1:	public ShowSprite_@Param1
ShowSpriteXY_@Param3: public ShowSpriteXY_@Param3
ShowSprite_pattern:
	defb 0

cseg
ShowSprite: ;(a,xPos,yPos,ShowSprite_pattern)
    jsr ToSpritePtr

    lda xPos
    cmp #(WindowWidth-2)*8+1
    if cc
        jsr Scale
        ldy #Sprite_x
        lda wPos | clc|adc #VramLeft | sta (<pSprite),y | iny
        lda wPos+1 | adc #0 | sta (<pSprite),y

        lda yPos
        jsr Scale
        ldy #Sprite_y
        lda wPos | clc|adc #VramTop+Top | sta (<pSprite),y | iny
        lda wPos+1 | adc #0 | sta (<pSprite),y

        lda ShowSprite_pattern
        stz <pPattern
        lsr a | ror <pPattern
        sta <pPattern+1
        lda <pPattern | clc|adc #low SpritePattern | sta <pPattern
        lda <pPattern+1 | adc #high SpritePattern | sta <pPattern+1
        ldy #Sprite_pPattern
        lda <pPattern | sta (<pSprite),y | iny
        lda <pPattern+1 | sta (<pSprite),y
    else
        lda #0
        ldy #Sprite_pPattern
        sta (<pSprite),y | iny
        sta (<pSprite),y
    endif
rts

; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public	ShowSprite_
    pha
        sty <pMovable | stx <pMovable+1

        ldy #Movable_x | lda (<pMovable),y
        sta xPos

        ldy #Movable_y | lda (<pMovable),y
        sta yPos

        ldy #Movable_sprite | lda (<pMovable),y
        jsr ShowSprite
    pla
rts

; void ShowSpriteXY(byte index, byte x, byte y, sbyte pattern, byte color);
cseg
ShowSpriteXY_: public ShowSpriteXY_
    pha
        lda ShowSprite_x | sta xPos
        lda ShowSprite_y | sta yPos
        tya
        jsr ShowSprite
    pla
rts


; void HideSprite(byte index);
cseg
HideSprite_: public	HideSprite_
    pha
        tya
        jsr ToSpritePtr
        
        lda #0
        ldy #Sprite_pPattern
        sta (<pSprite),y | iny
        sta (<pSprite),y
    pla
rts


zext pVramBack

; void DrawSprites();
cseg
DrawSprites_: public DrawSprites_
    pha
        lda pVramBack | sta VramBackSprite+Sprite_pPattern
        lda pVramBack+1 | sta VramBackSprite+Sprite_pPattern+1

        stz VIDBAS
        lda <CurrentPage | sta VIDBAS+1

        stz <pPrev | stz <pPrev+1
        lda #low(Sprites+BlockSize*Sprite_End) | sta <pSprite
        lda #high(Sprites+BlockSize*Sprite_End) | sta <pSprite+1
        ldx #Sprite_End
        do
            lda <pSprite | sec|sbc #BlockSize | sta <pSprite
            lda <pSprite+1 | sbc #0 | sta <pSprite+1

            ldy #Sprite_pPattern+1
            lda (<pSprite),y
            if ne
                lda <pPrev+1
                if ne
                    ldy #Sprite_pNext
                    lda <pSprite | sta (<pPrev),y
                    iny
                    lda <pSprite+1 | sta (<pPrev),y
                else
                    lda <pSprite | sta VramBackSprite+Sprite_pNext
                    lda <pSprite+1 | sta VramBackSprite+Sprite_pNext+1
                endif
                lda <pSprite | sta <pPrev
                lda <pSprite+1 | sta <pPrev+1
            endif
            dex
        while ne | wend
        lda <pPrev+1
        if ne
            ldy #Sprite_pNext
            lda #low VramFrontSprite | sta (<pPrev),y
            iny
            lda #high VramFrontSprite | sta (<pPrev),y
        else
            lda #low VramFrontSprite | sta VramBackSprite+Sprite_pNext
            lda #high VramFrontSprite | sta VramBackSprite+Sprite_pNext+1
        endif

        lda #low VramBackSprite | sta SCBNEXT
        lda #high VramBackSprite | sta SCBNEXT+1
        lda #$01 | sta SPRGO
        lda #0 | sta SDONEACK
        do
            stz CPUSLEEP
            lda SPRSYS
            lsr a
        while cs | wend
    pla
rts
