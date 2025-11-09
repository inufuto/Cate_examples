include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext FortDotOffset_, FortCharOffset_
ext FortPattern


cseg
GroundPattern:
    defb	44h, 44h, 44h, 44h, 4ch, 44h, 44h, 44h
	defb	44h, 44h, 44h, 44h, 44h, 44h, 4ch, 44h
	defb	44h, 44h, 44h, 44h, 4ch, 44h, 44h, 44h
	defb	44h, 44h, 44h, 44h, 44h, 44h, 4ch, 44h
RepeatWrite:
    ex af,af'
        do
            ld a,(hl) | inc hl
            ld (de),a | inc de
        dwnz
    ex af,af'
ret
RepeatWriteDash:
    ex af,af'
        do
            ld a,(hl) | inc hl
            exx
                ld (de),a | inc de
            exx
        dwnz
    ex af,af'
ret
AddHlEDash:
    ld a,l
    exx
        add a,e
    exx
    ld l,a
    ld a,h | adc a,0 | ld h,a
ret
AddHlA:
    add a,l | ld l,a
    ld a,h | adc a,0 | ld h,a
ret

; void UpdateFortChars();
cseg
UpdateFortChars_: public UpdateFortChars_
    push af | push hl | push de | push bc
        ld a,(FortCharOffset_)
        or a
        if z
            ld de,CharacterPatternTable+Char_Fort0*PatternSize 
        else
            ld de,CharacterPatternTable+Char_Fort1*PatternSize
        endif
        exx
            ld a,(FortDotOffset_)
            and 7
            add a,a
            add a,a
            ld e,a
        exx
        ld hl,FortPattern
        ld c,6
        do
            exx
                ld a,e
                or a
                if nz
                    ld b,a
                    ld hl,GroundPattern
                    call RepeatWriteDash
                endif
            exx
            ld a,PatternSize
            exx
                sub e
            exx
            ld b,a
            call RepeatWrite

            call AddHlEDash
            dec c
        while nz | wend

        exx
            ld a,low(FortPattern+PatternSize)
            sub e
            ld l,a
            ld a,high(FortPattern+PatternSize)
            sbc a,0
            ld h,a
        exx
        ld c,6*5
        do
            exx
                ld a,e
                or a
                if nz
                    ld b,a
                    call RepeatWriteDash
                endif
            exx
            ld a,PatternSize
            exx
                sub e
            exx
            ld b,a
            call RepeatWrite

            exx
                call AddHlA
            exx
            call AddHlEDash
            dec c
        while nz | wend

        ld c,6
        do
            exx
                ld a,e
                or a
                if nz
                    ld b,a
                    call RepeatWriteDash
                endif
            exx
            ld hl,GroundPattern
            call AddHlA
            ld a,PatternSize
            exx
                sub e
            exx
            ld b,a
            call RepeatWrite

            exx
                call AddHlA
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push af | push hl | push de | push bc
        ld d,a
        ld a,e
        exx
            ld c,a ; yPos
        exx
        add a,16+2
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,d | ld d,0
        add hl,de
        ld de,VVram_-VVramWidth*(16+2) | add hl,de

        ld a,(FortCharOffset_)
        add a,Char_Fort
        ld d,a

        ld e,7
        do
            exx
                ld a,c
            exx
            cp VVramHeight
            if c
                ld b,6
                do
                    ld (hl),d | inc hl
                    inc d
                dwnz
                ld a,l | add a,VVramWidth-6 | ld l,a
                ld a,h | adc a,0 | ld h,a
            else
                ld a,d | add a,6 | ld d,a

                ld a,l | add a,VVramWidth | ld l,a
                ld a,h | adc a,0 | ld h,a
            endif
            exx
                inc c
            exx

            dec e
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
