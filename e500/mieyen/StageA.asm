ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    pushs ba | pushs dx
        rc|shr a  ; column
        mv dl,a
        mv a,il ; floor
        add a,a ;*2
        add a,a ;*4
        add a,dl ; column
        mv x,CellMap_
        add x,a
    pops dx | pops ba
ret
