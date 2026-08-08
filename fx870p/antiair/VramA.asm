include "Vram.inc"
include "VVram.inc"

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
        ldim $4,(ix+$sx),8
        stlm $4,8
        sb $3,$sy
    while nz | wend
    xr $0,&h10
rtn
PresentVram_: public PresentVram_
    phsm $7,8
    phsm $11,4
        pre ix,Vram_
        ld $0,&h82
        ld $1,$sx
        ld $2,$sx
        do
            ld $3,BlockWidth/8
            cal SendBytes
            ld $3,VramRowSize/8-BlockWidth/8
            cal SendBytes
            ad $2,$sy
            an $2,3
        while nz | wend
    ppsm $8,4
    ppsm $0,8
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
Put:
    ld $0,$1 | an $0,&hc0 ; left
    biu $1 | biu $1 | an $1,&hc0 ; right
    ld $3,&hc0 ; mask
    an $2,7
    do
    while nz
        bid $0
        bid $1
        bid $3
        sb $2,$sy
    wend
    inv $3
    
    ld $2,(iz+$sx)
    an $2,$3
    or $2,$0
    sti $2,(iz+$sx)

    ld $2,(iz+$sx)
    an $2,$3
    or $2,$1
    sti $2,(iz+$sx)
rtn
Put_: public Put_
    phsm $3,4
        pre iz,$10
        cal Put
        gre iz,$10
    ppsm $0,4
rtn


; void VVramToVram();
VVramToVram_: public VVramToVram_
    phsm $6,7
    phsm $17,8
        ldw $10,Vram_
        ldw $12,VVram_
        ldw $14,Backup
        ldw $16,VramRowSize
        ld $6,$sx ; shift
        ld $4,VVramHeight
        do
            pre iz,$10
            ld $5,VVramWidth
            do
                ld $1,($12)
                ld $2,($14) | sbc $1,$2
                if nz
                    st $1,($14)
                    ld $2,$6
                    cal Put
                else
                    ldi $1,(iz+$sx)
                    ldi $1,(iz+$sx)
                endif
                adw $12,$sy
                adw $14,$sy
                sb $5,$sy
            while nz | wend
            ad $6,2
            an $6,7
            if z
                adw $10,$16
            endif
            sb $4,$sy
        while nz | wend
    ppsm $10,8
    ppsm $0,7
rtn


cseg
AsciiPattern: public AsciiPattern
	; ascii 30
	; " 0123456789=ACEFGHIKMNOPRSTUVY"
	defb &h00,&h00,&h00,&h00,&hf8,&h88,&hf8,&h00
	defb &h00,&h00,&hf8,&h00,&hb8,&ha8,&he8,&h00
	defb &ha8,&ha8,&hf8,&h00,&he0,&h20,&hf8,&h00
	defb &he8,&ha8,&hb8,&h00,&hf8,&ha8,&hb8,&h00
	defb &h80,&hb8,&hc0,&h00,&hf8,&ha8,&hf8,&h00
	defb &he8,&ha8,&hf8,&h00,&h50,&h50,&h50,&h00
	defb &h78,&h90,&h78,&h00,&h70,&h88,&h50,&h00
	defb &hf8,&ha8,&h88,&h00,&hf8,&ha0,&h80,&h00
	defb &h70,&h88,&hb0,&h00,&hf8,&h20,&hf8,&h00
	defb &h88,&hf8,&h88,&h00,&hf8,&h20,&hd8,&h00
	defb &hf8,&h60,&hf8,&h00,&hf8,&h80,&h78,&h00
	defb &h70,&h88,&h70,&h00,&hf8,&ha0,&he0,&h00
	defb &hf8,&ha0,&h58,&h00,&h68,&ha8,&hb0,&h00
	defb &h80,&hf8,&h80,&h00,&hf8,&h08,&hf8,&h00
	defb &hf0,&h08,&hf0,&h00,&hc0,&h38,&hc0,&h00


; void DrawFence();
cseg
DrawFence_: public DrawFence_
    phsw $1
    phsm $13,4
        ldw $10,Vram_+VVramWidth*2
        ldw $12,VramRowSize
        ldw $0,&h0455
        do
            st $0,($10)
            adw $10,$12
            sb $1,$sy
        while nz | wend
        ld $0,&h50
        st $0,($10)

        ; ldw $10,Vram_+VramRowSize*3
        ; ldw $12,2
        ; ldw $0,&h08 or (VVramWidth shl 8)
        ; do
        ;     st $0,($10)
        ;     adw $10,$12
        ;     sb $1,$sy
        ; while nz | wend
    ppsm $10,4
    ppsw $0
rtn
