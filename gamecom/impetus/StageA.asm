include "GameCom.inc"
include "Vram.inc"
include "VVram.inc"

ext Ground_
ext MapBytes_

GroundWidth equ VVramWidth/TileSize

; void CopyMapBytes(word wMap);
cseg
CopyMapBytes_: public CopyMapBytes_
    pushw rr0 | pushw rr8 | pushw rr10
        movw rr8,MapBytes_
        addw rr8,rr0
        movw rr10,Ground_
        mov r0,GroundWidth
        do
            mov r1,(rr8)+
            mov (rr10)+,r1
            dec r0
        while nz|wend
    popw rr10 | popw rr8 | popw rr0
ret
