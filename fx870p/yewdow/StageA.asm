ext CellMap_


cseg
CellPtr: ; ->$10
    phs $0 ; x
    phsw $13
        ld $10,$1 ;y
        biu $10 ;*2
        ad $10,$1 ;*3
        biu $10 ;*6
        bid $0 ;x
        ad $10,$0
        ld $11,$sx ;0
        ldw $12,CellMap_
        adw $10,$12
    ppsw $12
    pps $0
rtn


; byte GetCell(byte x, byte y);
cseg
GetCell_: public GetCell_
    phsw $11
        cal CellPtr
        anc $0,1
        ld $0,($10)
        if nz
            bid $0 | bid $0 | bid $0 | bid $0
        endif
        an $0,&h0f
    ppsw $10
rtn


; byte SetCell(byte x, byte y, byte cell);
cseg
SetCell_: public SetCell_
    phsw $1
    phsw $11
        cal CellPtr
        ld $1,$2
        anc $0,1
        if nz
            biu $1 | biu $1 | biu $1 | biu $1
            ld $0,($10)
            an $0,&h0f
        else
            an $1,&h0f
            ld $0,($10)
            an $0,&hf0
        endif
        or $0,$1
        st $0,($10)
    ppsw $10
    ppsw $0
rtn
