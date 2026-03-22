ext CellMap_

ext @Temp@Word

; ptr<byte> CellMapPtr(byte column, byte floor);
dseg
CellMapPtr_@Param1: public CellMapPtr_@Param1
    defb 0
cseg
CellMapPtr_: public CellMapPtr_
    psha | pshb
        staa <@Temp@Word+1
        ldaa CellMapPtr_@Param1
        anda #$fe
        asla ;*4
        asla ;*8
        asla ;*16
        adda <@Temp@Word+1
        adda #low CellMap_ | staa <@Temp@Word+1
        ldaa #0 | adca #high CellMap_ | staa <@Temp@Word
        ldx <@Temp@Word
    pulb | pula
rts
