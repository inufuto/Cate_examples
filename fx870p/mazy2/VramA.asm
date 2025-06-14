include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

BlockWidth equ 96

dseg
Vram_: public Vram_
    defs VramRowSize*VramHeight
Backup:public Backup
    defs VVramWidth*VVramHeight
TopRow_: public TopRow_
    defb 0


; void ClearScreen();
cseg
Clear:
    do
        sti $31,(ix+$sx)
        sbw $10,$sy
    while nz | wend
rtn
ClearScreen_: public ClearScreen_
    phsw $10
        pre ix,Vram_
        ldw $10,VramRowSize*VramHeight
        cal Clear

        pre ix,Backup
        ldw $10,VVramWidth*VVramHeight
        cal Clear

        pre ix,VVramBack_
        ldw $10,VVramWidth*VVramHeight
        cal Clear
    ppsw $10
jp PresentVram_


; void PresentVram();
cseg
SendBytes:
    ppo &hdf
    stlm $0,3
    ppo &hde
    do
        ldi $4,(ix+$sx)
        stl $4
        sb $3,$sy
    while nz | wend
    xr $0,&h10
rtn
PresentVram_: public PresentVram_
    phsm $4,5
        pre ix,Vram_
        ld $0,&h82
        ld $1,$sx
        ld $2,$sx
        do
            ld $3,BlockWidth
            cal SendBytes
            ld $3,VramRowSize-BlockWidth
            cal SendBytes
            ad $2,$sy
            an $2,3
        while nz | wend
    ppsm $0,5
rtn


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
    defb " 0123456789=ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    phsm $1,2
        ld $0,$sx
        pre ix,CharTable
        do
            sbc (ix+$0),$1
            jr z,PrintC_break
            ad $0,$sy
            sbc $0,30
        while nz | wend
        ld $0,$sx
        PrintC_break:
        biu $0 | biu $0
        pre ix,AsciiPattern
        ldd $0,(ix+$0)
        pre iz,$10
        ld $1,CharWidth
        do
            ldi $0,(ix+$sx)
            sti $0,(iz+$sx)
            sb $1,$sy
        while nz | wend
        gre iz,$10
    ppsm $0,2
rtn


; ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
cseg
Put_: public Put_
    phsm $6,7
        cal MakeMask
        pre iz,$10 ; pVram
        cal Put
        gre iz,$10
    ppsm $0,7
rtn
MakeMask: ;($2=shift)
    ld $3,&he0 ; upperMask
    ld $4,$sx ; lowerMask
    ld $0,$2 ; count
    sbc $0,$sx
    do
    while nz
        bid $3 | rod $4
        sb $0,$sy
    wend
rtn
Put: ;(iz=pVram, $1=c)
    ld $10,$1 | ld $11,$sx
    adw $10,$10
    ldw $5,CharPattern
    adw $10,$5
    pre ix,$10

    ld $1,(ix+$sx)
    an $1,&hf0
    cal WriteByte

    ldi $1,(ix+$sx)
    biu $1 | biu $1 | biu $1 | biu $1
    cal WriteByte

    ld $1,(ix+$sx)
    an $0,&hf0
    cal WriteByte
rtn
WriteByte:
    ld $5,$1 ; upperSource
    ld $6,$sx ; lowerSource
    ld $0,$2 ; count
    sbc $0,$sx
    do
    while nz
        bid $5 | rod $6
        sb $0,$sy
    wend
    ld $0,$3 ; upperMask
    sbc $0,$sx
    if nz
        inv $0
        ld $1,(iz+$sx)
        an $0,$1
        or $0,$5 ; upperSource
        st $0,(iz+$sx)
    endif
    ld $0,$4 ; lowerMask
    sbc $0,$sx
    if nz
        inv $0
        ld $1,(iz+VramRowSize)
        an $0,$1
        or $0,$6 ; upperSource
        st $0,(iz+VramRowSize)
    endif
    ldi $0,(iz+$sx)
rtn


; void VVramToVram();
VVramToVram_: public VVramToVram_
    phsm $7,8
    phs $8
    phsm $17,8
    phsw $18
        pre ix,TopRow_ | ld $0,(ix+$sx)
        sbc $0,$sx
        if z
            ldw $12,VVramFront_+VVramWidth*1+1
        else
            ldw $12,VVramFront_+VVramWidth*2+1
        endif
        ldw $18,Vram_
        ldw $14,Backup

        ld $2,$sx ; shift
        ld $3,&he0 ; upperMask
        ld $4,$sx ; lowerMask
        
        ld $7,WindowHeight
        do
            pre iz,$18
            ld $8,WindowWidth
            do
                ld $1,($12)
                ld $0,($14)
                sbc $1,$0
                if nz
                    st $1,($14)
                    cal Put
                else
                    ldi $1,(iz+$sx)
                    ldi $1,(iz+$sx)
                    ldi $1,(iz+$sx)
                endif
                adw $12,$sy
                adw $14,$sy
                sb $8,$sy
            while nz | wend
            ldw $16,2 | adw $12,$16
    
            bid $3 | rod $4
            bid $3 | rod $4
            bid $3 | rod $4

            ad $2,3
            sbc $2,8
            if nc
                        _deb: public _deb
                sb $2,8
                cal MakeMask
                
                ldw $16,VramRowSize | adw $18,$16
            endif
            sb $7,$sy
        while nz | wend
    ppsw $18
    ppsm $10,8
    pps $8
    ppsm $0,8
rtn
