include "Vram.inc"
include "VVram.inc"

ext CharPattern
ext VVram_

WRTP26 equ $FED4
LCDMOD equ $FF55

ext @Temp@Word
ext @Temp@Word2
ext @Temp@Word3
ext @Temp@Word4
ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Byte3
ext @Temp@Byte4
ext @Temp@Byte5

pVram equ @Temp@Word
pPattern equ @Temp@Word2
pVVram equ @Temp@Word3
patternWord equ @Temp@Word3
pBackup equ @Temp@Word4
xCount equ @Temp@Byte
yCount equ @Temp@Byte2
xPos equ @Temp@Byte3
yPos equ @Temp@Byte4

dseg
Vram_: public Vram_
    defs VramRowSize*VramHeight
Backup: public Backup
    defs VVramWidth*VVramHeight


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
        ldd #VVramWidth*VVramHeight
        do
            clr 0,x | inx
            subd #1
        while ne | wend
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


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
dseg
Put_@Param0: public Put_@Param0
Put_pVram:
    defw 0
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
cseg
Put:
    ldab #8 | mul
    addd #CharPattern
    std <pPattern
    ldab #8
    do
        ldx <pPattern
        ldaa 0,x | inx
        stx <pPattern
        ldx <pVram
        staa 0,x | inx
        stx <pVram
        decb
    while ne | wend
rts
Put_: public Put_
    psha | pshb
        ldx Put_pVram | stx <pVram
        ldaa Put_c
        bsr Put
    pulb | pula
    ldx <pVram
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    psha | pshb
        ldx #Vram_ | stx <pVram
        ldx #VVram_ | stx <pVVram
        ldx #Backup | stx <pBackup
        ldaa #VVramHeight | staa <yCount
        do
            ldaa #VVramWidth | staa <xCount
            do
                ldx <pVVram
                ldaa 0,x | inx
                stx <pVVram
                ldx <pBackup
                cmpa 0,x
                if ne
                    staa 0,x | inx
                    stx <pBackup
                    ldx <pVram
                    bsr Put
                    stx <pVram
                else
                    inx
                    stx <pBackup
                    ldx <pVram
                    ldab #8
                    abx
                    stx <pVram
                endif
                dec <xCount
            while ne | wend
            ldx <pVram
            xgdx
                addd #VramRowSize-VVramWidth*8
            xgdx
            stx <pVram

            dec <yCount
        while ne | wend
    pulb | pula
rts

cseg
AsciiPattern: public AsciiPattern
	; ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,1fh,11h,1fh,00h
	defb 00h,00h,1fh,00h,1dh,15h,17h,00h
	defb 15h,15h,1fh,00h,07h,04h,1fh,00h
	defb 17h,15h,1dh,00h,1fh,15h,1dh,00h
	defb 01h,1dh,03h,00h,1fh,15h,1fh,00h
	defb 17h,15h,1fh,00h,1eh,09h,1eh,00h
	defb 0eh,11h,0ah,00h,1fh,15h,11h,00h
	defb 1fh,05h,01h,00h,0eh,11h,0dh,00h
	defb 1fh,04h,1fh,00h,11h,1fh,11h,00h
	defb 1fh,04h,1bh,00h,1fh,06h,1fh,00h
	defb 1fh,01h,1eh,00h,0eh,11h,0eh,00h
	defb 1fh,05h,07h,00h,1fh,05h,1ah,00h
	defb 16h,15h,0dh,00h,01h,1fh,01h,00h
	defb 1fh,10h,1fh,00h,0fh,10h,0fh,00h
	defb 03h,1ch,03h,00h


; ptr<byte> VramPtr(byte x, byte y);
dseg
VramPtr_@Param1: public VramPtr_@Param1
VramPtr_y:
    defb 0
cseg
VramPtr_: public VramPtr_
    psha | pshb
        psha
            ldaa VramPtr_y
            ldab #VramRowSize | mul
            addd #Vram_
            xgdx
        pulb
        aslb | aslb
        abx
    pulb | pula
rts


; ptr<byte> BackupPtr(byte x, byte y);
dseg
BackupPtr_@Param1: public BackupPtr_@Param1
BackupPtr_y:
    defb 0
cseg
BackupPtr_: public BackupPtr_
    psha | pshb
        psha
            ldaa BackupPtr_y
            ldab #VVramWidth | mul
            addd #Backup
            xgdx
        pulb
        lsrb
        abx
    pulb | pula
rts


; void EraseBackup(byte x, byte y);
dseg
EraseBackup_@Param1: public EraseBackup_@Param1
EraseBackup_y:
    defb 0
cseg
EraseBackup_: public EraseBackup_
    psha | pshb
        tab
        ldaa #1 | staa <xCount | staa <yCount

        lsrb
        if cs
            inc <xCount
        endif
        stab <xPos
        
        ldaa EraseBackup_y
        lsra
        if cs
            inc <yCount
        endif

                                    _deb: public _deb
        ldab #VVramWidth | mul
        addd #Backup
        xgdx
        ldab <xPos
        abx
        stx <pBackup

        ldaa #$ff
        do
            ldx <pBackup
            ldab <xCount
            do
                staa 0,x | inx
                decb
            while ne | wend
            ldx <pBackup
            xgdx | addd #VVramWidth | xgdx
            stx <pBackup

            dec <yCount
        while ne | wend
    pulb | pula
rts


; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param1: public DrawSprite_@Param1
DrawSprite_y:
    defb 0
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
cseg
DrawSprite_: public DrawSprite_
    psha | pshb
        staa <xPos
        
        ldaa DrawSprite_pattern
        ldab #8 | mul
        addd #CharPattern
        std <pPattern

        ldaa DrawSprite_y | staa <yPos
        lsra
        ldab #VramRowSize | mul
        addd #Vram_
        xgdx
        ldab <xPos
        aslb | aslb
        abx
        stx <pVram

        ldaa <yPos
        anda #1
        if eq
            ldab #7
            do
                ldx <pPattern
                ldaa 0,x | inx
                stx <pPattern
                staa <patternWord

                ldx <pVram
                ldaa 0,x
                anda #$80
                oraa <patternWord
                staa 0,x | inx
                stx <pVram

                decb
            while ne | wend
        else
            ldab #7 | stab <xCount
            do
                ldx <pPattern
                ldab 0,x | inx
                stx <pPattern
                clra
                aslb | rola
                aslb | rola
                aslb | rola
                aslb | rola
                std <patternWord

                ldx <pVram
                
                ldaa 0,x
                anda #$0f
                oraa <patternWord+1
                staa 0,x
                
                ldaa VramRowSize,x
                anda #$f8
                oraa <patternWord
                staa VramRowSize,x
                
                inx
                stx <pVram

                dec <xCount
            while ne | wend
        endif
    pulb | pula
rts