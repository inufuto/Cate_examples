include "VVram.inc"

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    pushw rr2
        mult rr2,VVramWidth
        clr r0
        addw rr0,rr2
        addw rr0,VVram
    popw rr2
ret


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pushw rr0 | push r2
        clr r2
        movw rr0,VVram
        do
            mov (rr0)+,r2
            cmpw rr0,VVram+VVramWidth*VVramHeight
        while nz|wend
    pop r2 | popw rr0
ret
