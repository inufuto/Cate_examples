include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern

ColorPort equ $e890

dseg
CharColors: public CharColors
    defs Char_End
Backup:
    defs VVramWidth*VVramHeight

scope
cseg
ColorSource:
defb 32,7 ; Ascii
defb 15,6 ; Logo
defb 4,1 ; Wall
defb 4,2 ; Box
defb 4,6 ; Item
defb 64,5 ; Man
defb 32,7 ; Monster
defb 4,7 ; Ball
defb 16,7 ; Point
defb 4,4 ; Oneup
defb 0
pSource equ @Temp@Word
pDestination equ @Temp@Word2
InitVram: public InitVram
    ldx #ColorSource | stx pSource
    ldx #CharColors | stx pDestination
    do
        ldx pSource
        ldab 0,x
    while ne
        inx
        ldaa 0,x | inx
        stx pSource
        ldx pDestination
        do
            staa 0,x | inx
            decb
        while ne | wend
        stx pDestination
    wend
rts
endscope

; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    psha
        ldx #GraphVram
        do
            clr 0,x | inx
            cpx #GraphVram+VramWidth*VramHeight*CharHeight
        while ne | wend

        ldaa #7 | staa ColorPort
        ldx #TextVram
        do
            clr 0,x | inx
            cpx #TextVram+VramWidth*VramHeight
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


scope
pGraph equ @Temp@Word
pPattern equ @Temp@Word2
yCount equ @Temp@Byte
xCount equ @Temp@Byte2
pText equ @Temp@Word3
pVVram equ @Temp@Word4
pBackup equ @Temp@Word5

SetColor:
    ldx #CharColors
    staa SetColor_offset+1
    SetColor_offset:
    ldab 0,x
    stab ColorPort
rts

PutPattern: ;(pGraph, a)
    clrb
    asla | rolb ;*2
    asla | rolb ;*4
    asla | rolb ;*8
    adda #low MonoPattern | adcb #high MonoPattern
    staa pPattern+1 | stab pPattern
    clr Put_offset+1
    do
        ldx pPattern | ldab 0,x | inx | stx pPattern
        ldx pGraph
        Put_offset:
        stab 0,x
        ldab Put_offset+1 | addb #VramWidth | stab Put_offset+1
    while ne | wend
rts


; word Put(word vram, byte c);
dseg
Put_@Param0: public Put_@Param0
PrintC_@Param0: public PrintC_@Param0
Put_vram:
    defw 0
Put_@Param1: public Put_@Param1
PrintC_@Param1: public PrintC_@Param1
Put_c:
    defb 0
cseg
Put:
    psha
        bsr SetColor
        
        ldx Put_vram | stx pText
        inc pText
        ldx pText | clr 0,x

        ldx Put_vram | stx pGraph
        ldab pGraph+1 | andb #$e0 | stab pGraph+1
        asl pGraph+1 | rol pGraph
        asl pGraph+1 | rol pGraph
        asl pGraph+1 | rol pGraph
        ldab pText+1 | andb #$1f
        orab pGraph+1 | stab pGraph+1
        ldab pGraph | addb #9 stab pGraph
    pula
    bsr PutPattern

    ldx Put_vram
    inx
rts
Put_: public Put_
    psha | pshb
        ldaa Put_c
        bsr Put
    pulb | pula
rts

; word PrintC(word vram, byte c);
cseg
CharTable:
    defb " '-0123456789ACEFGHIKMNOPRSTUVYZ"
PrintC_: public PrintC_
    psha | pshb
        ldab Put_c
        clra
        ldx #CharTable
        do
            cmpb 0,x
            beq PrintC_break
            inca
            inx
            cpx #CharTable+32
        while ne | wend
        clra
        PrintC_break:
        bsr Put
    pulb | pula
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    psha | pshb
        ldx #VVramFront_ | stx pVVram
        ldx #Backup | stx pBackup
        ldx #GraphVram+VramWidth*2*CharHeight | stx pGraph
        ldx #TextVram+VramWidth*2 | stx pText

        ldaa #VVramHeight | staa <yCount
        do
            ldaa #VVramWidth
            staa <xCount
            do
                ldx pVVram | ldaa 0,x
                ldx pBackup | cmpa 0,x
                if ne
                    staa 0,x
                    bsr SetColor
                    ldx pText | clr 0,x
                    bsr PutPattern
                endif
                ldx pVVram | inx | stx pVVram
                ldx pBackup | inx | stx pBackup
                ldx pGraph | inx | stx pGraph
                ldx pText | inx | stx pText
                dec <xCount
            while ne | wend

            ldaa pGraph+1 | adda #low (VramWidth*CharHeight-VVramWidth) | staa pGraph+1
            ldaa pGraph | adca #high (VramWidth*CharHeight-VVramWidth) | staa pGraph

            ; ldaa pText+1 | adda #low (VramWidth-VVramWidth) | staa pText+1
            ; ldaa pText | adca #high (VramWidth-VVramWidth) | staa pText

            dec <yCount
        while ne | wend
    pulb | pula
rts
endscope