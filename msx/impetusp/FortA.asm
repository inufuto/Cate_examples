include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext NextPage
ext FortDotOffset_, FortCharOffset_
ext FortPattern


cseg
GroundPattern:
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0dfh, 0ffh, 0fdh
	defb	33h, 3ch, 33h, 3ch, 33h, 3ch, 33h, 3ch

; void UpdateFortChars();
cseg
SetWrite:
    inc c
    out (c),e
    out (c),d
    dec c
ret
AddHlE:
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
AddDe8:
    ld a,e | add a,8 | ld e,a
    ld a,d | adc a,0 | ld d,a
ret
WriteGF:
    di
        call SetWrite
        exx
            ld a,e
            or a
            if nz
                ld b,a
                ld hl,GroundPattern
                do
                    outi
                while nz|wend
            endif
        exx
        ld a,CharHeight
        exx
            sub e
        exx
        ld b,a
        do
            outi
        while nz|wend
    ei
ret
WriteFF:
    di
        call SetWrite
        exx
            ld a,e
            or a
            if nz
                ld b,a
                do
                    outi
                while nz|wend
            endif
        exx
        ld a,CharHeight
        exx
            sub e
        exx
        ld b,a
        do
            outi
        while nz|wend
    ei
ret
WriteFG:
    di
        call SetWrite
        exx
            ld a,e
            or a
            if nz
                ld b,a
                do
                    outi
                while nz|wend
            endif
        exx
        ld hl,GroundPattern
        call AddHlA
        ld a,CharHeight
        exx
            sub e
        exx
        ld b,a
        do
            outi
        while nz|wend
    ei
ret
UpdateFortChars_: public UpdateFortChars_
    push af | push hl | push de | push bc
        ld a,(FortCharOffset_)
        or a
        if z
            ld de,4000h or Char_Fort0*CharHeight 
        else
            ld de,4000h or Char_Fort1*CharHeight
        endif
        ld a,(VdpOutPort) | ld c,a
        exx
            ld c,a
            ld a,(FortDotOffset_)
            and 7 | ld e,a
            
            ld d,6
        exx
        ld hl,FortPattern
        do
            push hl
                call WriteGF
            pop hl
            set 3,d
            call WriteGF
            res 3,d
            call AddHlE

            di
                set 5,d
                call SetWrite
                res 5,d
                exx
                    ld a,e
                exx
                or a
                if nz
                    exx
                        ld b,a
                        ld hl,GroundPattern+CharHeight
                        do
                            outi
                        while nz|wend
                    exx
                endif
                ld a,CharHeight
                exx
                    sub e
                exx
                ld b,a
                do
                    outi
                while nz|wend
            ei
            call AddHlE
            call AddDe8
            exx
                dec d
            exx
        while nz | wend

        exx
            ld a,low(FortPattern+CharHeight)
            sub e
            ld l,a
            ld a,high(FortPattern+CharHeight)
            sbc a,0
            ld h,a

            ld d,6*5
        exx
        do
            push hl
                exx
                    push hl
                exx
                call WriteFF
                exx
                    pop hl
                exx
            pop hl
            set 3,d
                call WriteFF
            res 3,d
            exx
                call AddHlA
            exx
            call AddHlE

            di
                set 5,d
                call SetWrite
                res 5,d
                exx
                    ld a,e
                exx
                or a
                if nz
                    exx
                        ld b,a
                        do
                            outi
                        while nz|wend
                    exx
                endif
                ld a,CharHeight
                exx
                    sub e
                exx
                ld b,a
                do
                    outi
                while nz|wend
            ei
            exx
                call AddHlA
            exx
            call AddHlE
            call AddDe8
            exx
                dec d
            exx
        while nz | wend

        exx
            ld d,6
        exx
        do
            exx
                push hl
            exx
            call WriteFG
            exx
                pop hl
            exx
            exx
                push hl
            exx
            set 3,d
            call WriteFG
            res 3,d
            exx
                pop hl
            exx
            set 4,d
            call WriteFG
            res 4,d
            exx
                call AddHlA
            exx

            di
                set 5,d
                call SetWrite
                res 5,d
                exx
                    ld a,e
                exx
                or a
                if nz
                    exx
                        ld b,a
                        do
                            outi
                        while nz|wend
                    exx
                endif
                ld hl,GroundPattern+CharHeight
                call AddHlA
                ld a,CharHeight
                exx
                    sub e
                exx
                ld b,a
                do
                    outi
                while nz|wend
            ei
            exx
                call AddHlA
            exx
            call AddDe8
            exx
                dec d
            exx
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push af | push hl | push de | push bc
        ld d,a
        ld a,e
        ; cp -(16+2)
        ; jr c,exit
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
        ld a,(NextPage) ;| xor 4
        or 40h
        add a,h | ld h,a
        ld de,-VramWidth*(16+2) | add hl,de

        ld a,(VdpOutPort) | ld c,a

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
                    inc c
                    out (c),l
                    out (c),h
                    dec c
                    ld b,6
                    do
                        out (c),d
                        inc d
                    dwnz
                ei
            else
                ld a,d
                add a,6
                ld d,a
            endif
            exx
                inc c
            exx
            ld a,l | add a,VramWidth | ld l,a
            ld a,h | adc a,0 | ld h,a

            dec e
        while nz | wend
        exit:
    pop bc | pop de | pop hl | pop af
ret
