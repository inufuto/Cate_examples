ext CellMap_

ext @Temp@Word

; ptr<byte> CellMapPtr(byte column, byte row);
CellMapPtr_@Param1: public CellMapPtr_@Param1
CellMapPtr_row:
    defb 0
cseg
CellMapPtr_: public CellMapPtr_
    psha | pshb
        staa <@Temp@Word+1
        ldab CellMapPtr_row
        aslb ;*2
        addb CellMapPtr_row ;*3
        aslb ;*6
        addb <@Temp@Word+1
        clra
        addb #low CellMap_ | adca #high CellMap_
        staa <@Temp@Word | stab <@Temp@Word+1
        ldx <@Temp@Word
    pulb | pula
rts
