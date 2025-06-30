include "S1.inc"
include "Vram.inc"

ext FighterX_, FighterY_

LeftTop equ Vram+VramRowSize*12+32

zseg
bits:
    defb 0

; void DrawFighterOnRader();
cseg
DrawFighterOnRader_: public DrawFighterOnRader_
    pshs a,b,y
        lda FighterY_
        deca
        cmpa #96
        if cc
            clra
        endif
        pshs a
            lsra | lsra | lsra
            ldb #VramRowSize
            mul
            addd #LeftTop
            tfr d,y
        puls a
        anda #6
        lsla | lsla
        clrb
        leay d,y

        ldb #$c0
        lda FighterX_
        deca
        anda #63
        pshs a
            lsra | lsra | lsra
            leay a,y
        puls a
        lsra
        anda #3
        do | while ne
            lsrb | lsrb
            deca
        wend
        stb <bits

        lda #$b0
        do
            sta MAP0
            inca 
            sta MAP1
            inca 
            pshs a
                ldb #2
                do
                    stb ACTIVE_PLANE
                    lda ,y
                    eora <bits
                    sta ,y
                    lda $400,y
                    eora <bits
                    sta $400,y
                    lslb
                    cmpb #8
                while ne | wend
            puls a
            cmpa #$b4
        while ne | wend
    puls a,b,y
rts
