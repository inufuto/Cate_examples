ext CellMap_

ext @Temp@Word

; ptr<byte> CellMapPtr(byte column, byte floor);
dseg
cseg
CellMapPtr_: public CellMapPtr_
    sta <@Temp@Word+1
    clr <@Temp@Word
    andb #$fe
    lda #8
    mul
    addd <@Temp@Word
    addd #CellMap_
rts
