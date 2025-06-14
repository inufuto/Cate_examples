ext CellMap_


; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    phsw $13
        ld $10,$1 ; floor
        biu $10 ;*2
        ad $10,$1 ;*3
        biu $10 ;*6
        ad $10,$0 
        ld $11,$sx
        ldw $12,CellMap_
        adw $10,$12
    ppsw $12
rtn
