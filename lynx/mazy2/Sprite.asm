include "Lynx.inc"
include "ZeroPage.inc"
include "Vram.inc"

ext SpritePattern
ext CurrentPage

Sprite_End equ 15
BlockSize equ 24
Top equ CharHeight*2

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

Sprite_pNext equ 3
Sprite_pPattern equ 5
Sprite_x equ 7
Sprite_y equ 9

dseg
HBlack:
    defs (1+VramWidth+1)*VramTop+1
; VBlack:
;     defs (1+VramLeft/2+1)*CharHeight*16+1
BackgroundSprite: public BackgroundSprite
    defs BlockSize
Sprites: public Sprites
    defs BlockSize*Sprite_End


pSprite equ ZW0
pMovable equ ZW1
pPrev equ ZW1
pBackup equ ZW1
wPos equ ZW2
pPattern equ ZW2

loopCount equ ZB0
xSize equ ZB1
ySize equ ZB2

cseg
BlockSource:
    defb $c5,$90,$00
    defw 0,0,VramLeft+8,VramTop+8
    defw $100,$100
    defb $01,$23,$45,$67,$89,$ab,$cd,$ef
    defb 0
TopBlackBlock: public TopBlackBlock
    defb $c1,$90,$00
    defw BottomBlackBlock,HBlack,8,8
    defw $100,$100
    defb $01,$23,$45,$67,$89,$ab,$cd,$ef
BottomBlackBlock: public BottomBlackBlock
    defb $c1,$90,$00
    defw 0,HBlack,8,8+102-VramTop
    defw $100,$100
    defb $01,$23,$45,$67,$89,$ab,$cd,$ef
; LeftBlackSprite:
;     defb $c1,$90,$00
;     defw RightBlackSprite,VBlack,8,8+VramTop
;     defw $100,$100
;     defb $01,$23,$45,$67,$89,$ab,$cd,$ef
; RightBlackSprite:
;     defb $c1,$90,$00
;     defw 0,VBlack,8+160-VramLeft,8+VramTop
;     defw $100,$100
;     defb $01,$23,$45,$67,$89,$ab,$cd,$ef


; void HideAllSprites();
cseg
InitPane:
    do
        ldy #0
        lda <xSize | sta (<pPattern),y | iny
        lda #0
        do
            sta (<pPattern),y | iny
            cpy <xSize
        while ne | wend    
        lda <pPattern | clc|adc <xSize | sta <pPattern
        lda <pPattern+1 | adc #0 | sta <pPattern+1
        dex
    while ne | wend
    lda #0 | sta (<pPattern)
rts
HideAllSprites_: public	HideAllSprites_
    pha
        lda #VramWidth | sta <xSize

        lda #low HBlack | sta <pPattern
        lda #high HBlack | sta <pPattern+1
        ldx #3
        jsr InitPane

        lda #low BackgroundOrg | sta <pPattern
        lda #high BackgroundOrg | sta <pPattern+1
        ldx #CharHeight*BackgroundHeight
        jsr InitPane

        lda #low BackgroundSprite | sta <pSprite
        lda #high BackgroundSprite | sta <pSprite+1
        ldx #Sprite_End+1
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

        lda #$c1 | sta BackgroundSprite
        lda #low BackgroundOrg | sta BackgroundSprite+Sprite_pPattern
        lda #high BackgroundOrg | sta BackgroundSprite+Sprite_pPattern+1
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
    sta <wPos | stz <wPos+1
    asl a | rol <wPos+1 ;*2
    clc|adc <wPos | sta <wPos
    lda <wPos+1 | adc #0 ;*3
    lsr a | ror <wPos ;*3/2
    lsr a | ror <wPos ;*3/4
    sta <wPos+1
rts

; void ShowSprite(ptr<Movable> pMovable, byte pattern);
dseg
ShowSprite_@Param1:	public	ShowSprite_@Param1
ShowSprite_pattern:
	defs 1
cseg
ShowSprite_: public	ShowSprite_
    pha
        sty <pMovable | stx <pMovable+1
        ldy #Movable_sprite | lda (<pMovable),y
        jsr ToSpritePtr
        
        ldy #Movable_x | lda (<pMovable),y
        jsr Scale
        ldy #Sprite_x
        lda <wPos | clc|adc #VramLeft+2 | sta (<pSprite),y | iny
        lda <wPos+1 | adc #0 | sta (<pSprite),y

        ldy #Movable_y | lda (<pMovable),y
        jsr Scale
        ldy #Sprite_y
        lda <wPos | clc|adc #VramTop+2+Top | sta (<pSprite),y | iny
        lda <wPos+1 | adc #0 | sta (<pSprite),y

        lda ShowSprite_pattern
        stz <pPattern
        lsr a | ror <pPattern
        sta <pPattern+1
        lda <pPattern | clc|adc #low SpritePattern | sta <pPattern
        lda <pPattern+1 | adc #high SpritePattern | sta <pPattern+1
        ldy #Sprite_pPattern
        lda <pPattern | sta (<pSprite),y | iny
        lda <pPattern+1 | sta (<pSprite),y
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


; void DrawSprites();
cseg
DrawSprites_: public DrawSprites_
    pha
        stz VIDBAS
        lda <CurrentPage | sta VIDBAS+1

        stz <pPrev | stz <pPrev+1
        lda #low Sprites | sta <pSprite
        lda #high Sprites | sta <pSprite+1
        ldx #Sprite_End
        do
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
                    lda <pSprite | sta BackgroundSprite+Sprite_pNext
                    lda <pSprite+1 | sta BackgroundSprite+Sprite_pNext+1
                endif
                lda <pSprite | sta <pPrev
                lda <pSprite+1 | sta <pPrev+1
            endif
            lda <pSprite | clc|adc #BlockSize | sta <pSprite
            lda <pSprite+1 | adc #0 | sta <pSprite+1
            dex
        while ne | wend
        lda <pPrev+1
        if ne
            ldy #Sprite_pNext
            lda #low TopBlackBlock | sta (<pPrev),y
            iny
            lda #high TopBlackBlock | sta (<pPrev),y
        else
            lda #low TopBlackBlock | sta BackgroundSprite+Sprite_pNext
            lda #high TopBlackBlock | sta BackgroundSprite+Sprite_pNext+1
        endif
                            _deb: public _deb
        lda #low BackgroundSprite | sta SCBNEXT
        lda #high BackgroundSprite | sta SCBNEXT+1
        lda #$01 | sta SPRGO
        lda #0 | sta SDONEACK
        do
            stz CPUSLEEP
            lda SPRSYS
            lsr a
        while cs | wend
    pla
rts
