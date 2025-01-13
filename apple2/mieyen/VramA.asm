include "apple2.inc"
include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CharPattern, SpritePattern

TopOffset equ VramRowStep*2

dseg
CharColors: public CharColors
    defs Char_End
Backup: public Backup
Backup1:
	defs VVramWidth*VVramHeight
Backup2:
	defs VVramWidth*VVramHeight
pNextBackup:
    defw 0
NextPageH:
    defb 0


zseg
pVram:
    defw 0
xMod:
    defb 0
leftMask:
    defb 0
rightMask:
    defb 0
bottomH:
    defb 0
xModOrg:
    defb 0
pVramLeft:
    defb 0

pBackup equ ZW0
pPattern equ ZW1
pVVram equ ZW2
charCount equ ZB0
cByte equ ZB0
leftByte equ ZB1
rightByte equ ZB2
ColorBit equ ZB3
xCount equ ZB3
yCount equ ZB4
yPos equ ZB4

dseg
; Put_@Param0: public Put_@Param0
; PrintC_@Param0: public PrintC_@Param0
Param_vram:
    defw 0
Put_@Param1: public Put_@Param1
PrintC_@Param1: public PrintC_@Param1
Param_c:
    defb 0

cseg
ColorSource:
defb 64,$80 ; Ascii
defb 16,$80 ; Logo
defb 16,$80 ; Wall
defb 4,$80 ; Dot
defb 4,$00 ; Food
defb 4,$80 ; Remain
defb 8,$80 ; Man
defb 8,$80 ; Monster
defb 1,$80 ; FireBullet
defb 1,$80 ; Fire
defb 4,$80 ; Point
defb 0
InitVram: public InitVram
    ldy #0
    ldx #0
    do
        lda ColorSource,x
    while ne
        sta <charCount
        inx
        lda ColorSource,x | inx
        do
            sta CharColors,y | iny
            dec <charCount
        while ne | wend
    wend
rts


; void ClearScreen();
cseg
Clear:
    do
        lda #0
        ldy #0
        do
            sta (<pBackup),y
            iny
            cpy #VVramWidth
        while ne | wend
        lda <pBackup | clc|adc #VVramWidth | sta <pBackup
        lda <pBackup+1 | adc #0 | sta <pBackup+1
        dex
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram1 | sta <pVram
        lda #high Vram1 | sta <pVram+1
        lda #$80
        ldy #0
        ldx #$20*2
        do
            do
                sta (<pVram),y | iny
            while ne | wend
            inc <pVram+1
            dex
        while ne | wend

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1
        ldx #VVramHeight*2
        jsr Clear
        lda #low VVram_ | sta <pBackup
        lda #high VVram_ | sta <pBackup+1
        ldx #VVramHeight
        jsr Clear

        lda #low Backup2 | sta pNextBackup
        lda #high Backup2 | sta pNextBackup+1
        lda #high Vram2 | sta NextPageH
        lda TXTPAGE1
    pla
rts


cseg
ColumnOffsets8:
defb 0,1,2,3,4,5,6,8,9,10,11,12,13,14,16,17,18,19,20,21,22,24,25,26,27,28,29,30,32,33,34,35
ColumnMods8:
defb 0,1,2,3,4,5,6,0,1,2,3,4,5,6,0,1,2,3,4,5,6,0,1,2,3,4,5,6,0,1,2,3
LeftMasks8:
defb $0,$1,$3,$7,$F,$1F,$3F,$0,$1,$3,$7,$F,$1F,$3F,$0,$1,$3,$7,$F,$1F,$3F,$0,$1,$3,$7,$F,$1F,$3F,$0,$1,$3,$7
RightMasks8:
defb $7E,$7C,$78,$70,$60,$40,$0,$7E,$7C,$78,$70,$60,$40,$0,$7E,$7C,$78,$70,$60,$40,$0,$7E,$7C,$78,$70,$60,$40,$0,$7E,$7C,$78,$70
RowOffsetsL8:
defb $0,$80,$0,$80,$0,$80,$0,$80,$28,$A8,$28,$A8,$28,$A8,$28,$A8,$50,$D0,$50,$D0,$50,$D0,$50,$D0
RowOffsetsH8:
defb $0,$0,$1,$1,$2,$2,$3,$3,$0,$0,$1,$1,$2,$2,$3,$3,$0,$0,$1,$1,$2,$2,$3,$3

