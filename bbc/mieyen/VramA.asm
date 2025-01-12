include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern

VramTop equ Vram+VramRowSize*1
ToNextRow equ CharHeight*(VramWidth-VVramWidth)

pSource equ ZW0
pDestination equ ZW1
pVVram equ ZW2
pBackup equ ZW3
yCount equ ZB0
xOffset equ ZB1


dseg
Backup:
    defs VVramWidth*VVramHeight


; void ClearScreen();
cseg
Clear:
    do
        lda #0
        ldy #0
        do
            sta (<pDestination),y
            iny
            cpy #VVramWidth
        while ne | wend
        lda <pDestination | clc|adc #VVramWidth | sta <pDestination
        lda <pDestination+1 | adc #0 | sta <pDestination+1
        dex
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pha
        lda #low VramOrg | sta pDestination
        lda #high VramOrg | sta pDestination+1
        lda #0
        ldx #$80-high VramOrg
        do
            ldy #0
            do
                sta (<pDestination),y
                iny
            while ne | wend
            inc <pDestination+1
            dex
        while ne | wend

        lda #low Backup | sta <pDestination
        lda #high Backup | sta <pDestination+1
        ldx #VVramHeight
        jsr Clear

        lda #low VVramBack_ | sta <pDestination
        lda #high VVramBack_ | sta <pDestination+1
        ldx #VVramHeight*2
        jsr Clear
    pla
rts


cseg
Put1:
    sta <pSource
    lda #0 | sta <pSource+1
    asl <pSource | rol <pSource+1 ; *2
    asl <pSource | rol <pSource+1 ; *4
    asl <pSource | rol <pSource+1 ; *8
    lda <pSource | clc|adc #low CharPattern | sta <pSource
    lda <pSource+1 | adc #high CharPattern sta <pSource+1
    ldy #0
    do
        lda (<pSource),y
        sta (<pDestination),y
        iny
        cpy #CharHeight
    while ne | wend
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
cseg
Put_: public Put_
    pha
        sty <pDestination | stx <pDestination+1
        
        lda Put_c
        jsr Put1

        lda <pDestination | clc | adc #low CharHeight | tay
        lda <pDestination+1 | adc #high CharHeight | tax
    pla
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        lda #low VVramFront_ | sta <pVVram
        lda #high VVramFront_ | sta <pVVram+1
        lda #low VramTop | sta <pDestination
        lda #high VramTop | sta <pDestination+1
        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #VVramHeight | sta <yCount
        do
            ldy #0
            do
                lda (<pVVram),y
                cmp (<pBackup),y
                if ne
                    sta (<pBackup),y
                    sty <xOffset
                    jsr Put1
                    ldy <xOffset
                endif
                lda <pDestination | clc | adc #low CharHeight | sta <pDestination
                lda <pDestination+1 | adc #high CharHeight | sta <pDestination+1

                iny
                cpy #VVramWidth
            while ne | wend
            lda <pDestination | clc | adc #low(CharHeight*(VramWidth-VVramWidth))  | sta <pDestination
            lda <pDestination+1 | adc #high(CharHeight*(VramWidth-VVramWidth)) | sta <pDestination+1

            lda <pVVram | clc | adc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #high VVramWidth | sta <pVVram+1

            lda <pBackup | clc | adc #low VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #high VVramWidth | sta <pBackup+1

            dec <yCount
        while ne | wend
    pla
rts
