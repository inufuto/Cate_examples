include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern

dseg
Backup:
    defs VVramWidth*VVramHeight
CharColors:
    defs Char_End

RowStep equ $0400

zseg

Direct: public Direct
@Temp@Byte: defb 0
@Temp@ByteCount: defb 0
@Temp@Word: defw 0
@Temp@Word2: defw 0 
@Temp@WordCount: defw 0 

Dp.Word0: defw 0
Dp.Word1: defw 0
Dp.Counter0: defb 0
Dp.Counter1: defb 0
Dp.X: defb 0
Dp.Y: defb 0
Dp.C: defb 0


cseg
ColorTable:
defb 64,7 ; Ascii
defb 16,5 ; Logo
defb 16,1 ; Wall
defb 32,7 ; Man
defb 32,3 ; Monster
defb 4,2 ; FireBullet
defb 4,2 ; Fire
defb 4,6 ; Dot
defb 4,6 ; Food
defb 0
InitVram: public InitVram
    ldx #ColorTable
    ldy #CharColors
    do
        ldb ,x+
    while ne
        lda ,x+
        do
            ora #$90
            sta ,y+
            decb
        while ne | wend
    wend
rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs a,x
        lda #$97 | sta $FFD8 ;C-REG-SEL
        
        ldx #Vram
        do
            clr ,x+
            cmpx #Vram+$2000
        while ne | wend
        
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
    puls a,x
rts


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y
        ldy #CharColors
        clra
        lda d,y
        sta $FFD8   ;C-REG-SEL

        clra
        lslb | rola ;*2
        lslb | rola ;*4
        lslb | rola ;*8
        addd #CharPattern
        tfr d,y
        ldb #8
        do
            lda ,y+
            sta ,x
            leax RowStep,x
            decb
        while ne | wend
    puls a,b,x,y
    tfr	x,d
    addd #1
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #Vram+VramRowSize*1
        stx <Dp.Word0
        ldx #VVramFront_
        ldy #Backup
        lda #VVramHeight
        sta <Dp.Counter0
        do
            lda #VVramWidth
            sta <Dp.Counter1
            do 
                ldb ,x+
                cmpb ,y
                if ne
                    stb ,y
                    pshs x
                        ldx <Dp.Word0
                        bsr Put_
                    puls x
                endif
                leay 1,y
                pshs x
                    ldx <Dp.Word0
                    leax 1,x
                    stx <Dp.Word0
                puls x
                dec <Dp.Counter1
            while ne | wend
            pshs x
                ldx <Dp.Word0
                leax VramWidth-VVramWidth,x
                stx <Dp.Word0
            puls x
            dec <Dp.Counter0
        while ne | wend
    puls a,b,x,y
rts
