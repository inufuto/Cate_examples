ext @Temp@Word

ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
dseg
CellMapPtr_@Param1: public CellMapPtr_@Param1
    defb 0
cseg
cseg
CellMapPtr_: public CellMapPtr_
    psha
        lsra
        staa @Temp@Word+1
        ldaa CellMapPtr_@Param1
        asla ;*2
        asla ;*4
        asla ;*8
        adda @Temp@Word+1
        adda #low CellMap_
        staa @Temp@Word+1
        ldaa #0
        adca #high CellMap_
        staa @Temp@Word
        ldx @Temp@Word
    pula
rts
