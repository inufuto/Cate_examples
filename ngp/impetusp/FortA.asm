include "ngp.inc"
include "Vram.inc"
include "Chars.inc"

ext FortDotOffset_, FortCharOffset_
ext MonoPattern, ColorPattern
ext yMod_
ext BackVram, Put_

dseg
pGroundPattern:
    defd 0
pFortPattern:
    defd 0

cseg
MonoGroundPattern:
    defb 00h,00h,00h,00h,00h,00h,00h,00h,00h
    defb 00h,00h,00h,00h,00h,00h,00h,00h,00h
ColorGroundPattern:
    defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
    defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

; void UpdateFortChars();
cseg
UpdateFortChars_: public UpdateFortChars_
    push wa | push hl | push de | push bc | push xix | push xiy
        ld a,(Version)
        or a,a
        if z
            ld xix,MonoPattern
            ld xiy,MonoGroundPattern
        else
            ld xix,ColorPattern
            ld xiy,ColorGroundPattern
        endif
        ld (pGroundPattern),xiy
        add ix,PatternSize*Char_Fort | ld (pFortPattern),xix

        ld a,(FortCharOffset_)
        or a,a
        if z
            ld hl,0a000h+PatternSize*Char_Fort0
        else
            ld hl,0a000h+PatternSize*Char_Fort1
        endif
        ld d,(FortDotOffset_) | and d,7 | add d,d ; upperCount
        ld e,PatternSize | sub e,d ; lowerCount

        ld xiy,(pFortPattern) ; pLowerSource
        ld c,6
        do
            ld xix,(pGroundPattern) ; pUpperSource
            call UpdateC
        dwnz c

        ld xix,(pFortPattern)
        lda xix,xix+e
        ld c,6*5
        do
            call UpdateC
        dwnz c

        ld c,6
        do
            ld xiy,(pGroundPattern) ; pLowerSource
            lda xiy,xiy+d
            call UpdateC
        dwnz c
    pop xiy | pop xix | pop bc | pop de | pop hl | pop wa
ret
UpdateC:
    or d,d ; upperCount
    if nz
        ld b,d
        do
            ld a,(xix+)
            ld (xhl+),a
        dwnz b
    endif
    ld b,e ; lowerCount
    do
        ld a,(xiy+)
        ld (xhl+),a
    dwnz b
    lda xix,xix+e
    lda xiy,xiy+d
ret


; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push wa | push hl | push bc
        ld h,c
            add c,16
            add c,(yMod_)
            mul bc,VramRowSize
            xor w,w
            add a,a
            add bc,wa
            add bc,BackVram-VramRowSize*16
            ld wa,bc
        ld b,h

        ld c,(FortCharOffset_)
        add c,Char_Fort

        ld h,7
        do
            cp b,WindowHeight
            if c
                ld l,6
                do
                    call Put_
                    inc 1,c
                dwnz l
                add wa,VramRowSize-6*VramStep
            else
                add c,6
                add wa,VramRowSize
            endif
            inc 1,b
        dwnz h
    pop bc | pop hl | pop wa
ret
