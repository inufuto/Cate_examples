include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext CharPattern

VramTop equ Vram+VramRowSize*2

zseg

; pVram: defw 0
; Dp.Word1: defw 0
; Dp.Counter0: defb 0
; xCount: defb 0
; Dp.X: defb 0
; Dp.Y: defb 0
; Dp.C: defb 0

dseg
Backup:
    defs VVramWidth*'VVramHeight


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pshs a,x
        lda #$aa
        ldx #Vram
        do
            sta ,x+
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


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    pshs y
        ldy #CharTable
        clra
        do
            cmpb ,y+
            beq PrintC_break
            inca
            cmpa #30
        while cs | wend
        clra
        PrintC_break:
        tfr a,b
        bsr Put_
    puls y
rts


scope
pVram equ @Temp@Word
yCount equ @Temp@Byte
xCount equ @Temp@Byte2
; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop
        stx <pVram
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
                    puls x
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
    puls a,b,x,y
rts
endscope