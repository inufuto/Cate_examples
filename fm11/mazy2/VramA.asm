include "Share.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern
ext HaltSubsys, ResumeSubsys

VramTop equ Vram+VramRowSize*1

dseg
Backup:
    defs VVramWidth*VVramHeight

zseg
CharColor:
    defb 0
CharCount:
    defb 0
CharCode:
    defb 0
plCount:
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
pFlags:
    defw 0


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
defb 16,7 ; Point
defb 0
InitVram: public InitVram
    clr <CharCode

    ldy #MonoPattern
    ldx #ColorTable
    do
        ldb 0,x
    while ne
        leax 1,x
        lda 0,x
        leax 1,x
        pshs x
            bsr MakePatternMono
        puls x
    wend

    ldy #ColorPattern
    ldb #Char_End-Char_Color
    bsr MakePatternColor
rts

Wait:
    ldb #100
    do
        decb
    while ne | wend
rts

MakePatternMono:
    std <CharColor
    do
        jsr HaltSubsys
            lda <CharCode | sta ShareRam+Share_Char
            ldx #ShareRam+Share_Pattern
            lda <CharColor | sta <colorBits
            lda #PlaneCount | sta <plCount
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
                dec <plCount
            while ne | wend
            lda #SubCommand_DefChar | sta ShareRam+Share_Command
        jsr ResumeSubsys
        bsr Wait

        leay CharHeight,y
        inc <CharCode
        dec <CharCount
    while ne | wend
rts

MakePatternColor:
    stb <CharCount
    do
        jsr HaltSubsys
            lda <CharCode | sta ShareRam+Share_Char
            ldx #ShareRam+Share_Pattern
            lda #CharHeight*PlaneCount | sta <yCount
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
            lda #SubCommand_DefChar | sta ShareRam+Share_Command
        jsr ResumeSubsys
        bsr Wait

        inc <CharCode
        dec CharCount
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs x,b,a
        jsr HaltSubsys
        lda #SubCommand_Clear
        sta ShareRam+Share_Command
        jsr ResumeSubsys

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
cseg
Put_: public Put_
    pshs a,b,x,y
        jsr HaltSubsys
            lda #SubCommand_Put | sta ShareRam+Share_Command
            stx ShareRam+Share_Address
            stb ShareRam+Share_Char
        jsr ResumeSubsys
    puls a,b,x,y
    tfr x,d
    addd #VramStep
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
        jsr HaltSubsys
            sta ShareRam+Share_Char
            stx ShareRam+Share_Address
            lda #SubCommand_SetWall
            sta ShareRam+Share_Command
        jsr ResumeSubsys
    puls x
rts
