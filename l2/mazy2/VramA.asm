include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_

ext @Temp@Word
ext @Temp@Word2
ext @Temp@Word3
ext @Temp@Word4
ext @Temp@Word5

ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Byte3
ext @Temp@Byte4
ext @Temp@Byte5

VramTop equ Vram+VramRowSize*2

pVram equ @Temp@Word
pChars equ @Temp@Word2
yCount equ @Temp@Byte
xCount equ @Temp@Byte2
pVram equ @Temp@Word3
pVVram equ @Temp@Word4


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    ldx #Vram
    do
        clr 0,x
        inx
        cpx #Vram+VramWidth*VramHeight
    while ne | wend

    ldx #VVramBack_
    do
        clr 0,x | inx
        cpx #VVramBack_+VVramWidth*VVramHeight
    while ne | wend
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    psha | pshb
        ldx #VVramFront_ | stx <pVVram
        ldx #VramTop | stx <pVram
        
        ldaa #VVramHeight
        staa <yCount
        do
            ldaa #VVramWidth
            staa <xCount
            do
                ldx <pVVram | ldaa 0,x
                inx | stx <pVVram
                ldx <pVram | staa 0,x
                inx | stx <pVram
                dec <xCount
            while ne | wend
            dec <yCount
        while ne | wend
    pulb | pula
rts


; ptr<byte> PrintC(ptr<byte> <pVram, byte c);
dseg
PrintC_@Param0: public PrintC_@Param0
Put_@Param0: public Put_@Param0
Put_pVram:
    defw 0
PrintC_@Param1: public PrintC_@Param1
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
cseg
PrintC_: public PrintC_
    psha
        ldx PrintC_@Param0
        ldaa PrintC_@Param1
        staa 0,x
        inx
    pula
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    psha
        ldx Put_pVram
        ldaa Put_c
        staa 0,x
        inx
    pula
rts
