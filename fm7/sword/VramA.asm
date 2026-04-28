include "BIOS.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"
include "SubBin.inc"
include "Share.inc"

ext  @Temp@Word
ext SendSubsys, HaltSubsys, ResuumeSubsys, WaitSubsys, WriteSharedRam
ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

SharedRam equ $FC80
Bank equ $fd0f

Vram equ $0000
PatternRam equ $8000
SpritePatternW equ PatternRam+PatternSize*$100

VramTop equ Vram+VramRowSize*2
SpritePatternSize equ CharHeight*VramStep*(PlaneCount+1)*4

dseg
; SpritePatternW: public SpritePatternW
;     defs SpritePatternSize*Pattern_End
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
Backup: public Backup
    defs VVramWidth*VVramHeight
NextSpriteChar:
    defb 0
zseg
xCount:
    defb 0
yCount:
    defb 0
plCount:
    defb 0    


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
cseg
ColorTable:
defb 31, 7 ; Ascii
defb 15, 6 ; Logo
defb 2, 1 ; Fence
defb 4, 1 ; Wall
defb 0
InitVram: public InitVram
    pshs u,cc | orcc #$50
        sta Bank

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

        ldy #SpritePattern
        ldx #SpritePatternW
        ldd #SpritePatternSize*Pattern_End
        bsr MakePatternColor

        lda Bank
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
    pshs cc | orcc #$50
        sta Bank

        ldx #PatternRam+PatternSize*Char_SubsysTop
        ldb #Char_SubsysTop
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
            cmpb #Char_SubsysTail
        while ne | wend

        lda Bank
    puls cc
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
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        ; ldx #VVram_
        ; do
        ;     clr ,x+
        ;     cmpx #VVram_+VVramWidth*VVramHeight
        ; while ne | wend
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
        cmpb #Char_SubsysTop
        bcs Put_viaSharedRam
        cmpb #Char_SubsysTail
        bcs Put_skip
        cmpb lastChar
        if ne
            Put_viaSharedRam:
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


; void BeginDraw();
cseg
BeginDraw_: public BeginDraw_
    pshs a,b,x,y
        ldx #VVram_
        ldy #SpriteLayer
        do
            ldd ,x++
            std ,y++
            cmpx #VVram_+VVramWidth*VVramHeight
        while ne | wend

        lda #Char_End | sta NextSpriteChar
    puls a,b,x,y
rts


scope
; void EndDraw();
zseg
wVram:
    defw 0
cseg
EndDraw_: public EndDraw_
    pshs a,b,x,y
        ldx #VramTop | stx <wVram
        ldx #SpriteLayer
        ldy #Backup
        lda #VVramHeight
        sta <yCount
        do
            lda #VVramWidth
            sta <xCount
            do 
                ldb ,x+
                cmpb #Char_End
                bcc EndDraw_draw
                cmpb ,y
                if ne
                    EndDraw_draw:
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
                    leax VramStep,x
                    stx <wVram
                puls x
                dec <xCount
            while ne | wend
            pshs x
                ldx <wVram
                leax VramRowSize-VVramWidth*VramStep,x
                stx <wVram
            puls x
            dec <yCount
        while ne | wend
    puls a,b,x,y
rts
endscope


; void DrawSprite(byte x, byte y, byte pattern);
scope
dseg
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
zseg
pSpriteLayer:
    defw 0
pSpritePattern:
    defw 0
pSource:
    defw 0
yCount2:
    defb 0
mask:
    defw 0
cseg
DrawSprite_: public DrawSprite_
    pshs a,b,x,y
        sta pSpriteLayer+1 | clr pSpriteLayer ; x
        lda #VVramWidth | mul
        addd pSpriteLayer
        addd #SpriteLayer
        std pSpriteLayer

        lda DrawSprite_pattern | clrb
        addd #SpritePatternW
        std pSpritePattern

        lda #2 | sta yCount
        do
            lda #2 | sta xCount
            do
                pshs cc | orcc #$50 | sta Bank
                    ldx pSpriteLayer
                    lda ,x

                    ldb #PatternSize | mul
                    addd #PatternRam
                    std pSource

                    lda NextSpriteChar
                    inca
                    sta NextSpriteChar
                    sta ,x+
                    stx pSpriteLayer

                    ldb #PatternSize | mul
                    addd #PatternRam
                    tfr d,y

                    lda #CharHeight | sta yCount2
                    do
                        ldx pSpritePattern
                        ldd ,x++
                        coma | comb
                        std mask
                        stx pSpritePattern

                        lda #PlaneCount | sta plCount
                        do
                            ldx pSource
                            ldd ,x++
                            anda mask | andb mask+1
                            stx pSource

                            ldx pSpritePattern
                            ora ,x+
                            orb ,x+
                            stx pSpritePattern

                            std ,y++

                            dec plCount
                        while ne | wend
                        dec yCount2
                    while ne | wend
                lda Bank | puls cc
                dec xCount
            while ne | wend
            ldx pSpriteLayer
            leax VVramWidth-2,x
            stx pSpriteLayer

            dec yCount
        while ne | wend
    puls a,b,x,y
rts
endscope
