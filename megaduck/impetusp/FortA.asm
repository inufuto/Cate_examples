include "MegaDuck.inc"
include "Vram.inc"
include "Chars.inc"

ext NextPage
ext FortDotOffset_, FortCharOffset_
ext FortPattern
ext WaitModeN1

cseg
GroundPattern:
	defb	00h, 00h, 40h, 00h, 00h, 00h, 04h, 00h
	defb	00h, 00h, 40h, 00h, 00h, 00h, 04h, 00h
dseg
pUpperSource:
    defw 0
upperCount:
    defb 0
lowerCount:
    defb 0
pLowerSource:
    defw 0

; void UpdateFortChars();
cseg
UpdateFortChars_: public UpdateFortChars_
    push af | push hl | push de | push bc
        ld a,(FortCharOffset_)
        or a,a
        if z
            ld hl,CharRam0+Char_Fort0*PatternSize 
        else
            ld hl,CharRam1+(Char_Fort1-80h)*PatternSize
        endif

        ld a,(FortDotOffset_) | and a,7 | add a,a | ld (upperCount),a
        ld c,a | ld a,PatternSize | sub a,c | ld (lowerCount),a

        ld a,low(FortPattern) | ld (pLowerSource),a
        ld a,high(FortPattern) | ld (pLowerSource+1),a
        ld c,6
        do
            ld a,low(GroundPattern) | ld (pUpperSource),a
            ld a,high(GroundPattern) | ld (pUpperSource+1),a
            call UpdateC
        dec c | while nz | wend

        ld a,(lowerCount) | ld c,a
        ld a,low(FortPattern) | add a,c | ld (pUpperSource),a
        ld a,high(FortPattern) | adc a,0 | ld (pUpperSource+1),a
        ld c,6*5
        do
            call UpdateC
        dec c | while nz | wend

        ld c,6
        do
            ld a,(upperCount) | ld b,a
            ld a,low(GroundPattern) | add a,b | ld (pLowerSource),a
            ld a,high(GroundPattern) | adc a,0 | ld (pLowerSource+1),a
            call UpdateC
        dec c | while nz | wend
    pop bc | pop de | pop hl | pop af
ret
UpdateC:
    ld a,(upperCount)
    or a,a
    if nz
        push bc
            ld b,a
            ld a,(pUpperSource) | ld e,a
            ld a,(pUpperSource+1) | ld d,a
            call DoCopy
        pop bc
    endif
    push bc
        ld a,(lowerCount) | ld b,a
        ld a,(pLowerSource) | ld e,a
        ld a,(pLowerSource+1) | ld d,a
        call DoCopy
    pop bc
    ld a,l | or a,a
    if z
        ld a,h
        cp a,high(CharRam0)+8
        if z
            ld h,high CharRam1
        endif
    endif

    ld a,(pUpperSource) | add a,PatternSize | ld (pUpperSource),a
    ld a,(pUpperSource+1) | adc a,0 | ld (pUpperSource+1),a

    ld a,(pLowerSource) | add a,PatternSize | ld (pLowerSource),a
    ld a,(pLowerSource+1) | adc a,0 | ld (pLowerSource+1),a
ret    
DoCopy:
    di
        do
            ld a,(de) | inc de
            ld c,a
            call WaitModeN1
            ld a,c
            ld (hl+),a
        dec b | while nz | wend
    ei
ret


; void DrawFort(byte x, byte y);
dseg
yPos:
    defb 0
cseg
DrawFort_: public DrawFort_
    push af | push hl | push de | push bc
        ld d,a ; x
        ld a,e ; y
        ld (yPos),a
        add a,16+2
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,d | ld d,0
        add hl,de
        ld a,(NextPage) | add a,h | ld h,a
        ld de,-VramRowSize*(16+2) | add hl,de

        ld a,(FortCharOffset_)
        add a,Char_Fort
        ld d,a

        ld e,7
        do
            ld a,(yPos)
            cp a,WindowHeight
            if c
                di
                    ld b,6
                    do
                        call WaitModeN1
                        ld a,d
                        ld (hl+),a
                        inc d
                    dec b | while nz | wend
                ei
                ld a,l | add a,VramRowSize-6 | ld l,a
                ld a,h | adc a,0 | ld h,a
            else
                ld a,d | add a,6 | ld d,a
                ld a,l | add a,VramRowSize | ld l,a
                ld a,h | adc a,0 | ld h,a
            endif
            ld a,(yPos) | inc a | ld (yPos),a
        dec e | while nz | wend
    pop bc | pop de | pop hl | pop af
ret
