include "VVram.inc"

ext VVramBack_, VVramFront_

; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push v | push b
        mov c,a

        mov a,e
        add a,a ;*2
        add a,e ;*3
        add a,a ;*6

        add a,a | mov l,a ;*12
        mvi a,0 | aci a,0 | mov h,a

        mov a,l | add a,a | mov l,a ;*24
        mov a,h | adc a,a | mov h,a

        mov a,l | add a,c | mov l,a
        mov a,h | aci a,0 | mov h,a
    pop b | pop v
ret


; void VVramBackToFront();
VVramBackToFront_: public VVramBackToFront_
    push v | push h | push d | push b
        lxi h,VVramFront_
        lxi d,VVramBack_
        lxi b,VVramWidth*VVramHeight
        do
            ldax d+
            stax h+
            dcx b
            mov a,c | ora a,b
            sknz | eqa a,a
        repeat
    pop b | pop d | pop h | pop v
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    push v
        mov a,e
        stax h+
    pop v
ret
