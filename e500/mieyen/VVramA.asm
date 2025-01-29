include "VVram.inc"
include "Vram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public	VVramPtr_
    pushs a | pushs dl
        mv dl,a ;x
        mv a,il ;y
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        add a,dl
        mv x,VVram_
        add x,a
    pops dl | pops a
ret
