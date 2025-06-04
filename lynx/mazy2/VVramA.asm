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
