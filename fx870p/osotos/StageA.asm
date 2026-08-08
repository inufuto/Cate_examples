ext CellMap_


; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    phsw $13
        ld $10,$1 ; floor
        ld $11,&hfe | an $10,$11
        ld $11,$10
        biu $10 ;*4
        ad $10,$11 ;*6
        biu $10 ;*12
        ad $10,$0
        ld $11,$sx
        ldw $12,CellMap_
        adw $10,$12
    ppsw $12
rtn
