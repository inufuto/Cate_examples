include "VVram.inc"

ext VVramFront_, VVramBack_

; extern word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    pushs dx
        mv dh,a
        mv a,il
        mv il,dh
        mv dl,a
        add a,a ;*2
        add dl,a ;*3
        add a,a ;*4
        add a,a ;*8
        add a,a ;*16
        add dl,a ;*19
        mv dh,0
        mv ba,dx
        add ba,il
    pops dx
ret


; void VVramBackToFront()
cseg
VVramBackToFront_: public VVramBackToFront_
    pushs a | pushs i | pushs x | pushs y
        mv x,VVramBack_
        mv y,VVramFront_
        mv i,VVramWidth*VVramHeight
        do
            mv a,[x++]
            mv [y++],a
            dec i
        while nz | wend
    pops y | pops x | pops i | pops a
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    mv [x++],il
ret


; ToWord_: public ToWord_
;     mv ba,x
; ret


; ToSegment_: public ToSegment_
;     pushs si
;         mv si,x
;         mv a,(0dch)
;     pops si
; ret