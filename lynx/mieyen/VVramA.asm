include "ZeroPage.inc"
include "VVram.inc"

ext VVram_

pVVram equ ZW0

; ptr<byte> VPut(ptr<byte> pVVram, byte c);
dseg
VPut_@Param1: public VPut_@Param1
VPut_c:
	defb 0
cseg
VPut_: public VPut_
    sty <pVVram | stx <pVVram+1
    ldy #0
    lda VPut_c
    sta (<pVVram),y
    ldy <pVVram
    iny
    if eq
        inx
    endif
rts


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        ldx #VVramHeight
        do
            ldy #0 | tya
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
