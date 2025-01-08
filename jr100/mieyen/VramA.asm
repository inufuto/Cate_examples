include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CharPattern
ext PollTimer_

ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Word
ext @Temp@Word2
ext @Temp@Word3
ext @Temp@Byte3

Top equ Vram+VramWidth*StageTop

pVram equ @Temp@Word
pVVram equ @Temp@Word2
pSource equ @Temp@Word
pDestination equ @Temp@Word2
yCount equ @Temp@Byte


cseg
InitVram: public InitVram
    ldx #CharPattern+CharHeight*Pattern_FireBullet | stx <pSource
    ldx #CharGen+CharHeight*(Char_FireBullet-$80) | stx <pDestination
    ldab #Char_End-Char_FireBullet
    bsr CopyBytes
rts

CopyBytes:
    aslb ;*2
    aslb ;*4
    aslb ;*8
    do
        ldx <pSource
        ldaa 0,x | inx
        stx <pSource

        ldx <pDestination
        staa 0,x | inx
        stx <pDestination

        decb
    while ne | wend
rts


; void SetPattern(byte c, byte pattern, byte count);
pSource equ @Temp@Word
pDestination equ @Temp@Word2
dseg
SetPattern_@Param1: public SetPattern_@Param1
SetPattern_pattern:
    defb 0
SetPattern_@Param2: public SetPattern_@Param2
SetPattern_count:
    defb 0
cseg
SetPattern_: public SetPattern_
    psha | pshb
        suba #$80
        clrb
        asla | rolb ;*2
        asla | rolb ;*4
        asla | rolb ;*8
        addb #high CharGen
        staa <pDestination+1 | stab <pDestination

        ldaa SetPattern_pattern
        clrb
        asla | rolb ;*2
        asla | rolb ;*4
        asla | rolb ;*8
        adda #low CharPattern | adcb #high CharPattern
        staa <pSource+1 | stab <pSource

        ldab SetPattern_count
        bsr CopyBytes
    pulb | pula
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    psha
        ldx #Vram
        do
            clr 0,x | inx
            cpx #Vram+VramRowSize*VramHeight
        while ne | wend

        clra
        ldx #VVram_
        do
            staa 0,x | inx
            cpx #VVram_+VVramWidth*VVramHeight*2
        while ne | wend
    pula
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
Put_@Param0: public Put_@Param0
Put_pVram:
    defw 0
Put_@Param1: public Put_@Param1
Put_c:
    defw 1
cseg
Put_: public Put_
    psha
        ldx Put_pVram
        ldaa Put_c
        staa 0,x
        inx
    pula
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
dseg
PrintC_@Param0: public PrintC_@Param0
PrintC_pVram:
    defw 0
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
    defw 1
cseg
PrintC_: public PrintC_
    psha
        ldx PrintC_pVram
        ldaa PrintC_c
        suba #$20
        staa 0,x
        inx
    pula
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    psha | pshb
        ldx #Top
        stx <pVram  
        ldx #VVram_
        stx <pVVram 
        ldaa #VVramHeight
        staa <yCount
        do
            jsr PollTimer_
            ldab #VVramWidth
            do
                ldx <pVVram 
                ldaa 0,x
                inx
                stx <pVVram 

                ldx <pVram  
                staa 0,x
                inx
                stx <pVram  

                decb
            while ne | wend
            dec yCount
        while ne | wend
    pulb | pula
rts
