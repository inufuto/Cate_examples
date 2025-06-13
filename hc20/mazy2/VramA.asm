include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

WRTP26 equ $FED4
LCDMOD equ $FF55

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

pVram equ @Temp@Word
pVVram equ @Temp@Word2
pBackup equ @Temp@Word3
pPattern equ @Temp@Word4

xCount equ @Temp@Byte
yCount equ @Temp@Byte2
shiftCount equ @Temp@Byte3

zseg
maskWord:
    defw 0
sourceWord:
    defw 0

dseg
Vram_: public Vram_
    defs VramRowSize*VramHeight
Backup:
    defs VVramWidth*VVramHeight
TopRow_: public TopRow_
    defb 0

; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    psha | pshb
        ldx #Vram_
        do
            clr 0,x | inx
            cpx #Vram_+VramRowSize*VramHeight
        while ne | wend
        
        ldx #Backup
        do
            clr 0,x | inx
            cpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        ldx #VVramBack_
        do
            clr 0,x | inx
            cpx #VVramBack_+VVramWidth*VVramHeight
        while ne | wend

        clr TopRow_
    pulb | pula
jmp PresentVram_


; void PresentVram();
cseg
WriteLcd:
    orab #$08
    ldaa #$0f
    jsr WRTP26

    ldaa #$64 | jsr LCDMOD
    tba | anda #$40 | oraa #$80 | jsr LCDMOD

    ldd #$0800 | jsr WRTP26
    ldab #40
    do
        ldaa 0,x | inx
        jsr LCDMOD
        decb
    while ne | wend
rts
PresentVram_: public PresentVram_
    psha | pshb
        ldx #Vram_
        ldab #$01 | bsr WriteLcd
        ldab #$02 | bsr WriteLcd
        ldab #$03 | bsr WriteLcd
        ldab #$01 or $40 | bsr WriteLcd
        ldab #$02 or $40| bsr WriteLcd
        ldab #$03 or $40| bsr WriteLcd
        ldab #$04 | bsr WriteLcd
        ldab #$05 | bsr WriteLcd
        ldab #$06 | bsr WriteLcd
        ldab #$04 or $40 | bsr WriteLcd
        ldab #$05 or $40| bsr WriteLcd
        ldab #$06 or $40| bsr WriteLcd
    pulb | pula
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
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
        ldx PrintC_pVram | stx <pVram

        ldaa PrintC_c
        clrb
        ldx #CharTable
        do
            cmpa 0,x
            beq PrintC_break
            incb
            inx
            cpx #CharTable+29
        while ne | wend
        clrb
        PrintC_break:
        aslb | aslb
        ldx #AsciiPattern
        abx | stx <pPattern
        ldab #AsciiWidth
        do
            ldx <pPattern
            ldaa 0,x | inx
            stx <pPattern
            ldx <pVram
            staa 0,x | inx
            stx <pVram
            decb
        while ne | wend
    pulb | pula
    ldx <pVram
rts


; ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
cseg
dseg
Put_@Param0: public Put_@Param0
Put_pVram:
    defw 0
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
Put_@Param2: public Put_@Param2
Put_shift:
    defb 0
cseg
Put_: public Put_
    psha | pshb
        ldx Put_pVram | stx <pVram
        bsr MakeMask
        ldab Put_c
        bsr Put
        ldx <pVram
    pulb | pula
rts
MakeMask: ;(a)
    ldab #$07
    ldaa Put_shift
    if ne
        staa <shiftCount
        clra
        do
            asld
            dec <shiftCount
        while ne | wend
    endif
    std <maskWord
rts
Put: ;(b)
    clra
    asld
    addd #CharPattern
    std <pPattern

    ldx <pPattern
    ldab 0,x
    andb #$0f
    bsr WriteByte
    ldx <pPattern
    ldab 0,x
    lsrb | lsrb | lsrb | lsrb
    bsr WriteByte
    ldx <pPattern
    ldab 1,x
    bsr WriteByte
rts
WriteByte:
    ldaa Put_shift
    if ne
        staa <shiftCount
        clra
        do
            asld
            dec <shiftCount
        while ne | wend
    endif
    std <sourceWord

    ldx <pVram
    ldaa <maskWord+1
    if ne
        coma
        anda 0,x
        oraa <sourceWord+1
        staa 0,x
    endif
    ldaa <maskWord
    if ne
        coma
        anda VramRowSize,x
        oraa <sourceWord
        staa VramRowSize,x
    endif
    ldx <pVram
    inx
    stx <pVram
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    psha | pshb
        ldx #Vram_ | stx <pVram
        ldx #Backup | stx <pBackup

        ldaa TopRow_
        ldab #VVramWidth | mul
        addd #VVramFront_+VVramWidth+1
        std <pVVram

        clr Put_shift
        bsr MakeMask

        ldaa #WindowHeight | staa <yCount
        do
            ldaa #WindowWidth | staa <xCount
            do
                ldx <pVVram
                ldab 0,x | inx
                stx <pVVram
                ldx <pBackup
                cmpb 0,x
                if ne
                    stab 0,x | inx
                    stx <pBackup
                    bsr Put
                else
                    inx
                    stx <pBackup
                    ldx <pVram
                    inx | inx | inx
                    stx <pVram
                endif
                dec <xCount
            while ne | wend              
            ldx <pVVram
            inx | inx
            stx <pVVram
            
            ldd <pVram
            subd #WindowWidth*3
            std <pVram

            ldd <maskWord
            asld | asld | asld
            std <maskWord

            ldaa Put_shift
            adda #3
            staa Put_shift
            suba #8
            if cc
                staa Put_shift

                ldd <pVram
                addd #VramRowSize
                std <pVram

                bsr MakeMask
            endif

            dec <yCount
        while ne | wend
    pulb | pula
rts
