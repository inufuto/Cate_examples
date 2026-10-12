ext PanelMap_

zext @Temp@Word

; ptr<byte> MapPtr(byte column, byte floor);
cseg
MapPtr_: public MapPtr_
    sta @Temp@Word+1
    clr @Temp@Word
    lda #8
    mul
    addd @Temp@Word
    addd #PanelMap_
rts
