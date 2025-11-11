include "Vram.inc"
include "Chars.inc"

ext FortDotOffset_
ext DispPage

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
        stb yPos

        ldb DispPage
        andb #$01
        if ne
            ldy #TVram0
        else
            ldy #TVram1
        endif
        leay a,y

        ldb yPos
        addb #16+2
        lda #VramWidth | mul
        addd #VramWidth*(-(16+2))
        leay d,y

        lda FortDotOffset_
        if eq
            ldb #Char_Fort0
            lda #6
        else
            ldb #Char_Fort1
            lda #7
        endif
        sta yCount
        do
            lda yPos
            cmpa #VramHeight
            if cs
                lda #6
                do
                    stb ,y+
                    incb
                    deca
                while ne | wend
                leay VramWidth-6,y
            else
                addb #6
                leay VramWidth,y
            endif
            inc yPos
            dec yCount
        while ne | wend
    puls a,b,x,y
rts
endscope
