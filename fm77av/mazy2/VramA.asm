include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramFront_, VVramBack_
ext MonoPattern, ColorPattern

VramTop equ Vram+VramRowSize*1
MMR_Vram equ $fd80+(Vram shr 12)


dseg
PatternRam: public PatternRam
    defs PatternSize*Char_End
BackupBack:
    defs VVramWidth*VVramHeight
BackupFront:
    defs VVramWidth*VVramHeight

zseg
charColor:
    defb 0
charCount:
    defb 0
yCount:
    defb 0
xCount:
    defb 0
pVram:
    defw 0
invertedByte:
    defb 0
plCount:
    defb 0
colorBits:
    defb 0
rowFlagByte:
    defb 0
rowFlagMask:
    defb 0
pRowFlags:
    defw 0


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 8,15 ; Stair
defb 4,10 ; Goal
defb 16,7 ; Point
defb 0
Palette:
defb	$00, $00, $00, $0d, $05, $03, $00, $0f
defb	$00, $0d, $0f, $09, $00, $00, $0f, $0f
defb	$00, $0b, $00, $0f, $0f, $0f, $0f, $0f
defb	$00, $00, $00, $07, $07, $07, $00, $0f
defb	$0b, $07, $0d, $07, $00, $00, $07, $09
defb	$00, $05, $09, $0d, $0b, $0b, $0b, $0b
InitVram: public InitVram
    pshs u,cc | orcc #$50
        clra | clrb
        do
            std $fd30
            pshs a
                clra
                sta $fd32
                sta $fd33
                sta $fd34
            puls a
            addd #1
            cmpd #$1000
        while ne | wend
        ldx #ColorIndices
        clrb
        do
            clra
            std $fd30
            pshs b
                lda ,x+
                ldb #3 | mul
                addd #Palette
                tfr d,y
                lda ,y+ | sta $fd32
                lda ,y+ | sta $fd33
                lda ,y+ | sta $fd34
            puls b
            incb
        while ne | wend

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

ColorIndices:
	defb $00,$02,$01,$03,$02,$02,$01,$03
	defb $01,$02,$01,$03,$03,$02,$01,$03
	defb $08,$0a,$09,$0b,$08,$0a,$09,$0b
	defb $08,$0a,$09,$0b,$08,$0a,$09,$0b
	defb $04,$06,$05,$07,$04,$06,$05,$07
	defb $04,$06,$05,$07,$04,$06,$05,$07
	defb $0c,$0e,$0d,$0f,$0c,$0e,$0d,$0f
	defb $0c,$0e,$0d,$0f,$0c,$0e,$0d,$0f
	defb $08,$02,$01,$03,$0a,$02,$01,$03
	defb $09,$02,$01,$03,$0b,$02,$01,$03
	defb $08,$0a,$09,$0b,$08,$0a,$09,$0b
	defb $08,$0a,$09,$0b,$08,$0a,$09,$0b
	defb $04,$06,$05,$07,$04,$06,$05,$07
	defb $04,$06,$05,$07,$04,$06,$05,$07
	defb $0c,$0e,$0d,$0f,$0c,$0e,$0d,$0f
	defb $0c,$0e,$0d,$0f,$0c,$0e,$0d,$0f
	defb $04,$02,$01,$03,$06,$02,$01,$03
	defb $05,$02,$01,$03,$07,$02,$01,$03
	defb $08,$0a,$09,$0b,$08,$0a,$09,$0b
	defb $08,$0a,$09,$0b,$08,$0a,$09,$0b
	defb $04,$06,$05,$07,$04,$06,$05,$07
	defb $04,$06,$05,$07,$04,$06,$05,$07
	defb $0c,$0e,$0d,$0f,$0c,$0e,$0d,$0f
	defb $0c,$0e,$0d,$0f,$0c,$0e,$0d,$0f
	defb $0c,$02,$01,$03,$0e,$02,$01,$03
	defb $0d,$02,$01,$03,$0f,$02,$01,$03
	defb $08,$0a,$09,$0b,$08,$0a,$09,$0b
	defb $08,$0a,$09,$0b,$08,$0a,$09,$0b
	defb $04,$06,$05,$07,$04,$06,$05,$07
	defb $04,$06,$05,$07,$04,$06,$05,$07
	defb $0c,$0e,$0d,$0f,$0c,$0e,$0d,$0f
	defb $0c,$0e,$0d,$0f,$0c,$0e,$0d,$0f


MakePatternMono:
    std <charColor
    do
        lda <charColor | sta <colorBits
        lda #PlaneCount | sta <plCount
        do
            pshs y
                lda #CharHeight
                sta <yCount
                do
                    clrb
                    lda <colorBits
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
                    lda #2
                    stb ,x+
                    leay 1,y
                    dec <yCount
                while ne | wend
                lsr <colorBits
                dec <plCount
            puls y
        while ne | wend
        leay CharHeight,y
        dec <charCount
    while ne | wend
rts


MakePatternColor:
    stb <charCount
    do
        lda #PatternSize | sta <yCount
        do
            ldb ,y+
            stb ,x+
            dec <yCount
        while ne | wend
        dec <charCount
    while ne | wend
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pshs a,b,x,y
        clrb
        do
            stb $f430
            lda #$10
            do
                sta MMR_Vram
                ldx #Vram
                do
                    clr ,x+
                    cmpx #Vram+$1000
                while ne | wend
                inca
                cmpa #$1c
            while cs | wend
            addb #$20
            cmpb #$40
        while ne | wend
        clr $f430

        ldx #BackupBack
        ldy #VVramWidth*VVramHeight*2
        do
            clr ,x+
            leay -1,y
        while ne | wend

        ldx #VVramBack_
        ldd #VVramWidth*VVramHeight*2
        do
            clr ,x+
            subd #1
        while ne | wend
    puls a,b,x,y
rts


cseg
Put: ;(a:page, x, y)
    lda #$10
    do
        sta MMR_Vram
        inca
        sta MMR_Vram+1
        inca
        pshs a
            ldb #CharHeight
            do
                lda ,y+ | sta ,x
                leax VramWidth,x
                decb
            while ne | wend
            leax -VramWidth*CharHeight,x
        puls a
        cmpa #$10+PlaneCount*2
    while cs | wend
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs x,y
        lda #PatternSize
        mul
        addd #PatternRam
        tfr d,y

        bsr Put
    puls x,y
    tfr x,d
    addd #1
rts


VVramToVram:
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
                pshs x,y
                    lda #PatternSize
                    mul
                    addd #PatternRam
                    tfr d,y
                    ldx <pVram
                    bsr Put
                puls x,y
            endif
            leay 1,y
            pshs x
                ldx <pVram
                leax 1,x
                stx <pVram
            puls x
            dec <xCount
        while ne | wend
        pshs x
            ldx <pVram
            leax VramRowSize-VVramWidth,x
            stx <pVram
        puls x
        dec <yCount
    while ne | wend
rts

; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop | stx <pVram
        ldx #VVramBack_
        ldy #BackupBack
        bsr VVramToVram
        
        ldx #VramTop | stx <pVram
        ldx #VVramFront_
        ldy #BackupFront
        lda #$20 | sta $f430
        bsr VVramToVram

        clra | sta $f430
    puls a,b,x,y
rts
