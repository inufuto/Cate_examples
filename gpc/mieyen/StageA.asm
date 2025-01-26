ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push v | push b
        rar | mov c,a
        mov a,e
        add a,a ;*2
        add a,a ;*4
        add a,c
        adi a,low CellMap_ | mov l,a
        mvi a,0 | aci a,high CellMap_ | mov h,a
    pop b | pop v
ret