PreparePut:
    sta <pPattern
    tax
    lda CharColors,x | sta <ColorBit

    lda #0 | sta <pPattern+1
    lda <pPattern
    asl a | rol <pPattern+1 ;*2
    asl a | rol <pPattern+1 ;*4
    asl a | rol <pPattern+1 ;*8
    clc|adc #low CharPattern | sta <pPattern
    lda <pPattern+1 | adc #high CharPattern | sta <pPattern+1
rts
Sta21:
    sta (<pVram,x) | sta <cByte
    lda <pVram+1 | clc|adc #high Vram2-high Vram1 | sta <pVram+1
    lda <cByte | sta (<pVram,x)
    lda <pVram+1 | clc|adc #high Vram1-high Vram2 | sta <pVram+1
rts

; word Put(word vram, byte c);
cseg
Put_: public Put_
    sty Param_vram | stx Param_vram+1
    lda Param_vram | sta <yPos | and #31 | tax

    lda Param_vram+1
    lsr a | ror <yPos
    lsr a | ror <yPos
    lsr a | ror <yPos
    lsr a | ror <yPos
    lsr a | ror <yPos
    ldy <yPos
    lda RowOffsetsL8,y | sta <pVram
    lda RowOffsetsH8,y | clc|adc #high Vram1 | sta <pVram+1

    lda ColumnOffsets8,x | clc|adc <pVram | sta <pVram
    lda ColumnMods8,x | sta <xMod
    lda LeftMasks8,x | sta <leftMask
    lda RightMasks8,x | sta <rightMask

    lda Param_c
    jsr PreparePut
    ldy #0
    do
        lda #0 | sta <rightByte
        lda (pPattern),y
        ldx <xMod
        if ne
            do
                asl a | rol <rightByte
                dex
            while ne | wend
        endif
        sta <leftByte

        lda (<pVram,x) 
        and <leftMask | ora <leftByte | and #$7f | ora <ColorBit
        jsr Sta21
        inc <pVram

        asl <leftByte | rol <rightByte

        lda (pVram,x)
        and <rightMask | ora <rightByte | and #$7f | ora <ColorBit
        jsr Sta21
        dec <pVram

        lda <pVram+1 | clc|adc #4 | sta <pVram+1

        iny
        cpy #CharHeight
    while ne | wend

    lda Param_vram | clc|adc #1 | tay
    lda Param_vram+1 | adc #0 | tax
rts


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    lda Param_c
    sec|sbc #' '
    sta Param_c
jmp Put_


cseg
; void VVramToVram();
VVramToVram_: public VVramToVram_
    pha
        lda #low TopOffset | sta <pVram
        lda #high TopOffset | clc|adc NextPageH | sta <pVram+1
        clc|adc #(4-high TopOffset) | sta <bottomH

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1

        lda pNextBackup | sta <pBackup
        lda pNextBackup+1 | sta <pBackup+1

        lda #VVramHeight | sta <yCount
        do
            lda #0 | sta <xMod | sta <leftMask
            lda #$7e | sta <rightMask

            ldy #0
            do
                tya | pha
                    lda (pVVram),y
                    cmp (pBackup),y
                    if ne
                        sta (pBackup),y
                        cmp #Char_Space
                        if ne
                            jsr PreparePut
                            ldy #0
                            do
                                lda #0 | sta <rightByte
                                lda (pPattern),y
                                ldx <xMod
                                if ne
                                    do
                                        asl a | rol <rightByte
                                        dex
                                    while ne | wend
                                endif
                                sta <leftByte

                                lda (<pVram,x)
                                and <leftMask | ora <leftByte | and #$7f | ora <ColorBit
                                sta (<pVram,x)
                                inc <pVram

                                asl <leftByte | rol <rightByte

                                lda (pVram,x)
                                and <rightMask | ora <rightByte | and #$7f | ora <ColorBit
                                sta (<pVram,x)
                                dec <pVram

                                lda <pVram+1 | clc|adc #4 | sta <pVram+1

                                iny
                                cpy #CharHeight
                            while ne | wend
                        else
                            lda CharColors | sta <ColorBit
                            ldy #0
                            ldx #CharHeight
                            do
                                lda (<pVram),y
                                and <leftMask | ora <ColorBit
                                sta (<pVram),y
                                inc <pVram

                                lda (pVram),y
                                and <rightMask ora <ColorBit
                                sta (<pVram),y
                                dec <pVram

                                lda <pVram+1 | clc|adc #4 | sta <pVram+1

                                dex
                            while ne | wend
                        endif
                        lda <pVram+1 | sec|sbc #4*CharHeight | sta <pVram+1
                    endif
                    inc <pVram
                    inc <xMod

                    sec | rol <leftMask | asl <rightMask
                    lda <leftMask | cmp #$7f
                    if eq
                        inc <pVram

                        lda #0 | sta <xMod | sta <leftMask
                        lda #$7e | sta <rightMask
                    endif
                pla | tay
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            lda <pBackup | clc|adc #VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #0 | sta <pBackup+1

            lda <pVram | clc|adc #VramRowStep-36 | sta <pVram
            lda <pVram+1 | adc #0 | sta <pVram+1
            cmp <bottomH
            if cs
                lda <pVram | clc|adc #low VramBlockStep | sta <pVram
                lda <pVram+1 | adc #high VramBlockStep | sta <pVram+1
            endif
            dec <yCount
        while ne | wend
    pla
