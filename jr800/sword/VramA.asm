include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

LcdPort equ $a00

dseg
Vram_: public Vram_
    defs VramRowSize*VramHeight
Backup:
    defs VVramWidth*VVramHeight


pVram equ @Temp@Word
pPort equ @Temp@Word2
pPattern equ @Temp@Word2
pVVram equ @Temp@Word3
pBackup equ @Temp@Word4

lcdX equ @Temp@Byte
VramByte equ @Temp@Byte
yCount equ @Temp@Byte2
xCount equ @Temp@Byte3

cseg
WaitLCD: ; (x)
    do
        tst 0,x
    while mi | wend
rts

; void ClearScreen();
ClearScreen_: public ClearScreen_
    psha | pshb
        ldx #LcdPort or $01
        do
            bsr WaitLCD
            ldaa #$3e | staa 0,x
            bsr WaitLCD
            ldaa #$3b | staa 0,x ; Up mode
            clrb
            do
                bsr WaitLCD
                stab 0,x ; Address
                ldaa #50
                do
                    psha
                        bsr WaitLCD
                        xgdx | inca | xgdx
                        ldaa #0 | staa 0,x
                        xgdx | deca | xgdx
                    pula
                    deca
                while ne | wend
                addb #$40
            while cc | wend
            xgdx | aslb | xgdx
        while ne | wend

        ldx #LcdPort or $01
        bsr WaitLCD
        ldaa #$3a | staa 0,x ; Down mode
        ldx #LcdPort or $02
        bsr WaitLCD
        ldaa #$3a | staa 0,x ; Down mode

        ldx #LcdPort or $10
        bsr WaitLCD
        ldaa #$3b | staa 0,x ; Up mode
        ldx #LcdPort or $20
        bsr WaitLCD
        ldaa #$3b | staa 0,x ; Up mode

        ldx #Vram_
        ldd #VramRowSize*VramHeight
        do
            clr 0,x | inx
            subd #1
        while ne | wend
        ldx #Backup
        ldd #VVramWidth*VVramHeight
        do
            clr 0,x | inx
            subd #1
        while ne | wend
        ldx #VVramBack_
        do
            clr 0,x | inx
            cpx #VVramBack_+VVramWidth*VVramHeight*2
        while ne | wend
    pulb | pula
rts


; void PresentVram();
cseg
WriteLcd:
    ldx <pPort
    oraa <lcdX
    bsr WaitLCD
    staa 0,x ; Address
    do
        ldx <pVram
        ldaa 0,x | inx
        stx <pVram
        ldx <pPort
        bsr WaitLCD
        xgdx | inca | xgdx
        staa 0,x
        xgdx | deca | xgdx
        decb
    while ne | wend
rts

PresentVram_: public PresentVram_
    psha | pshb
        ldx #Vram_ | stx <pVram

        ldx #LcdPort or $01 | stx <pPort
        clr <lcdX
        do
            ldd #(46-1 shl 8) or 46
            bsr WriteLcd
            asl <pPort+1
            ldd #(50-1 shl 8) or 50
            bsr WriteLcd
            lsr <pPort+1

            ldaa <lcdX
            adda #$40
            staa <lcdX
        while cc | wend

        ldx #LcdPort or $10 | stx <pPort
        clr <lcdX
        do
            ldd #(50-46 shl 8) or 46
            bsr WriteLcd
            asl <pPort+1
            ldd #(0 shl 8) or 50
            bsr WriteLcd
            lsr <pPort+1
            ldaa <lcdX
            adda #$40
            staa <lcdX
        while cc | wend
    pulb | pula
rts


; ptr<byte> PrintC(ptr<byte> <pVram, byte c);
dseg
    PrintC_@Param0: public PrintC_@Param0
    PrintC_pVram: defw 0
    PrintC_@Param1: public PrintC_@Param1
    PrintC_c: defb 0
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

        ldab #CharWidth
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


CharPatternBpp:
    clra
    asld ;*2
    addb #low CharPattern | stab <pPattern+1
    adca #high CharPattern | staa <pPattern
rts


; ptr<byte> PutU(ptr<byte> pVram, byte c);
dseg
PutU_@Param0: public PutU_@Param0
PutU_pVram:
    defw 0
PutU_@Param1: public PutU_@Param1
PutU_c:
    defb 0
cseg
PutU:
    bsr CharPatternBpp
    ldab #2
    do
        pshb
            ldx <pPattern
            ldaa 0,x | inx
            stx <pPattern
            ldx <pVram
            ldab 0,x | andb #$f0 | stab <VramByte
            tab
                anda #$0f
                oraa <VramByte
                ldx <pVram
                staa 0,x | inx
            tba
            lsra | lsra | lsra | lsra
            ldab 0,x | andb #$f0 | stab <VramByte
            anda #$0f
            oraa <VramByte
            staa 0,x | inx
            stx <pVram
        pulb
        decb
    while ne | wend
rts
PutU_: public PutU_
    psha | pshb
        ldx PutU_pVram | stx <pVram
        ldab PutU_c
        bsr PutU
    pulb | pula
rts


; ptr<byte> PutL(ptr<byte> pVram, byte c);
dseg
PutL_@Param0: public PutL_@Param0
PutL_pVram:
    defw 0
PutL_@Param1: public PutL_@Param1
PutL_c:
    defb 0
cseg
PutL:
    bsr CharPatternBpp
    ldab #2
    do
        pshb
            ldx <pPattern
            ldaa 0,x | inx
            stx <pPattern
            ldx <pVram
            ldab 0,x | andb #$0f | stab <VramByte
            tab
                asla | asla | asla | asla
                anda #$f0
                oraa <VramByte
                ldx <pVram
                staa 0,x | inx
            tba
            ldab 0,x | andb #$0f | stab <VramByte
            anda #$f0
            oraa <VramByte
            staa 0,x | inx
            stx <pVram
        pulb
        decb
    while ne | wend
rts
PutL_: public PutL_
    psha | pshb
        ldx PutL_pVram | stx <pVram
        ldab PutL_c
        bsr PutL
    pulb | pula
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    psha | pshb
        ldx #Vram_+VramRowSize | stx <pVram
        ldx #VVramFront_ | stx <pVVram
        ldx #Backup | stx <pBackup
        ldaa #VVramHeight/2 | staa <yCount
        do
            ldaa #VVramWidth | staa <xCount
            do
                ldx <pVVram
                ldaa 0,x
                inx
                stx <pVVram
                ldx <pBackup
                cmpa 0,x
                if ne
                    staa 0,x
                    inx
                    stx <pBackup
                    ldx <pVram
                    tab | bsr PutU
                else
                    inx
                    stx <pBackup
                    ldd <pVram
                    addd #CharWidth
                    std <pVram
                endif
                dec <xCount
            while ne | wend
            ldd <pVram
            addd #-VVramWidth*VramStep
            std <pVram
            ldaa #VVramWidth | staa <xCount
            do
                ldx <pVVram
                ldaa 0,x
                inx
                stx <pVVram
                ldx <pBackup
                cmpa 0,x
                if ne
                    staa 0,x
                    inx
                    stx <pBackup
                    ldx <pVram
                    tab | bsr PutL
                else
                    inx
                    stx <pBackup
                    ldd <pVram
                    addd #CharWidth
                    std <pVram
                endif
                dec <xCount
            while ne | wend

            dec <yCount
        while ne | wend
    pulb | pula
rts
