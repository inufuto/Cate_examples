ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
        srl r1,8
        li r2,5
        mpy r2,r1
        srl r0,8+1
        a r2,r0
        ai r0,CellMap_
    mov *r10+,r2
    mov *r10+,r1
rt
