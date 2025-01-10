include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext CharPattern

VramTop equ Vram+VramRowSize*2

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

    dseg
Backup:
    defs VVramWidth*'VVramHeight


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pshs a,x
        ldx #Vram
        do
            clr ,x+
            cmpx #Vram+VramRowSize*VramHeight
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
    pshs x,y
        lda #8
        mul
        ldy #CharPattern
        leay d,y
        ldb #8
        do
            lda ,y+
            sta ,x
            leax VramWidth,x
            decb
        while ne | wend
    puls x,y    
    leax 1,x
    tfr	x,d
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop
        stx <Dp.Word0
        ldx #VVramFront_
        ldy #Backup
        lda #VVramHeight | sta <Dp.Counter0
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
                leax VramRowSize-VVramWidth,x
                stx <Dp.Word0
            puls x
            dec <Dp.Counter0
        while ne | wend
    puls a,b,x,y
rts
