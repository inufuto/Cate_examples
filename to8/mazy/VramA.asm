include "Vram.inc"
include "VVram.inc"
include "Chars.inc"
include "Direct.inc"

ext MonoPattern, ColorPattern
ext VVram_

CharPatternSize equ CharHeight*2
VramTop equ Vram+VramRowSize*0

dseg
PatternRam: public PatternRam
    defs CharPatternSize*$100
Backup: public Backup
    defs VVramWidth*VVramHeight

cseg
PaletteTable:
defb	$00, $00, $0d, $35, $00, $0f, $0d, $9f
defb	$00, $f0, $0f, $fb, $00, $ff, $0f, $ff
defb	$00, $00, $07, $77, $03, $59, $07, $7d
defb	$00, $70, $09, $50, $09, $bd, $0b, $bb
ColorTable:
defb 34,7 ; Ascii
defb 1,5 ; Wall
defb 4,7 ; Goal
defb 4,6 ; Bang
defb 4,7 ; M
defb 4,3 ; A
defb 4,6 ; Z
defb 4,2 ; Y
defb 0

scope
charCount equ @Temp@Byte
color equ @Temp@Byte2
patternByte equ @Temp@Byte3
InitVram: public InitVram
    lda #$7b | sta $E7DC
    clr $E7DD

    ldx #PaletteTable
    
    lda #$ff
    jsr $EC00
    
    pshs u,cc | orcc #$50
        ldu #ColorTable
        ldx #MonoPattern
        ldy #PatternRam
        do
            ldb ,u+ ; count
        while ne
            lda ,u+ ; color
            bsr MakePatternMono
        wend
    puls u,cc
    
    ldx #ColorPattern
    ldy #PatternRam+CharPatternSize*Char_Color
    do
        ldd ,x+
        std ,y+
        cmpy #PatternRam+CharPatternSize*Char_End
    while ne | wend
rts

MakePatternMonoPlane:
    clr patternByte
    ldb #2
    do
        pshs b
            ldb patternByte
            lslb | lslb | lslb | lslb
            stb patternByte

            ldb color
            lsla
            if cs
                andb #$0f
            else
                lsrb | lsrb | lsrb | lsrb
            endif
            orb patternByte
            stb patternByte
        puls b
        decb
    while ne | wend
    ldb patternByte
    stb ,y
rts
MakePatternMono:
    stb charCount
    sta color
    do
        ldb #CharHeight/2
        do
            pshs b
                lda ,x+
                ldb #2
                do
                    pshs b
                        bsr MakePatternMonoPlane
                        leay CharPatternSize/2,y
                        bsr MakePatternMonoPlane
                        leay 1-CharPatternSize/2,y
                    puls b
                    decb
                while ne | wend
            puls b
            decb
        while ne | wend
        leay CharPatternSize/2,y
        dec charCount
    while ne | wend
rts
endscope

Plane1:
    lda $E7C3 | ora #$01 | sta $E7C3
rts
Plane0:
    lda $E7C3 | anda #not $01 | sta $E7C3
rts


; void ClearScreen();
scope
ClearPlane:
    ldx #Vram
    do
        clr ,x+
        cmpx #Vram+$2000
    while ne | wend
rts
ClearScreen_: public ClearScreen_
    pshs a,x
        bsr Plane1
        bsr ClearPlane
        bsr Plane0
        bsr ClearPlane

        ldx #Backup
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        ldx #VVram_
        do
            clr ,x+
            cmpx #VVram_+VVramWidth*VVramHeight
        while ne | wend
    puls a,x
rts
endscope


; ptr<byte> Put(ptr<byte> pVram, byte c);
scope
yCount equ @Temp@Byte
cseg
PutPlane:
    ldb #CharHeight
    do
        lda ,y+ | sta ,x
        leax VramWidth,x
        decb
    while ne | wend
    leax -VramRowSize,x
rts
Put_: public Put_
    pshs x,y
        lda #CharPatternSize
        mul
        addd #PatternRam
        tfr d,y

        bsr Plane1
        bsr PutPlane
        bsr Plane0
        bsr PutPlane
        leax VramStep,x
        tfr x,d
    puls x,y
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCDEGHIKLMNOPRSTUVWXY"
PrintC_: public PrintC_
    pshs y
        ldy #CharTable
        clra
        do
            cmpb ,y+
            beq PrintC_break
            inca
            cmpa #34
        while cs | wend
        clra
        PrintC_break:
        tfr a,b
        bsr Put_
    puls y
rts
endscope


; void VVramToVram();
scope
zseg
wVram:
    defw 0
xCount:
    defb 0
yCount:
    defb 0
cseg
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop | stx <wVram
        ldx #VVram_
        ldy #Backup
        lda #VVramHeight | sta yCount
        do
            lda #VVramWidth | sta xCount
            do
                ldb ,x+
                cmpb ,y
                if ne
                    stb ,y
                    pshs x
                        ldx <wVram
                        tstb
                        beq Fill
                        cmpb #Char_Wall
                        beq FillWall
                        bsr Put_
                        next:
                    puls x
                endif
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
FillPlane:
    lda #CharHeight
    do
        stb ,x
        leax VramWidth,x
        deca
    while ne | wend
    leax -VramRowSize,x
rts

FillWall:
    ldb #$55
Fill:
    bsr Plane1
    bsr FillPlane
    bsr Plane0
    bsr FillPlane
bra next
endscope
