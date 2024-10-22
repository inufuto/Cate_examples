ext TerrainMap_

cseg

; ptr<byte> TerrainMapPtr(byte x, byte y)
cseg
TerrainMapPtr_: public TerrainMapPtr_
    push af | push bc
        ld c,a

        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        ld b,0
        add hl,bc
        ld bc,TerrainMap_
        add hl,bc
    pop bc | pop af
ret
