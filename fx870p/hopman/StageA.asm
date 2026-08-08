ext CellMap_


; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    phsw $13
        ld $10,$1
        biu $10 ;*2
        ad $10,$1 ;*3
        biu $10 ;*6
        ld $11,$sx
        biuw $10 ;*12
        biuw $10 ;*24
        ld $12,$0
        bid $12 | bid $12
        ld $13,$sx
        adw $10,$12
        ldw $12,CellMap_
        adw $10,$12
    ppsw $12
rtn