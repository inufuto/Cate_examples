include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern

INIT1 equ $FF91
VramTop equ Vram+VramRowSize*2


dseg
PatternRam:
    defs PatternSize*Char_End
Backup:
    defs VVramWidth*VVramHeight

zseg
CharColor:
    defb 0
CharCount:
    defb 0
yCount:
    defb 0
xCount:
    defb 0
bitCount:
    defb 0
pattern:
    defb 0
pVram:
    defw 0
; pFlag:
;     defw 0
; flagByte:
;     defb 0
; flagBit:
;     defb 0

cseg
ColorTable:
defb 64, 15 ; Ascii
defb 16, 5 ; Logo
defb 8,7 ; Stair
defb 4,2 ; Goal
defb 16,15 ; Point
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
    do
        lda #CharHeight | sta <yCount
        do
            ldb ,y+
            lda #VramStep | sta <xCount
            do
                clr <pattern
                lda #2 | sta <bitCount
                do
                    lda <pattern
                    lsla | lsla | lsla | lsla
                    sta <pattern

                    lda <CharColor
                    bitb #$80
                    if ne
                        lda <CharColor
                        anda #$0f
                    else
                        lsra | lsra | lsra | lsra
                    endif
                    ora <pattern
                    sta <pattern

                    lslb
                    dec <bitCount
                while ne | wend
                lda <pattern | sta ,x+
                dec <xCount
            while ne | wend
            dec <yCount
        while ne | wend
        dec <CharCount
    while ne | wend
rts


MakePatternColor:
    lda #PatternSize
    mul
    do
        pshs a,b
            lda ,y+ | sta ,x+
        puls a,b
        subd #1
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs a,b,x,y
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldx #Vram
            do
                clr ,x+
                cmpx #Vram+VramRowSize*VramHeight
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc

        ldx #Backup
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        ldx #VVramBack_
        ldd #VVramWidth*VVramHeight*2
        do
            clr ,x+
            subd #1
        while ne | wend
    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y
        lda #PatternSize
        mul
        ldy #PatternRam
        leay d,y
        
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldb #CharHeight
            do
                pshs b
                    ldb #VramStep
                    do
                        lda ,y+
                        sta ,x+
                        decb
                    while ne | wend
                    leax VramWidth-VramStep,x
                puls b
                decb
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc
    puls a,b,x,y    
    tfr	x,d
    addd #VramStep
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop | stx <pVram
        ldx #VVramFront_
        ldy #Backup
        lda #VVramHeight | sta <yCount
        do
            lda #VVramWidth | sta <xCount
            do 
                ldb ,x+
                cmpb ,y
                if ne
                    stb ,y
                    pshs x
                        ldx <pVram
                        bsr Put_
                        std <pVram
                    puls x
                else
                    ldd <pVram
                    addd #VramStep
                    std <pVram
                endif
                leay 1,y
                dec <xCount
            while ne | wend
            ldd <pVram
            addd #VramRowSize-VVramWidth*VramStep
            std <pVram
            dec <yCount
        while ne | wend
    puls a,b,x,y
rts