rts



; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    pha
        lda NextPageH
        cmp #high Vram1
        if eq
            lda TXTPAGE1
            lda #low Backup2 | sta pNextBackup
            lda #high Backup2 | sta pNextBackup+1
            lda #high Vram2
        else
            lda TXTPAGE2
            lda #low Backup1 | sta pNextBackup
            lda #high Backup1 | sta pNextBackup+1
            lda #high Vram1
        endif
        sta NextPageH
    pla
rts



CoordShift equ 1
CoordRate equ 1 shl CoordShift
CoordMask equ CoordRate-1

dseg
; DrawSprite_@Param0: public DrawSprite_@Param0
; EraseBackup_@Param0: public EraseBackup_@Param0
Param_x:
    defb 0
DrawSprite_@Param1: public DrawSprite_@Param1
EraseBackup_@Param1: public EraseBackup_@Param1
Param_y:
    defb 0
DrawSprite_@Param2: public DrawSprite_@Param2
Param_pattern:
    defb 0

cseg
; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    pha
        sty Param_x
        lda #2 | sta <xCount | sta <yCount
        lda #0 | sta <pBackup+1
        
        lda Param_y | tay
        and #CoordMask
        if ne
            inc <yCount
        endif
        tya
        and #not CoordMask
        asl a | rol <pBackup+1 ;*4
        asl a | rol <pBackup+1 ;*8
        asl a | rol <pBackup+1 ;*16
        asl a | rol <pBackup+1 ;*32
        clc|adc pNextBackup | sta <pBackup
        lda <pBackup+1 | adc pNextBackup+1 | sta <pBackup+1

        lda Param_x | tax
        and #CoordMask
        if ne
            inc <xCount
        endif
        txa
        lsr a
        clc|adc <pBackup | sta <pBackup
        lda <pBackup+1 | adc #0 | sta <pBackup+1

        do
            lda #$ff
            ldy #0
            ldx <xCount
            do
                sta (<pBackup),y | iny
                dex
            while ne | wend
            lda <pBackup | clc|adc #VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #0 | sta <pBackup+1

            dec <yCount
        while ne | wend
    pla
rts


