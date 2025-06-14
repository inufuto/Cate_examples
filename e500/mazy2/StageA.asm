ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    pushs ba | pushs dx
        mv dh,a ; column
        mv a,il ; floor
        mv dl,a
        add a,a ;*2
        add a,dl ;*3
        add a,a ;*6
        add a,dh ; column
        mv x,CellMap_
        add x,a
    pops dx | pops ba
ret
