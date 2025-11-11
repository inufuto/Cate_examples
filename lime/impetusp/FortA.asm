include "VVram.inc"
include "Chars.inc"

ext VVramFront_

; void DrawFort(byte x, byte y);
scope
zseg
yPos:
    defb 0
yCount:
    defb 0
cseg
DrawFort_: public DrawFort_
    pshs a,b,x,y
        ldy #VVramFront_
        leay a,y

        stb yPos
        addb #16+2
        lda #VVramWidth | mul
        addd #VVramWidth*(-(16+2))
        leay d,y

        ldb #Char_Fort
        lda #6 | sta yCount
        do
            lda yPos
            cmpa #VVramHeight
            if cs
                lda #6
                do
                    stb ,y+
                    incb
                    deca
                while ne | wend
                leay VVramWidth-6,y
            else
                addb #6
                leay VVramWidth,y
            endif
            inc yPos
            dec yCount
        while ne | wend
    puls a,b,x,y
rts
endscope
