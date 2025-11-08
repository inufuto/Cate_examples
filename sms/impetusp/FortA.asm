include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext NextPage
ext FortDotOffset_, FortCharOffset_
ext FortPattern
ext RepeatWrite

cseg
GroundPattern:
	defb	00h, 00h, 0ffh, 00h, 00h, 00h, 0ffh, 40h
	defb	00h, 00h, 0ffh, 00h, 00h, 00h, 0ffh, 04h
	defb	00h, 00h, 0ffh, 00h, 00h, 00h, 0ffh, 40h
	defb	00h, 00h, 0ffh, 00h, 00h, 00h, 0ffh, 04h

cseg
SetWrite:
    ld a,e | out (VdpPort+1),a
    ld a,d | out (VdpPort+1),a
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
AddDePatternSize:
    ld a,e | add a,PatternSize | ld e,a
    ld a,d | adc a,0 | ld d,a
ret

; void UpdateFortChars();
cseg
UpdateFortChars_: public UpdateFortChars_
    push af | push hl | push de | push bc
        ld a,(FortCharOffset_)
        or a
        if z
            ld de,4000h or Char_Fort0*PatternSize 
        else
            ld de,4000h or Char_Fort1*PatternSize
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
            di
                            _deb: public _deb
                call SetWrite
                exx
                    ld a,e
                    or a
                    if nz
                        ld b,a
                        ld hl,GroundPattern
                        call RepeatWrite
                    endif
                exx
                ld a,PatternSize
                exx
                    sub e
                exx
                ld b,a
                call RepeatWrite
            ei
            call AddHlEDash
            call AddDePatternSize
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
            di
                call SetWrite
                exx
                    ld a,e
                    or a
                    if nz
                        ld b,a
                        call RepeatWrite
                    endif
                exx
                ld a,PatternSize
                exx
                    sub e
                exx
                ld b,a
                call RepeatWrite
            ei
            exx
                call AddHlA
            exx
            call AddHlEDash
            call AddDePatternSize
            dec c
        while nz | wend

        ld c,6
        do
            di
                call SetWrite
                exx
                    ld a,e
                    or a
                    if nz
                        ld b,a
                        call RepeatWrite
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
            ei
            exx
                call AddHlA
            exx
            call AddDePatternSize
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
        add hl,hl
        ld a,(NextPage) ;| xor 4
        or 40h
        add a,h | ld h,a
        ld de,-VramRowSize*(16+2) | add hl,de

        ld a,(FortCharOffset_)
        add a,Char_Fort
        ld d,a

        ld e,7
        do
            exx
                ld a,c
            exx
            cp VramHeight
            if c
                di
                    ld a,l | out (VdpPort+1),a
                    ld a,h | out (VdpPort+1),a
                    ld b,6
                    do
                        ld a,d | out (VdpPort),a
                        nop | nop
                        inc d
                        xor a | out (VdpPort),a
                    dwnz
                ei
            else
                ld a,d | add a,6 | ld d,a
            endif
            exx
                inc c
            exx
            ld a,l | add a,VramRowSize | ld l,a
            ld a,h | adc a,0 | ld h,a

            dec e
        while nz | wend
        exit:
    pop bc | pop de | pop hl | pop af
ret
