ext TerrainMap_

; ptr<byte> TerrainMapPtr(byte x, byte y)
cseg
TerrainMapPtr_: public TerrainMapPtr_
    pushw rr2
        mult rr2,12
        clr r0
        addw rr0,rr2
        addw rr0,TerrainMap_
    popw rr2
ret
