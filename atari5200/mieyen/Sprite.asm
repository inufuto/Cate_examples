include "atari5200.inc"
include "Vram.inc"
include "ZeroPage.inc"

ext SpritePattern
; ext DListJump

SpriteCount equ 13-1

PlayerHeight equ 256
TopY equ 17
MaxY equ PlayerHeight-TopY-SpriteHeight
LeftX equ 64
RowHeight equ 8 
CellRowCount equ MaxY/SpriteHeight

PlayerRam0 equ $1800
PlayerRam1 equ $1800+$800
PlayerPatternOffset equ $400+TopY
MissilePatternOffset equ $300+TopY
PlayerCount equ 4
Cell_unitSize equ 2

dseg
Sprites: public Sprites
Sprites_x:
    defs SpriteCount
Sprites_y:
    defs SpriteCount
Sprites_color:
    defs SpriteCount
Sprites_patternLow:
    defs SpriteCount
Sprites_patternHigh:
    defs SpriteCount
firstOffset: public firstOffset
    defb 0
clock:
    defb 0
busy:
    defb 0
oldY:
    defb 0

zseg
pPlayerRam: public pPlayerRam
    defw 0
pPlayerPatterns:
    defw 0
pActiveCells: public pActiveCells
    defw 0
pSource:
    defw 0
pDestination:
    defw 0
s_count:
p_count:
    defb 0
r_count:
    defb 0
c_count:
    defb 0
c_index_ini:
    defb 0
c_index:
    defb 0
s_offset:
    defb 0
d_offset:
    defb 0


cseg
DisplayListHandler: public DisplayListHandler
    pha
    txa | pha
    tya | pha
        lda VCOUNT
        cmp #(CellRowCount+1)*8
        if ne
            clc|adc #-(SpriteHeight/2)
            and #(not (SpriteHeight/2-1))
            tay
            ldx #0
            do
                lda (<pActiveCells),y | iny
                sta HPOSP0,x
                lda (<pActiveCells),y | iny
                sta COLPM0,x
                inx
                cpx #PlayerCount
            while ne | wend
        ; else
        ;     jsr UpdateSprites
        endif
    pla | tay
    pla | tax
    pla
rti


cseg
UpdateSprites: public UpdateSprites
    pha
        lda clock
        and #3
        bne skip
        lda busy
        bne skip
            inc busy
            lda #TopY | sta <pDestination
            lda #0 | sta <c_index
            lda #CellRowCount | sta <r_count
            do
                lda <pPlayerPatterns+1 | sta <pDestination+1
                lda #PlayerCount | sta <p_count
                do
                    ldy <c_index
                    lda (<pPlayerRam),y ; cell.x
                    if ne
                        lda #0 | sta (<pPlayerRam),y ; cell.x
                        ldy #0
                        do
                            sta (<pDestination),y
                            iny
                            cpy #SpriteHeight
                        while ne | wend
                    endif
                    inc <pDestination+1
                    ldy <c_index
                    iny | iny
                    sty <c_index
                    dec <p_count
                while ne | wend
                lda <pDestination | clc|adc #SpriteHeight | sta <pDestination
                dec <r_count
            while ne | wend


            lda #TopY | sta <pDestination
            lda #SpriteCount | sta <s_count
            ldx firstOffset
            do
                lda Sprites_patternHigh,x
                if ne
                    lda #0 | sta <s_offset
                    lda Sprites_y,x | sta <d_offset
                    ldy #2
                    and #$0f
                    if eq
                        dey
                    endif
                    sty <r_count
                    lda <d_offset
                    lsr a | and #$f8
                    sta <c_index_ini
                    do
                        lda <pPlayerPatterns+1 | sta <pDestination+1
                        lda <c_index_ini | sta <c_index
                        lda #PlayerCount | sta <c_count
                        do          
                            ldy <c_index      
                            lda (<pPlayerRam),y ; cell.x
                            if eq
                                lda Sprites_x,x 
                                clc|adc #LeftX
                                sta (<pPlayerRam),y ; cell.x
                                iny
                                lda Sprites_color,x
                                sta (<pPlayerRam),y ; cell.color
                                lda Sprites_patternLow,x | sta <pSource
                                lda Sprites_patternHigh,x | sta <pSource+1
                                do
                                    ldy <s_offset
                                    cpy #SpriteHeight
                                    beq c_end
                                    lda (<pSource),y | iny
                                    sty <s_offset
                                    ldy <d_offset
                                    sta (<pDestination),y | iny
                                    sty <d_offset
                                    tya
                                    and #$0f
                                while ne | wend
                                jmp c_end
                            endif
                            iny | iny
                            sty <c_index
                            inc <pDestination+1
                            dec <c_count
                        while ne | wend
                        lda <d_offset
                        clc|adc #SpriteHeight
                        pha
                            and #$f0
                            sta <d_offset
                        pla
                        sec|sbc <d_offset
                        clc|adc <s_offset
                        sta <s_offset
                        c_end:
                        lda <c_index_ini
                        clc|adc #Cell_unitSize*PlayerCount
                        sta <c_index_ini
                        dec <r_count
                    while ne | wend
                endif
                inx
                cpx #SpriteCount
                if eq
                    ldx #0
                endif
                dec <s_count
            while ne | wend

            ldx firstOffset
            inx
            cpx #SpriteCount
            if eq
                ldx #0
            endif
            stx firstOffset

            lda pActiveCells+1
            cmp #high PlayerRam0
            if eq
                lda #high PlayerRam1 | sta PMBASE | sta <pActiveCells+1
                lda #high PlayerRam0 | sta pPlayerRam+1
            else
                lda #high PlayerRam0 | sta PMBASE | sta <pActiveCells+1
                lda #high PlayerRam1 | sta pPlayerRam+1
            endif
            clc|adc #high PlayerPatternOffset | sta <pPlayerPatterns+1

            dec busy
        skip:
        inc clock
    pla
