include "Share.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern, SpritePattern
ext HaltSubsys, ResumeSubsys

VramTop equ Vram+VramRowSize*2

dseg
Backup:
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
pBackup:
	defw 0

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
defb 31, 7 ; Ascii
defb 15, 6 ; Logo
defb 2, 1 ; Fence
defb 4, 1 ; Wall
defb 0
InitVram: public InitVram
    clr CharCode

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

    bsr MakeSpritePattern
rts

Wait:
    ldb #100
    do
        decb
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

MakePatternMono:
    std <CharColor
    do
        jsr HaltSubsys
            lda CharCode | sta ShareRam+Share_Char
            ldx #ShareRam+Share_Pattern
            lda #CharHeight | sta <yCount
            do
                lda <CharColor | sta <colorBits
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
                dec <yCount
            while ne | wend
            lda #SubCommand_DefChar | sta ShareRam+Share_Command
        jsr ResumeSubsys
        bsr Wait

        inc CharCode
        dec <CharCount
    while ne | wend
rts

MakePatternColor:
    stb <CharCount
    do
        jsr HaltSubsys
            lda CharCode | sta ShareRam+Share_Char
            ldx #ShareRam+Share_Pattern
            lda #CharHeight*PlaneCount | sta <yCount
            do
                ldb ,y+
                bsr Double
                dec <yCount
            while ne | wend
            lda #SubCommand_DefChar | sta ShareRam+Share_Command
        jsr ResumeSubsys
        bsr Wait

        inc CharCode
        dec CharCount
    while ne | wend
rts

MakeSpritePattern:
    ldy #SpritePattern
    clr <CharCode
    lda #Pattern_End*4 | sta <CharCount
    do
        jsr HaltSubsys
            lda CharCode | sta ShareRam+Share_Char
            ldx #ShareRam+Share_Pattern
            lda #CharHeight*(1+PlaneCount) | sta <yCount
            do
                ldb ,y+
                bsr Double
                dec <yCount
            while ne | wend
            lda #SubCommand_DefSprite | sta ShareRam+Share_Command
        jsr ResumeSubsys
        bsr Wait

        inc CharCode
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
        ldd #VVramWidth*VVramHeight*2
        do
            clr ,x+
            subd #1
        while ne | wend

        ; ldx #VVram_
        ; ldd #VVramWidth*VVramHeight*2
        ; do
        ;     clr ,x+
        ;     subd #1
        ; while ne | wend

        ldd #Backup1 | std pBackup
    puls x,b,a
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y
        jsr HaltSubsys
            lda #SubCommand_DrawChar2 | sta ShareRam+Share_Command
            stx ShareRam+Share_Address
            stb ShareRam+Share_Char
        jsr ResumeSubsys
        bsr Wait
    puls a,b,x,y
    tfr x,d
    addd #VramStep
rts

; ptr<byte> PrintC(word vram, byte c);
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
        stx pVram
        ldx #VVram_
        ldy pBackup
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
                    jsr HaltSubsys
                        stb ShareRam+Share_Char
                        lda #SubCommand_DrawChar1 | sta ShareRam+Share_Command
                        ldd pVram | std ShareRam+Share_Address
                    jsr ResumeSubsys
                    bsr Wait
                endif
                leay 1,y
                ldd pVram | addd #2 | std pVram
                dec <xCount
            while ne | wend
            ldd pVram | addd #VramRowSize-VVramWidth*2 | std pVram
            dec <yCount
        while ne | wend
    puls a,b,x,y
rts


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    pshs a,b
        jsr HaltSubsys
            lda #SubCommand_SwitchPage | sta ShareRam+Share_Command
        jsr ResumeSubsys
        bsr Wait

        ldd pBackup
        cmpd #Backup0
        if eq
            ldd #Backup1
        else
            ldd #Backup0
        endif
        std pBackup
    puls a,b
rts


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    pshs a,b,x
        pshs a
            lda #2
            sta xCount
            sta yCount
        puls a
        asra
        if cs
            inc xCount
        endif
        asrb
        if cs
            inc yCount
        endif
        pshs a
            lda #VVramWidth
            mul
            addd #Backup0
            tfr d,x
        puls a
        leax a,x
        lda #$ff
        do
            pshs x
                ldb xCount
                do
                    sta Backup1-Backup0,x
                    sta ,x+
                    decb
                while ne | wend
            puls x
            leax VVramWidth,x
            dec yCount
        while ne | wend
    puls a,b,x
rts


; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
cseg
DrawSprite_: public DrawSprite_
    pshs a,b,x
        pshs a
            lda #VramWidth*2 | mul
            lslb | rola
            tfr d,x
        puls a
        leax a,x
        leax VramTop,x
        jsr HaltSubsys
            stx ShareRam+Share_Address
            lda DrawSprite_pattern | sta ShareRam+Share_Char
            lda #SubCommand_DrawSprite | sta ShareRam+Share_Command
        jsr ResumeSubsys
        bsr Wait
    puls a,b,x
rts
