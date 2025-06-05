include "VVram.inc"

; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    mov (rr0)+,r3
ret