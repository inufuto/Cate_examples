include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext CellMap_

pCell equ @Temp@Word

dseg
GetCell_@Param1: public GetCell_@Param1
SetCell_@Param1: public SetCell_@Param1
Param_y:
    defb 0
SetCell_@Param2: public SetCell_@Param2
SetCell_c:
    defb 0


cseg
CellPtr:
    lsra
    staa <pCell+1
    ldab Param_y | clra
    aslb | rola ;*2
    aslb | rola ;*4
    aslb | rola ;*8
    addb <pCell+1 | adca #0
    addb #low CellMap_ | adca #high CellMap_
    stab <pCell+1 | staa <pCell
    ldx <pCell
rts


; byte GetCell(byte x, byte y);
cseg
GetCell_: public GetCell_
    pshb
        psha
            bsr CellPtr
        pula
        ldab 0,x
        anda #1
        if ne
            lsrb | lsrb | lsrb | lsrb
        endif
        andb #$0f
        tba
    pulb
rts


; byte SetCell(byte x, byte y, byte cell);
SetCell_: public SetCell_
    psha | pshb
        psha
            bsr CellPtr
        pula
        ldab SetCell_c
        anda #1
        if ne
            aslb | aslb | aslb | aslb
            ldaa 0,x
            anda #$0f
        else
            andb #$0f
            ldaa 0,x
            anda #$f0
        endif
        stab <@Temp@Byte
        oraa <@Temp@Byte
        staa 0,x
    pulb | pula
rts