rts


cseg
InitSprites: public InitSprites
    pha
        jsr HideAllSprites_

        lda #0
        sta clock
        sta busy
        sta firstOffset
        sta <pPlayerRam
        sta <pPlayerPatterns 
        sta <pActiveCells

        sei
            ldx #high PlayerRam0
            do
                stx <pPlayerRam+1
                ldy #0
                do
                    sta (<pPlayerRam),y
                    iny
                while ne | wend
                inx
                cpx #(high PlayerRam1)+8
            while ne | wend
        cli

        lda #high PlayerRam0 | sta PMBASE | sta <pActiveCells+1
        lda #high PlayerRam1 | sta pPlayerRam+1
        clc|adc #high PlayerPatternOffset | sta <pPlayerPatterns+1
    pla
rts    


; void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
dseg
ShowSprite_@Param1: public	ShowSprite_@Param1
ShowSprite_.pattern_:	
    defb 0
ShowSprite_@Param2: public	ShowSprite_@Param2
ShowSprite_.color_:	
    defb 0
cseg
MakePatternAddress:
    pha
        lda ShowSprite_.pattern_ | sta <ZW1
        lda #0 | sta <ZW1+1
        asl <ZW1 | rol <ZW1+1 ;*2
        asl <ZW1 | rol <ZW1+1 ;*4
        asl <ZW1 | rol <ZW1+1 ;*8
        asl <ZW1 | rol <ZW1+1 ;*16
        lda <ZW1 | clc|adc #low SpritePattern | sta <ZW1
        lda <ZW1+1 | adc #high SpritePattern | sta <ZW1+1
    pla
rts
ShowSprite_: public ShowSprite_
    pha
        sty <ZW0 | stx <ZW0+1
        ldy #2 | lda (<ZW0),y ; sprite index
        if eq
            dey
            lda (<ZW0),y ; y position
            cmp #192
            if cc
                clc|adc #16
                pha
                    dey
                    lda (<ZW0),y ; x position
                    lsr a
                    clc|adc #LeftX
                    sta HPOSM3
                    clc|adc #2
                    sta HPOSM2
                    clc|adc #2
                    sta HPOSM1
                    clc|adc #2
                    sta HPOSM0
                pla
                jsr MakePatternAddress
                clc|adc #16 | sta <ZB0
                cmp oldY
                if ne
                    lda #0
                    ldy #SpriteHeight
                    ldx oldY
                    do
                        sta PlayerRam0+MissilePatternOffset,x
                        sta PlayerRam1+MissilePatternOffset,x
                        inx
                        dey
                    while ne | wend
                endif
                ldx <ZB0 | stx oldy
                ldy #0
                do
                    lda (<ZW1),y
                    sta PlayerRam0+MissilePatternOffset,x
                    sta PlayerRam1+MissilePatternOffset,x
                    inx
                    iny
                    cpy #SpriteHeight
                while ne | wend
            endif
        else
            tax | dex
            dey
            lda (<ZW0),y ; y position
            cmp #192
            if cc
                clc|adc #16
                jsr MakePatternAddress
                sei
                    clc|adc #16
                    sta Sprites_y,x
                    dey
                    lda (<ZW0),y ; x position
                    lsr a
                    sta Sprites_x,x
                    lda ShowSprite_.color_ | sta Sprites_color,x
                    lda <ZW1 | sta Sprites_patternLow,x
                    lda <ZW1+1 | sta Sprites_patternHigh,x
                cli
            endif
        endif
    pla
rts    


; void HideSprite(byte index);
cseg
HideMissiles:
    lda #0
    sta HPOSM3
    sta HPOSM2
    sta HPOSM1
    sta HPOSM0
rts
HideSprite_: public HideSprite_
    pha
        tya | tax
        if eq
            jsr HideMissiles
        else
            dex
            lda #0 | sta Sprites_patternHigh,x
        endif
    pla
rts    


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    pha
        jsr HideMissiles
        ldx #0
        do
            sta Sprites_patternHigh,x
            inx
            cpx #SpriteCount
        while ne | wend
    pla
rts    
