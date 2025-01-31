ext CellMap_


; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    phsw $13
        ld $11,$0 ; column
        bid $11 ;/2
        ld $10,$1 ; floor
        biu $10 ;*2
        biu $10 ;*4
        ad $10,$11
        ld $11,$sx
        ldw $12,CellMap_ | adw $10,$12
    ppsw $12
rtn
