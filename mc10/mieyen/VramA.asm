include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext AsciiPattern, CharPattern

ext @Temp@Word
ext @Temp@Word2
ext @Temp@Word3
ext @Temp@Word4
ext @Temp@Word5
ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Byte4
ext @Temp@Byte5

pVram equ @Temp@Word
pChars equ @Temp@Word2
pVVram equ @Temp@Word3
pBackup equ @Temp@Word4
yCount equ @Temp@Byte
xCount equ @Temp@Byte2

dseg
Backup:
    defs VVramWidth*VVramHeight


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    psha
        ldx #Vram
        do
            clr 0,x | inx
            cpx #Vram+VramRowSize*VramHeight
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


cseg
Put1:
    tab | clra
    asld | asld
    addd #CharPattern
    std <pChars
    
    ldab #CharHeight
    do
        ldx <pChars | ldaa 0,x | inx | stx <pChars
        ldx <pVram
        staa 0,x
        ldaa <pVram+1 | adda #VramWidth | staa <pVram+1
        decb
    while ne | wend
    ldaa <pVram+1 | adda #1-VramRowSize | staa <pVram+1
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
dseg
    Put_@Param0: public Put_@Param0
    Put_pVram: defw 0
    Put_@Param1: public Put_@Param1
    Put_c: defb 0
cseg
Put_: public Put_
    psha | pshb
        ldaa Put_c
        ldx Put_pVram | stx <pVram
        bsr Put1
    pulb | pula
    ldx <pVram
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    psha | pshb
        ldx #VVramFront_ | stx <pVVram
        ldx #Backup | stx <pBackup
        ldx #Vram+VramRowSize*StageTop | stx <pVram
        ldaa #VVramHeight
        staa <yCount
        do
            ldaa #VVramWidth
            staa <xCount
            do
                ldx <pVVram | ldaa 0,x
                ldx <pBackup | cmpa 0,x
                if ne
                    staa 0,x
                    bsr Put1
                else
                    ldx <pVram | inx | stx <pVram
                endif
                ldx <pVVram | inx | stx <pVVram
                ldx <pBackup | inx | stx <pBackup
                dec <xCount
            while ne | wend
            ldd <pVram | addd #(VramRowSize-VVramWidth) | std <pVram
            dec <yCount
        while ne | wend
    pulb | pula
rts


; ptr<byte> PrintC(ptr<byte> <pVram, byte c);
dseg
PrintC_@Param0: public PrintC_@Param0
PrintC_pVram: 
    defw 0
PrintC_@Param1: public PrintC_@Param1
PrintC_c: 
    defb 0
cseg
CharTable:
    defb " 0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    psha | pshb
        ldx #CharTable
        ldaa PrintC_c
        clrb
        do
            cmpa 0,x
            beq PrintC_break
            inx
            incb
            cmpb #29
        while ne | wend
        clrb
        PrintC_break:
        clra
        asld | asld | asld
        addd #AsciiPattern | std <pChars

        ldx PrintC_pVram | stx <pVram
        ldab #CharHeight*2
        do
            ldx <pChars | ldaa 0,x | inx | stx <pChars
            ldx <pVram
            staa 0,x
            ldaa <pVram+1 | adda #VramWidth | staa <pVram+1
            decb
        while ne | wend
        ldaa <pVram+1 | adda #1-VramRowSize*2 | staa <pVram+1
    pulb | pula
    ldx <pVram
rts