cseg
ColumnOffsets4:
defb 0,0,1,1,2,2,3,4,4,5,5,6,6,7,8,8,9,9,10,10,11,12,12,13,13,14,14,15,16,16,17,17,18,18,19,20,20,21,21,22,22,23,24,24,25,25,26,26,27,28,28,29,29,30,30,31,32,32,33,33,34,34,35,36
ColumnMods4:
defb 0,4,1,5,2,6,3,0,4,1,5,2,6,3,0,4,1,5,2,6,3,0,4,1,5,2,6,3,0,4,1,5,2,6,3,0,4,1,5,2,6,3,0,4,1,5,2,6,3,0,4,1,5,2,6,3,0,4,1,5,2,6,3,0
; LeftMasks4:
; defb $0,$F,$1,$1F,$3,$3F,$7,$0,$F,$1,$1F,$3,$3F,$7,$0,$F,$1,$1F,$3,$3F,$7,$0,$F,$1,$1F,$3,$3F,$7,$0,$F,$1,$1F,$3,$3F,$7,$0,$F,$1,$1F,$3,$3F,$7,$0,$F,$1,$1F,$3,$3F,$7,$0,$F,$1,$1F,$3,$3F,$7,$0,$F,$1,$1F,$3,$3F,$7,$0
; RightMasks4:
; defb $7E,$60,$7C,$40,$78,$0,$70,$7E,$60,$7C,$40,$78,$0,$70,$7E,$60,$7C,$40,$78,$0,$70,$7E,$60,$7C,$40,$78,$0,$70,$7E,$60,$7C,$40,$78,$0,$70,$7E,$60,$7C,$40,$78,$0,$70,$7E,$60,$7C,$40,$78,$0,$70,$7E,$60,$7C,$40,$78,$0,$70,$7E,$60,$7C,$40,$78,$0,$70,$7E
RowOffsetsL4:
defb $0,$0,$80,$80,$0,$0,$80,$80,$0,$0,$80,$80,$0,$0,$80,$80,$28,$28,$A8,$A8,$28,$28,$A8,$A8,$28,$28,$A8,$A8,$28,$28,$A8,$A8,$50,$50,$D0,$D0,$50,$50,$D0,$D0,$50,$50,$D0,$D0,$50,$50,$D0,$D0
RowOffsetsH4:
defb $0,$10,$0,$10,$1,$11,$1,$11,$2,$12,$2,$12,$3,$13,$3,$13,$0,$10,$0,$10,$1,$11,$1,$11,$2,$12,$2,$12,$3,$13,$3,$13,$0,$10,$0,$10,$1,$11,$1,$11,$2,$12,$2,$12,$3,$13,$3,$13

; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
    pha
        sty Param_x
        lda #0 | sta <pPattern+1
        lda Param_pattern
        asl a | rol <pPattern+1 ;*2
        asl a | rol <pPattern+1 ;*4
        asl a | rol <pPattern+1 ;*8
        asl a | rol <pPattern+1 ;*16
        asl a | rol <pPattern+1 ;*32
        asl a | rol <pPattern+1 ;*64
        clc|adc #low SpritePattern | sta <pPattern
        lda <pPattern+1 | adc #high SpritePattern | sta <pPattern+1

        ldy Param_y
        iny | iny | iny | iny
        lda RowOffsetsL4,y | sta <pVram
        lda RowOffsetsH4,y | clc|adc NextPageH | sta <pVram+1

        ldx Param_x
        lda ColumnOffsets4,x | clc|adc <pVram | sta <pVram
        lda ColumnMods4,x | sta <xModOrg

        ldy #0
        lda #SpriteHeight | sta <yCount
        do
            lda <pVram | sta <pVramLeft
            lda <xModOrg | sta <xMod
            lda #SpriteWidth | sta <xCount
            do
                lda #0 | sta <rightMask | sta <rightByte
                lda (pPattern),y | iny | sta <leftMask
                lda (pPattern),y | iny | sta <leftByte
                ldx <xMod
                if ne
                    do
                        asl <leftMask | rol <rightMask
                        asl <leftByte | rol <rightByte
                        dex
                    while ne | wend
                endif
                lda <leftMask | ora <rightMask
                if ne
                    lda <leftMask | eor #$ff | sta <leftMask
                    lda <rightMask | eor #$ff | sta <rightMask
                    
                    lda (<pVram,x)
                    and <leftMask | ora <leftByte | and #$7f | ora #$80
                    sta (<pVram,x)
                    inc <pVram
                    asl <leftByte | rol <rightByte
                    asl <leftMask | rol <rightMask
                    lda (<pVram,x) 
                    and <rightMask | ora <rightByte | and #$7f | ora #$80
                    sta (<pVram,x)
                    dec <pVram
                endif
                inc <pVram
                ldx <xMod | inx
                cpx #7
                if cs
                                                    _deb: public _deb
                    ldx #0
                    inc <pVram
                endif
                stx <xMod

                dec <xCount
            while ne | wend
            lda <pVramLeft | sta <pVram
            lda <pVram+1 | clc|adc #$04 | sta <pVram+1
            and #$1c
            if eq
                lda <pVram | clc|adc #$80 | sta <pVram
                lda <pVram+1 | adc #-$20 | sta <pVram+1
                cmp <bottomH
                if cs
                    lda <pVram | clc|adc #low VramBlockStep | sta <pVram
                    lda <pVram+1 | adc #high VramBlockStep | sta <pVram+1
                endif
            endif
            dec <yCount
        while ne | wend
    pla
rts
