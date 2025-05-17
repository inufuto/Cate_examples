include "BIOS.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"
include "SubBin.inc"
include "Share.inc"

ext  @Temp@Word

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern
ext SendSubsys, HaltSubsys, ResuumeSubsys, WaitSubsys, WriteSharedRam

SharedRam equ $FC80
Bank equ $fd0f

Vram equ $0000

VramTop equ Vram+VramRowSize*0

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
byteCount:
    defb 0
bitCount:
    defb 0
colorBits:
    defb 0
invertedByte:
    defb 0
; yCount:
;     defb 0
xCount:
    defb 0
wVram:
    defw 0


cseg
SubMain_Command:
    defb 0,0
    defb SUB.TEST
    defb 'YAMAUCHI'
    defb $93
    defw SubMain
    defb $90
StartSubMain: public StartSubMain
    pshs x,b,a
        ldx #SubMain_Command
        ldb #StartSubMain-SubMain_Command
        jsr SendSubsys
    puls x,b,a
rts


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
    sta Bank
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
    lda Bank
    andcc #not $50
rts

MakePatternColor:
    stb <CharCount
    orcc #$50
    sta Bank

    do
        lda #CharHeight*PlaneCount
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
        dec <CharCount
    while ne | wend
    lda Bank
    andcc #not $50
rts


Halt:
    pshs a
        HaltLoop:
        do
            lda $FD05
        while mi | wend
        orcc #$50
        lda #$80
        sta $FD05
        tst SharedRam
        if ne
            clr $FD05
            andcc #not $50
            bra HaltLoop
        endif
    puls a
rts

Resume:
    clr $FD05
    andcc #not $50
rts

SendPattern: public SendPattern
    ldx #PatternRam+PatternSize*Char_Subsys
    ldb #Char_Subsys
    do
        pshs b
            jsr Halt
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
            jsr Resume
        puls b
        incb
        cmpb #Char_End
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs x,b,a
        jsr Halt
        lda #SubCommand_Clear
        sta SharedRam+Share_Command
        jsr Resume
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
        jsr Halt
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
            pshs cc | orcc #$50
                lda #PatternSize
                mul
                addd #PatternRam
                tfr d,x
                pshs cc | orcc #$50
                    sta Bank
                        ldy #SharedRam+Share_Pattern
                        ldb #PatternSize
                        do
                            lda ,x+
                            sta ,y+
                            decb
                        while ne | wend
                    lda Bank
                puls cc
            puls cc
        endif
        Put_skip:
        jsr Resume
    puls a,b,x,y
    tfr x,d
    addd #2
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #Vram+VramRowSize*1
        stx <wVram
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
                        ldx <wVram
                        bsr Put_
                    puls x
                endif
                VVramToVram_next:
                leay 1,y
                pshs x
                    ldx <wVram
                    leax 2,x
                    stx <wVram
                puls x
                dec <xCount
            while ne | wend
            pshs x
                ldx <wVram
                leax VramRowSize-VVramWidth*2,x
                stx <wVram
            puls x
            dec <yCount
        while ne | wend
    puls a,b,x,y
rts


SetWall_:
    pshs x
        ldx <wVram
        jsr Halt
        sta SharedRam+Share_Char
        stx SharedRam+Share_Address
        lda #SubCommand_SetWall
        sta SharedRam+Share_Command
        jsr Resume
    puls x
rts
