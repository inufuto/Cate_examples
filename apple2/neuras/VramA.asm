include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramFront_
ext CharPattern

VramTop equ Vram0+VramRowStep*2

dseg
CharColors: public CharColors
    defs Char_End
Backup: public Backup
    defs VVramWidth*VVramHeight
zseg
pVram:
    defw 0
xMod:
    defb 0
leftMask:
    defb 0
rightMask:
    defb 0

pBackup equ ZW0
pPattern equ ZW1
pVVram equ ZW2
charCount equ ZB0
leftByte equ ZB1
rightByte equ ZB2
ColorBit equ ZB3
yCount equ ZB4
yPos equ ZB4

dseg
Put_@Param0: public Put_@Param0
PrintC_@Param0: public PrintC_@Param0
Param_vram:
    defw 0
Put_@Param1: public Put_@Param1
PrintC_@Param1: public PrintC_@Param1
Param_c:
    defb 0

cseg
ColorSource:
defb 64,$80 ; Ascii
defb 16,$80 ; Wall
defb 32,$80 ; Solver
defb 32,$80 ; Monster
defb 56,$80 ; Card
defb 24,$80 ; Title
defb 0
InitVram: public InitVram
    pha
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
    pla
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram0 | sta <pVram
        lda #high Vram0 | sta <pVram+1
        lda #$80
        ldy #0
        ldx #$20
        do
            do
                sta (<pVram),y | iny
            while ne | wend
            inc <pVram+1
            dex
        while ne | wend

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1
        ldx #VVramHeight
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
    pla
rts


cseg
Put1:
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
    lda <pVram+1 | sec|sbc #4*CharHeight | sta <pVram+1
NextColumn:
    inc <pVram
    inc <xMod

    sec | rol <leftMask | asl <rightMask
    lda <leftMask | cmp #$7f
    if eq
        inc <pVram

        lda #0 | sta <xMod | sta <leftMask
        lda #$7e | sta <rightMask
    endif
rts


cseg
; void VVramToVram();
VVramToVram_: public VVramToVram_
    pha
        lda #low VramTop | sta <pVram
        lda #high VramTop | sta <pVram+1

        lda #low VVramFront_ | sta <pVVram
        lda #high VVramFront_ | sta <pVVram+1

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

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
                        jsr Put1
                    else
                        jsr NextColumn
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
            cmp #$24
            if eq
                lda <pVram | clc|adc #low VramBlockStep | sta <pVram
                lda <pVram+1 | adc #high VramBlockStep | sta <pVram+1
            endif
            dec <yCount
        while ne | wend
    pla
rts


ColumnOffsets:
defb 0,1,2,3,4,5,6,8
defb 9,10,11,12,13,14,16,17
defb 18,19,20,21,22,24,25,26
defb 27,28,29,30,32,33,34,35
ColumnMods:
defb 0,1,2,3,4,5,6,0
defb 1,2,3,4,5,6,0,1
defb 2,3,4,5,6,0,1,2
defb 3,4,5,6,0,1,2,3
LeftMasks:
defb $0,$1,$3,$7,$F,$1F,$3F,$0
defb $1,$3,$7,$F,$1F,$3F,$0,$1
defb $3,$7,$F,$1F,$3F,$0,$1,$3
defb $7,$F,$1F,$3F,$0,$1,$3,$7
RightMasks:
defb $7E,$7C,$78,$70,$60,$40,$0,$7E
defb $7C,$78,$70,$60,$40,$0,$7E,$7C
defb $78,$70,$60,$40,$0,$7E,$7C,$78
defb $70,$60,$40,$0,$7E,$7C,$78,$70
RowOffsetsL:
defb $0,$80,$0,$80,$0,$80,$0,$80
defb $28,$A8,$28,$A8,$28,$A8,$28,$A8
defb $50,$D0,$50,$D0,$50,$D0,$50,$D0
RowOffsetsH:
defb $0,$0,$1,$1,$2,$2,$3,$3
defb $0,$0,$1,$1,$2,$2,$3,$3
defb $0,$0,$1,$1,$2,$2,$3,$3


; void Put(byte c);
cseg
Put_: public Put_
    lda Param_vram | sta <yPos | and #31 | tax

    lda Param_vram+1
    lsr a | ror <yPos
    lsr a | ror <yPos
    lsr a | ror <yPos
    lsr a | ror <yPos
    lsr a | ror <yPos
    ldy <yPos
    lda RowOffsetsL,y | sta <pVram
    lda RowOffsetsH,y | clc|adc #high Vram0 | sta <pVram+1

    lda ColumnOffsets,x | clc|adc <pVram | sta <pVram
    lda ColumnMods,x | sta <xMod
    lda LeftMasks,x | sta <leftMask
    lda RightMasks,x | sta <rightMask

    lda Param_c
    jsr Put1
    lda Param_vram | clc|adc #1 | tay
    lda Param_vram+1 | adc #0 | tax
rts


; void PrintC(byte c);
cseg
PrintC_: public PrintC_
    lda Param_c
    sec|sbc #' '
    sta Param_c
jmp Put_
