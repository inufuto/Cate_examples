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
    push r1 | pushw rr2
        clr r1
        movw rr2,VVram
        do
            mov (rr2)+,r1
            cmpw rr2,VVram+VVramWidth*VVramHeight
        while nz|wend
    popw rr2 | pop r1
ret
