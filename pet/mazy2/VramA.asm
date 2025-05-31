include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_

VramTop equ Vram+VramRowSize*1

pVram equ ZW0
pVVram equ ZW1
pBackup equ ZW2
yCount equ ZB0
flagOffset equ ZB1
flagBit equ ZB2


dseg
Backup: defs VVramWidth*VVramHeight


cseg
WaitVBlank:
    pha
        do
            lda $E813
            and #$02
        while ne | wend
    pla
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        lda #low Vram | sta <pVram
        lda #high Vram | sta <pVram+1
        ldx #VramHeight
        do
            ldy #0
            do
                lda #Char_Space | sta (<pVram),y | iny
                cpy #VramWidth
            while ne | wend
            lda <pVram | clc|adc #low VramRowSize | sta <pVram
            lda <pVram+1 | adc #high VramRowSize | sta <pVram+1
            dex
        while ne | wend

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1
        ldx #VVramHeight
        do
            ldy #0
            do
                lda #Char_Space | sta (<pBackup),y | iny
                cpy #VVramWidth
            while ne | wend
            lda <pBackup | clc|adc #low VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #high VVramWidth | sta <pBackup+1
            dex
        while ne | wend

        lda #low VVramBack_ | sta <pVVram
        lda #high VVramBack_ | sta <pVVram+1
        ldx #VVramHeight
        do
            lda #Char_Space
            ldy #0
            do
                sta (<pVVram),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1
            dex
        while ne | wend
    pla
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VVramFront_ | sta <pVVram
        lda #high VVramFront_ | sta <pVVram+1

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #low VramTop | sta <pVram
        lda #high VramTop | sta <pVram+1

        lda #VVramHeight | sta <yCount
        do
            ldy #0
            do
                lda (<pVVram),y
                cmp (<pBackup),y
                if ne
                    sta (<pBackup),y
                    jsr WaitVBlank
                    sta (<pVram),y
                endif
                iny
                cpy #VVramWidth
            while ne | wend

            lda <pVVram | clc | adc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #high VVramWidth | sta <pVVram+1

            lda <pBackup | clc | adc #low VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #high VVramWidth | sta <pBackup+1

            lda <pVram | clc | adc #low VramRowSize | sta <pVram
            lda <pVram+1 | adc #high VramRowSize | sta <pVram+1

            dec <yCount
        while ne | wend
    pla
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
dseg
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
cseg
PrintC_: public PrintC_
    pha
        sty <pVram | stx <pVram+1
        lda PrintC_c
        cmp #$40
        if cs
            sbc #$40
        endif
        ldy #0 | sta (<pVram),y
        lda <pVram | clc|adc #1 | tay
        lda <pVram+1 | adc #0 | tax
    pla
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    sty <pVram | stx <pVram+1
    ldy #0
    lda Put_c
    sta (<pVram),y
    ldy <pVram
    iny
    if eq
        inx
    endif
rts
