ext CellMap_

ext @Temp@Word

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    sta <@Temp@Word+1
    clr <@Temp@Word
    lda #10
    mul
    addd <@Temp@Word
    addd #CellMap_
rts
