include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext CharPattern
ext WaitVSync

pSource equ ZW0
pVVram equ ZW2
pBackup equ ZW3
yCount equ ZB0

VramTop equ Vram+VramRowSize*2
ToNextRow equ VramRowSize-VVramWidth

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
        lda #high Vram | sta ClearScreen_st+1+1
        lda #0 | sta ClearScreen_st+1
        ldx #VramHeight
        do
            ldy #0
            do
                ClearScreen_st:
                sta Vram
                inc ClearScreen_st+1
            while ne | wend
            inc ClearScreen_st+1+1
            dex
        while ne | wend

        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1
        ldx #VVramHeight
        jsr Clear

        lda #low VVramBack_ | sta <pBackup
        lda #high VVramBack_ | sta <pBackup+1
        ldx #VVramHeight*2
        jsr Clear
    pla
rts


cseg
MakeCharSource:

Put1:
    ldx #0 | stx <pSource+1
    asl a | rol <pSource+1 ; *2
    asl a | rol <pSource+1 ; *4
    asl a | rol <pSource+1 ; *8
    clc|adc #low CharPattern | sta Put1_ld+1
    lda <pSource+1 | adc #high CharPattern | sta Put1_ld+1+1
    do
        Put1_ld:
        lda CharPattern,x | inx
        Put1_st:
        sta Vram
        lda Put1_st+1 | clc|adc #VramWidth | sta Put1_st+1
        cpx #CharHeight
    while ne | wend
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
Put_pVram:
PrintC_pVram:
    defw 0
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
cseg
Put_: public Put_
    pha
        sty Put_pVram | sty Put1_st+1
        stx Put_pVram+1 | stx Put1_st+1+1
        
        lda Put_c
        jsr Put1

        ldy Put_pVram | iny
        ldx Put_pVram+1
    pla
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        jsr WaitVSync

        lda #high VramTop | sta Put1_st+1+1

        lda #low VVramFront_ | sta <pVVram
        lda #high VVramFront_ | sta <pVVram+1
        
        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        lda #VVramHeight | sta <yCount
        do
            ldy #0 | sty Put1_st+1
            do
                lda (<pVVram),y
                cmp (<pBackup),y
                if ne
                    sta (<pBackup),y
                    jsr Put1
                endif
                inc Put1_st+1

                iny
                cpy #VVramWidth
            while ne | wend
            inc Put1_st+1+1

            lda <pVVram | clc | adc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #high VVramWidth | sta <pVVram+1

            lda <pBackup | clc | adc #low VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #high VVramWidth | sta <pBackup+1

            dec <yCount
        while ne | wend
    pla
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
dseg
PrintC_@Param1: public PrintC_@Param1
PrintC_c:	defs 1
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    pha
        sty PrintC_pVram | sty Put1_st+1
        stx PrintC_pVram+1 | stx Put1_st+1+1

        lda PrintC_@Param1
        ldx #0
        do
            cmp CharTable,x
            beq PrintC_exit
            inx
            cpx #30
        while ne | wend
        ldx #0
        PrintC_exit:        
        txa
        jsr Put1
        ldy PrintC_pVram | iny
        ldx PrintC_pVram+1
    pla
rts