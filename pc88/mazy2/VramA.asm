include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern

cseg
ToRam: public ToRam
	;64K RAM
    push af
        ld a,(0e6c2h)
        or 2
        out (31h),a
        ld (0e6c2h),a
    pop af
ret

ToRom: public ToRom
	;N88 ROM
    push af
        ld a,(0e6c2h)
        and not 2
        out (31h),a
        ld (0e6c2h),a
    pop af
ret

PatternAddress: public PatternAddress
    push de
        ld l,a
        ld h,0
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,hl ;*48
        ld de,PatternRam
        add hl,de
    pop de
ret


cseg
InitVram0: public InitVram0
    xor a
    ld de,MonoPattern
    do
        ld b,(hl)
        inc b | dec b
    while nz
        inc hl
        ld c,(hl)
        inc hl
        push af | push hl | push bc
            call MakePatternMono
        pop bc | pop hl | pop af
        add a,b
    wend

    ld hl,PatternRam+PatternSize*Char_Color
    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakePatternColor
ret


MakePatternMono: public MakePatternMono
    push de
        ld l,a | ld h,0
        ld e,l | ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,hl ;*48
        ld de,PatternRam
        add hl,de
    pop de
    di
        push hl | exx | pop hl | exx
        call ToRam
        ld a,c ; color
        do
            push af
                exx
                    ld d,a
                exx
                ld c,3
                do
                    push de
                        ld h,8
                        do
                            ld a,(de)
                            exx
                                ld e,0
                                bit 0,d
                                if nz
                                    or e
                                    ld e,a
                                endif
                            exx
                            ld a,(de)
                            exx
                                bit 4,d
                                if nz
                                    cpl
                                    or e
                                    ld e,a
                                endif
                                ld a,e
                                ld e,2
                                do
                                    ld bc,400h
                                    do
                                        sla c
                                        sla c
                                        rlca
                                        if c
                                            set 0,c
                                            set 1,c
                                        endif
                                    dwnz
                                    ld (hl),c
                                    inc hl
                                    dec e
                                while nz | wend
                            exx
                            inc de
                            dec h
                        while nz | wend
                        exx
                            srl d
                        exx
                    pop de
                    dec c
                while nz | wend
                ex de,hl
                    ld de,8
                    add hl,de
                ex de,hl
            pop af
        dwnz    
        call ToRom
    ei
ret


MakePatternColor: public MakePatternColor
    di
        push hl | exx | pop hl | exx
        call ToRam
        do
            ld b,24
            do
                ld a,(de)
                inc de
                exx
                    ld e,2
                    do
                        ld bc,400h
                        do
                            sla c
                            sla c
                            rlca
                            if c
                                set 0,c
                                set 1,c
                            endif
                        dwnz
                        ld (hl),c
                        inc hl
                        dec e
                    while nz | wend
                exx
            dwnz
            dec c
        while nz | wend
        call ToRom
    ei
ret
