ext PanelMap_

zext @Temp@Word

; ptr<byte> MapPtr(byte column, byte row);
MapPtr_@Param1: public MapPtr_@Param1
MapPtr_row:
    defb 0
cseg
MapPtr_: public MapPtr_
    psha | pshb
        staa @Temp@Word+1
        ldab MapPtr_row
        aslb ;*2
        aslb ;*4
        aslb ;*8
        addb @Temp@Word+1
        clra
        addb #low PanelMap_ | adca #high PanelMap_
        staa @Temp@Word | stab @Temp@Word+1
        ldx @Temp@Word
    pulb | pula
rts
