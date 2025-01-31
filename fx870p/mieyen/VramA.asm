include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVram_

BlockWidth equ 96

dseg
Vram_: public Vram_
    defs VramRowSize*VramHeight
Backup:public Backup
    defs VVramWidth*VVramHeight


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
    defb " 0123456789=ACEGHKMNOPRSTUVY"
PrintC_: public PrintC_
    phsm $1,2
        ld $0,$sx
        pre ix,CharTable
        do
            sbc (ix+$0),$1
            jr z,PrintC_break
            ad $0,$sy
            sbc $0,28
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
CharPtrIx:
    ld $1,$sx
    biuw $0 ;*2
    biuw $0 ;*4
    biuw $0 ;*8
    ldw $2,CharPattern
    adw $0,$2
    pre ix,$0
rtn
Put_: public Put_
    phsm $3,4
        pre iz,$10
        ld $0,$1
        cal CharPtrIx
        ld $1,8
        do
            ldi $0,(ix+$sx)
            sti $0,(iz+$sx)
            sb $1,$sy
        while nz | wend
        gre iz,$10
    ppsm $0,4
rtn


; void VVramToVram();
VVramToVram_: public VVramToVram_
    phsm $5,6
    phsm $17,8
        ldw $10,Vram_
        ldw $12,VVram_
        ldw $14,Backup
        ld $4,VVramHeight
        do
            ld $5,VVramWidth
            do
                ld $0,($12)
                ld $1,($14) | sbc $0,$1
                if nz
                    st $0,($14)
                    cal CharPtrIx
                    pre iz,$10
                    ld $1,8
                    do
                        ldi $0,(ix+$sx)
                                        ; ld $0,&haa
                        sti $0,(iz+$sx)
                        sb $1,$sy
                    while nz | wend
                endif
                ldw $16,8 | adw $10,$16
                adw $12,$sy
                adw $14,$sy
                sb $5,$sy
            while nz | wend
            ldw $16,VramRowSize-8*VVramWidth | adw $10,$16
            sb $4,$sy
        while nz | wend
    ppsm $10,8
    ppsm $0,6
rtn


; ptr<byte> VramPtr(byte x, byte y);
cseg
YTable:
    defw VramRowSize*0
    defw VramRowSize*1
    defw VramRowSize*2
    defw VramRowSize*3
VramPtr_: public VramPtr_
    phsw $13
        ld $10,$1
        biu $10 | ld $11,$sx
        ldw $12,YTable
        adw $10,$12
        pre ix,$10
        ldw $10,(ix+$sx)
        ld $12,$0
        biu $12 | biu $12
        ld $13,$sx
        adw $10,$12
        ldw $12,Vram_ | adw $10,$12
    ppsw $12
rtn


; ptr<byte> BackupPtr(byte x, byte y);
cseg
BackupPtr_: public BackupPtr_
    phsw $13
        ld $12,$0
        bid $12
        ld $10,$1
        biu $10 ;*2
        biu $10 ;*4
        biu $10 ;*8
        ad $10,$12
        ld $11,$sx
        ldw $12,Backup | adw $10,$12
    ppsw $12
rtn


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    phsm $7,8
        ld $2,1 | ld $3,1
        
        bid $0 ; x
        if c
            ad $2,$sy
        endif
        bid $1 ; y
        if c
            ad $3,$sy
        endif

        biu $1 ;*2
        biu $1 ;*4
        biu $1 ;*8
        ad $0,$1
        ld $1,$sx
        
        ldw $4,Backup | adw $0,$4
        ld $7,&hff
        do
            pre ix,$0
            ld $6,$2
            do
                sti $7,(ix+$sx)
                sb $6,$sy
            while nz | wend
            ldw $4,VVramWidth | adw $0,$4
            sb $3,$sy
        while nz | wend
    ppsm $0,8
rtn       


; void DrawSprite(byte x, byte y, byte pattern);

cseg
DrawSprite_: public DrawSprite_
    phsm $3,4
    phsm $13,4
        ld $10,$1 ;y
        an $10,&hfe
        ld $11,$sx
        ldw $12,YTable | adw $10,$12
        pre ix,$10
        ldw $10,(ix+$sx)
        ld $12,$0 ;x
        biu $12 | biu $12
        ld $13,$sx
        adw $10,$12
        ldw $12,Vram_ | adw $10,$12
        pre iz,$10

        anc $1,1
        if z
            ld $0,$2 ; pattern
            cal CharPtrIx
            ld $2,7
            do
                ld $3,(iz+$sx)
                an $3,&h01
                ldi $0,(ix+$sx)
                or $0,$3
                sti $0,(iz+$sx)
                sb $2,$sy
            while nz | wend
        else
            ld $0,$2 ; pattern
            cal CharPtrIx
            ld $2,7
            do
                ldi $1,(ix+$sx)
                ld $0,$sx
                bidw $1 | bidw $1 | bidw $1 | bidw $1
                
                ld $3,(iz+$sx)
                an $3,&hf0
                or $3,$1
                st $3,(iz+$sx)

                                    _deb: public _deb
                ld $3,(iz+VramRowSize)
                an $3,&h1f
                or $3,$0
                st $3,(iz+VramRowSize)
                ldi $1,(iz+$sx)

                sb $2,$sy
            while nz | wend
        endif
    ppsm $10,4
    ppsm $0,4
rtn
