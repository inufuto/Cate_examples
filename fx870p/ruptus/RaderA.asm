include "Vram.inc"
include "VVram.inc"

ext Vram_
ext VramPtr_, VramPtr_@Param1
ext FighterX_,FighterY_ 

RaderLeft equ VVramWidth/2
RaderLeftTop equ Vram_+RaderLeft*VramStep


; void PrintRader();
cseg
PrintRader_: public PrintRader_
    phsm $2,3
    phsm $13,4
        ldw $10,RaderLeftTop
        ldw $12,VramRowSize
        ld $0,&hff
        ld $1,4
        do
            pre ix,$10
            ld $2,6*VramStep
            do
                sti $0,(ix+$sx)
                sb $2,$sy
            while nz | wend
            adw $10,$12
            sb $1,$sy
        while nz | wend
    ppsm $10,4
    ppsm $0,3
rtn


; void DrawFortOnRader(byte x, byte y, bool visible)
cseg
DrawFortOnRader_: public DrawFortOnRader_
    phsm $3,4
    phsm $13,4
        bid $1
        bid $1
        bid $1
        ld $3,$1
        bid $1
        bid $0
        bid $0
        bid $0
        ad $0,RaderLeft
        cal VramPtr_
        pre ix,$10

        sbc $2,$sx
        if nz
            anc $3,1
            if z
                ld $1,&h1f
            else
                ld $1,&hf1
            endif
            ld $2,3
            do
                ld $0,(ix+$sx)
                an $0,$1
                sti $0,(ix+$sx)
                sb $2,$sy
            while nz | wend
        else
            anc $3,1
            if z
                ld $1,&he0
            else
                ld $1,&h0e
            endif
            ld $2,3
            do
                ld $0,(ix+$sx)
                or $0,$1
                sti $0,(ix+$sx)
                sb $2,$sy
            while nz | wend
        endif
    ppsm $10,4
    ppsm $0,4
rtn


; void DrawFighterOnRader();
cseg
DrawFighterOnRader_: public DrawFighterOnRader_
    phsm $3,4
    phsm $13,4
        pre ix,FighterX_
        ldi $0,(ix+$sx)
        ldi $1,(ix+$sx)
        
        sb $1,$sy
        bid $1
        sbc $1,8*4
        if nc
            ld $1,$sx
        endif
        ld $3,$1
        bid $1
        bid $1
        bid $1
        
        sb $0,$sy
        bid $0
        sbc $0,6*4
        if nc
            ld $0,$sx
        endif
        ld $2,$0
        bid $0
        bid $0
        ad $0,RaderLeft

        cal VramPtr_
        ld $12,$2
        an $12,3
        ld $13,$sx
        adw $10,$12
        pre ix,$10
                                    _deb: public _deb

        ld $0,&h80
        an $3,7
        do | while nz
            bid $0
            sb $3,$sy
        wend

        ld $1,(ix+$sx)
        xr $1,$0
        st $1,(ix+$sx)
    ppsm $10,4
    ppsm $0,4
rtn
