include "Vram.inc"
include "SharedRam.inc"
include "Share.inc"
include "VVram.inc"
include "Chars.inc"

ext HaltSubsys, ResumeSubsys
ext MonoPattern, ColorPattern
ext VVramBack_, VVramFront_

VramTop equ Vram+VramRowSize*2

dseg
Backup:
    defs VVramWidth*VVramHeight
PatternRam: public PatternRam
    defs PatternSize*Char_End


zseg
CharColor:
    defb 0
CharCount:
    defb 0
pCount:
    defb 0    
yCount:
    defb 0
xCount:
byteCount:
    defb 0
flagByte:
bitCount:
    defb 0
colorBits:
    defb 0
maskByte:
invertedByte:
    defb 0
pVram:
    defw 0


scope
zseg
charColor:
    defb 0
wCount:
    defw 0
byteCount:
    defb 0
bitCount:
    defb 0
colorBits:
    defb 0
invertedByte:
    defb 0
plCount:
    defb 0    
cseg
ColorTable:
defb 31, 7 ; Ascii
defb 15, 6 ; Logo
defb 2, 1 ; Fence
defb 4, 1 ; Wall
defb 0
InitVram: public InitVram
    pshs u,cc | orcc #$50
        ldy #MonoPattern
        ldx #PatternRam
        ldu #ColorTable
        do
            ldb 0,u
        while ne
            leau 1,u
            lda 0,u
            leau 1,u
            bsr MakePatternMono
        wend
        
        ldy #ColorPattern
        ldx #PatternRam+PatternSize*Char_Color
        ldd #PatternSize*(Char_End-Char_Color)
        bsr MakePatternColor
    puls u,cc
rts

MakePatternMono:
    sta <charColor
    lda #CharHeight | mul
    std <wCount
    do
        lda <charColor | sta <colorBits
        lda #PlaneCount | sta <plCount
        do
            clrb
            lda colorBits
            bita #$01
            if ne
                orb ,y
            endif
            bita #$10
            if ne
                lda ,y
                coma
                sta <invertedByte
                orb <invertedByte
            endif
            bsr Double

            lsr <colorBits
            dec <plCount
        while ne | wend
        leay 1,y
        
        ldd wCount
        subd #1
        std wCount
    while ne | wend
rts

Double:
    lda #VramStep | sta <byteCount
    do
        lda #8/VramStep | sta <bitCount
        clra
        do
            lsla
            lsla
            lslb
            if cs
                ora #$03
            endif
            dec <bitCount
        while ne | wend
        sta ,x+
        dec <byteCount
    while ne | wend
rts

MakePatternColor:
    std <wCount
    do
        ldb ,y+
        bsr Double

        ldd wCount
        subd #1
        std wCount
    while ne | wend
rts
endscope


SendPattern: public SendPattern
    ldx #PatternRam+PatternSize*Char_SubsysTop
    ldb #Char_SubsysTop
    do
        pshs b
            jsr HaltSubsys
            lda #SubCommand_DefChar
            sta SharedRam+Share_Command
            stb SharedRam+Share_Char
            ldy #SharedRam+Share_Pattern
            ldb #PatternSize
            do
                lda ,x+
                sta ,y+
                decb
            while ne | wend
            jsr ResumeSubsys
            clrb
            do
                decb
            while ne | wend
        puls b
        incb
        cmpb #Char_SubsysTail
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs x,b,a
        jsr HaltSubsys
        lda #SubCommand_Clear
        sta SharedRam+Share_Command
        jsr ResumeSubsys
        clr lastChar

        ldx #Backup
        ldd #VVramWidth*VVramHeight
        do
            clr ,x+
            subd #1
        while ne | wend

        ldx #VVramBack_
        ldd #VVramWidth*VVramHeight*2
        do
            clr ,x+
            subd #1
        while ne | wend
    puls x,b,a
rts


; word Put(word vram, byte c);
dseg
    lastChar: defb 0
cseg
Put_: public Put_
    pshs a,b,x,y
        jsr HaltSubsys
        lda #SubCommand_Put | sta SharedRam+Share_Command
        stb SharedRam+Share_Char
        stx SharedRam+Share_Address
        tstb
        beq Put_skip
        cmpb #Char_SubsysTop
        bcs Put_viaSharedRam
        cmpb #Char_SubsysTail
        bcs Put_skip
        cmpb lastChar
        if ne
            Put_viaSharedRam:
            stb lastChar
            pshs cc | orcc #$40
                lda #PatternSize
                mul
                addd #PatternRam
                tfr d,x
                pshs cc | orcc #$40
                    ldy #SharedRam+Share_Pattern
                    ldb #PatternSize
                    do
                        lda ,x+
                        sta ,y+
                        decb
                    while ne | wend
                puls cc
            puls cc
        endif
        Put_skip:
        jsr ResumeSubsys
    puls a,b,x,y
    tfr x,d
    addd #2
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    pshs y
        ldy #CharTable
        clra
        do
            cmpb ,y+
            beq PrintC_break
            inca
            cmpa #31
        while cs | wend
        clra
        PrintC_break:
        tfr a,b
        bsr Put_
    puls y
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop
        stx <pVram
        ldx #VVramFront_
        ldy #Backup
        lda #VVramHeight
        sta <yCount
        do
            lda #VVramWidth
            sta <xCount
            do 
                ldb ,x+
                cmpb ,y
                if ne
                    stb ,y
                    pshs x
                        ldx <pVram
                        bsr Put_
                    puls x
                endif
                VVramToVram_next:
                leay 1,y
                pshs x
                    ldx <pVram
                    leax 2,x
                    stx <pVram
                puls x
                dec <xCount
            while ne | wend
            pshs x
                ldx <pVram
                leax VramRowSize-VVramWidth*2,x
                stx <pVram
            puls x
            dec <yCount
        while ne | wend
    puls a,b,x,y
rts
