include "Vram.inc"
include "VVram.inc"
include "Chars.inc"
include "Direct.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext VVram_

CharPatternSize equ CharHeight*2
VramTop equ Vram+VramRowSize*0

dseg
PatternRam: public PatternRam
    defs CharPatternSize*$100
SpriteLayer: public SpriteLayer
	defs VVramWidth*VVramHeight
Backup: public Backup
    defs VVramWidth*VVramHeight
NextSpriteChar:
    defb 0

cseg
PaletteTable:
defb	$00, $00, $0d, $35, $00, $0f, $0d, $9d
defb	$00, $f0, $0f, $f0, $00, $ff, $0f, $ff
defb	$00, $00, $07, $77, $00, $9d, $05, $5b
defb	$00, $70, $09, $50, $03, $df, $0b, $bb
ColorTable:
defb 29,7 ; Ascii
defb 16,10 ; Logo
defb 8,15 ; CrackedFloor
defb 1,15 ; HardFloor
defb 2,10 ; Ladder
defb 4,6 ; Item
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
    defb " -0123456789ABCEFGHIMNOPRSTUV"
PrintC_: public PrintC_
    pshs y
        ldy #CharTable
        clra
        do
            cmpb ,y+
            beq PrintC_break
            inca
            cmpa #29
        while cs | wend
        clra
        PrintC_break:
        tfr a,b
        bsr Put_
    puls y
rts
endscope

scope
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
endscope

; void EndDraw();
scope
zseg
wVram:
    defw 0
xCount:
    defb 0
yCount:
    defb 0
cseg
EndDraw_: public EndDraw_
    pshs a,b,x,y
        ldx #VramTop | stx <wVram
        ldx #SpriteLayer
        ldy #Backup
        lda #VVramHeight | sta yCount
        do
            lda #VVramWidth | sta xCount
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
xCount:
    defb 0
yCount:
    defb 0
bCount:
    defb 0
spriteByte:
    defb 0
sourceByte:
    defb 0
mixedByte:
    defb 0
cseg
DrawSprite_: public DrawSprite_
    pshs a,b,x,y
        sta pSpriteLayer+1 | clr pSpriteLayer ; x
        lda #VVramWidth | mul
        addd pSpriteLayer
        addd #SpriteLayer
        std pSpriteLayer

        lda DrawSprite_pattern | clrb
        lsra | rorb
        lsra | rorb
        addd #SpritePattern
        std pSpritePattern

        lda #2 | sta yCount
        do
            lda #2 | sta xCount
            do
                ldx pSpriteLayer
                lda ,x

                ldb #CharPatternSize | mul
                addd #PatternRam
                std pSource

                lda NextSpriteChar
                inc NextSpriteChar
                sta ,x+
                stx pSpriteLayer

                ldb #CharPatternSize | mul
                addd #PatternRam
                tfr d,y

                lda #CharPatternSize | sta bCount
                do
                    ldx pSpritePattern
                    lda ,x+ | sta spriteByte
                    stx pSpritePattern

                    ldx pSource
                    lda ,x+ | sta mixedByte
                    stx pSource

                    lda spriteByte | anda #$f0
                    if ne
                        ldb mixedByte
                        andb #$0f
                        stb sourceByte
                        ora sourceByte
                        sta mixedByte
                    endif
                    lda spriteByte | anda #$0f
                    if ne
                        ldb mixedByte
                        andb #$f0
                        stb sourceByte
                        ora sourceByte
                        sta mixedByte
                    endif
                    lda mixedByte
                    sta ,y+

                    dec bCount
                while ne | wend
                
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
