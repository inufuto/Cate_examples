include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext AsciiPattern, CharPattern

VramTop equ Vram+VramWidth*(6+2)
AsciiSize equ 6

dseg
Backup: defs VVramWidth*VVramHeight

ext @Temp@Word
ext @Temp@Word2
ext @Temp@Word3
ext @Temp@Word4
ext @Temp@Word5
ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Byte3
ext @Temp@Byte4

pVram equ @Temp@Word
pPattern equ @Temp@Word2
pVVram equ @Temp@Word3
pBackup equ @Temp@Word4
pFlags equ @Temp@Word5
yCount equ @Temp@Byte
xCount equ @Temp@Byte2
flags equ @Temp@Byte3
maskBit equ @Temp@Byte4


dseg
PrintC_@Param0: public PrintC_@Param0
PrintC_pVram: 
Put3_@Param0: public Put3_@Param0
Put3_pVram: 
Put2_@Param0: public Put2_@Param0
Put2_pVram: 
    defw 0
PrintC_@Param1: public PrintC_@Param1
PrintC_c: 
Put3_@Param1: public Put3_@Param1
Put3_c:
Put2_@Param1: public Put2_@Param1
Put2_c:
    defb 0

cseg
WaitBlank:
    do
        tim #$80,$02
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    psha
        ldx #Vram
        do
            clr 0,x | inx
            cpx #Vram+VramWidth*64
        while ne | wend
        
        ldx #Backup
        do
            clr 0,x | inx
            cpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        ldx #VVramBack_
        do
            clr 0,x | inx
            cpx #VVramBack_+VVramWidth*VVramHeight*2
        while ne | wend
    pula
rts


; ptr<byte> Put3(ptr<byte> pVram, byte c);
cseg
Put3:
    ldab #5
    mul
    addd #CharPattern
    std <pPattern

    ldab #3
    do
        pshb
            ldx <pPattern
            ldaa 0,x | inx
            stx <pPattern

            ldx <pVram | staa 0,x
            ldd <pVram | addd #VramWidth | std <pVram
        pulb
        decb
    while ne | wend
rts
Put3_: public Put3_
    psha | pshb
        ldx PrintC_pVram | stx <pVram
        ldaa Put3_c 
        bsr Put3
    pulb | pula
    ldx Put3_pVram | inx
rts


; ptr<byte> Put2(ptr<byte> pVram, byte c);
cseg
Put2:
    ldab #5
    mul
    addd #CharPattern+3
    std <pPattern

    ldab #2
    do
        pshb
            ldx <pPattern
            ldaa 0,x | inx
            stx <pPattern

            ldx <pVram | staa 0,x
            ldd <pVram | addd #VramWidth | std <pVram
        pulb
        decb
    while ne | wend
rts
Put2_: public Put2_
    psha | pshb
        ldx PrintC_pVram | stx <pVram
        ldaa Put2_c 
        bsr Put2
    pulb | pula
    ldx Put2_pVram | inx
rts


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
    defb " 0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    psha | pshb
        ldx PrintC_pVram | stx <pVram

        ldaa PrintC_c
        clrb
        ldx #CharTable
        do
            cmpa 0,x
            beq PrintC_break
            incb
            inx
            cpx #CharTable+28
        while ne | wend
        clrb
        PrintC_break:
        ldaa #AsciiSize
        mul
        addd #AsciiPattern
        std <pPattern

        ldab #AsciiSize
        do
            pshb
                ldx <pPattern
                ldaa 0,x | inx
                stx <pPattern

                ldx <pVram | staa 0,x
                ldd <pVram
                addd #VramWidth
                std <pVram
            pulb
            decb
        while ne | wend
    pulb | pula
    ldx PrintC_pVram | inx
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    psha | pshb
        ldx #VVramFront_ | stx <pVVram
        ldx #Backup | stx <pBackup
        ldx #VramTop | stx <pVram

        ldaa #VVramHeight/2 | staa <yCount
        do
            ldaa #VVramWidth
            staa <xCount
            do
                ldx <pVVram | ldaa 0,x
                ldx <pBackup | cmpa 0,x
                if ne
                    staa 0,x
                    bsr Put3
                    ldd <pVram | addd #-VramWidth*3+1 | std <pVram
                else
                    ldx <pVram | inx | stx <pVram
                endif

                ldx <pVVram | inx | stx <pVVram
                ldx <pBackup | inx | stx <pBackup
                
                dec <xCount
            while ne | wend

            ldd <pVram | addd #VramWidth*3-VVramWidth | std <pVram

            ldaa #VVramWidth
            staa <xCount
            do
                ldx <pVVram | ldaa 0,x
                ldx <pBackup | cmpa 0,x
                if ne
                    staa 0,x
                    bsr Put2
                    ldd <pVram | addd #-VramWidth*2+1 | std <pVram
                else
                    ldx <pVram | inx | stx <pVram
                endif

                ldx <pVVram | inx | stx <pVVram
                ldx <pBackup | inx | stx <pBackup

                dec <xCount
            while ne | wend

            ldd <pVram | addd #VramWidth*2-VVramWidth | std <pVram

            dec <yCount
        while ne | wend
    pulb | pula
rts
