include "Vram.inc"

ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push psw | push b
        rrc | ani 7
        mov c,a | mvi b,0
        
        mov a,e
        add a ;*2
        add a ;*4
        mov l,a | mvi h,0
        
        dad b
        lxi b,CellMap_
        dad b
    pop b | pop psw
ret
