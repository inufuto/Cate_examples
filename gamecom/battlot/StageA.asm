ext WallMap_

; word WallMapPtr(byte x, byte y);
cseg
WallMapPtr_: public WallMapPtr_
    pushw rr2
        mult rr2,6
        srl r1 | srl r1
        clr r0
        addw rr0,rr2
        addw rr0,WallMap_
    popw rr2
ret
