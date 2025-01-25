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


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    mov (rr0)+,r3
ret