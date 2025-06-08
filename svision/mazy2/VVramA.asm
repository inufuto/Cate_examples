include "ZeroPage.inc"
include "VVram.inc"

dseg
VVram_: public VVram_
    defs VVramWidth*VVramHeight

pVVram equ ZW0

; ptr<byte> VPut(ptr<byte> pVVram, byte c);
dseg
VPut_@Param1: public VPut_@Param1
VPut_c:
	defb 0
cseg
VPut_: public VPut_
    sty <pVVram | stx <pVVram+1
    lda VPut_c
    sta (<pVVram)
    ldy <pVVram
    iny
    if eq
        inx
    endif
rts
