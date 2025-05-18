include "Vram.inc"
include "SharedRam.inc"
include "Share.inc"
include "VVram.inc"
include "Chars.inc"

ext HaltSubsys, ResumeSubsys
ext MonoPattern, ColorPattern
ext VVramBack_, VVramFront_

VramTop equ Vram+VramRowSize*1

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


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 4 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
defb 16,7 ; Point
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
        ldb #Char_End-Char_Color
        bsr MakePatternColor
    puls u,cc
rts

MakePatternMono:
    std <CharColor
    orcc #$50
    do
        lda <CharColor | sta <colorBits
        lda #PlaneCount | sta <pCount
        do
            pshs y
                lda #CharHeight | sta <yCount
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
                    leay 1,y
                    dec <yCount
                while ne | wend
            puls y
            lsr <colorBits
            dec <pCount
        while ne | wend
        leay CharHeight,y
        dec <CharCount
    while ne | wend
    andcc #not $50
rts

MakePatternColor:
    stb <CharCount
    orcc #$50

    do
        lda #PatternSize/2
        sta <yCount
        do
            ldb ,y+
            lda #2
            sta <byteCount
            do
                lda #4
                sta <bitCount
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
            dec <yCount
        while ne | wend
        dec CharCount
    while ne | wend
    andcc #not $50
rts

SendPattern: public SendPattern
    ldx #PatternRam+PatternSize*Char_Subsys
    ldb #Char_Subsys
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
        cmpb #Char_End
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
        cmpb #Char_Subsys
        bcc Put_skip
        cmpb lastChar
        if ne
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
                if eq
                    lda ,y
                    cmpa #Char_Wall
                    if eq
                        clra
                        bsr SetWall_
                        clr ,y
                        bra VVramToVram_next
                    endif
                endif
                cmpb #Char_Wall
                if eq
                    lda ,y
                    if eq
                        lda #$ff
                        bsr SetWall_
                        ldb #Char_Wall
                        stb ,y
                        bra VVramToVram_next
                    endif
                endif
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


SetWall_:
    pshs x
        ldx <pVram
                            _deb: public _deb
        jsr HaltSubsys
        sta SharedRam+Share_Char
        stx SharedRam+Share_Address
        lda #SubCommand_SetWall
        sta SharedRam+Share_Command
        jsr ResumeSubsys
    puls x
rts
