include "kh1000.inc"
include "Vram.inc"
include "Chars.inc"

ext WRTVRM, RDVRM, LDIRVM, FILVRM, SetVdpAddressDE, SetVdpAddressHL

Width equ 6
Height equ 6+1

ext FortPattern
ext FortY_, FortCharOffset_


; void SetFortPattern()
SetFortPattern_: public SetFortPattern_
cseg
    push af | push hl | push de | push bc
        ld a,(FortY_)
        and 3
        add a,a
        exx
            ld b,a

            ld a,(FortCharOffset_)
            add a,Char_Fort
            ld l,a
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            set 6,h

            ld e,2
        exx
        do
            ld hl,FortPattern
            di
                exx
                    call SetVdpAddressHL
                exx
                
                ld e,Width
                do
                    push de
                        exx
                            ld a,b
                        exx
                        or a
                        if nz
                            ld b,a
                            xor a
                            do
                                ld (VdpAddress),a
                            dwnz
                        endif
                        exx
                            ld a,8
                            sub b
                        exx
                        push hl
                            ld b,a
                            do
                                ld a,(hl)
                                inc hl
                                ld (VdpAddress),a
                            dwnz
                        pop hl
                        ld de,8
                        add hl,de
                    pop de
                    dec e
                while nz | wend
                                            
                ld d,Height-2
                do
                    ld e,Width
                    do
                        push de
                            exx
                                ld a,b
                            exx
                            or a
                            if nz
                                push hl
                                    ld b,a
                                    ld a,8-8*Width
                                    sub b
                                    ld e,a
                                    ld d,0ffh
                                    add hl,de
                                    do
                                        ld a,(hl)
                                        inc hl
                                        ld (VdpAddress),a
                                    dwnz
                                pop hl
                            endif
                            exx
                                ld a,8
                                sub b
                            exx
                            push hl
                                ld b,a
                                do
                                    ld a,(hl)
                                    inc hl
                                    ld (VdpAddress),a
                                dwnz
                            pop hl
                            ld de,8
                            add hl,de
                        pop de
                        dec e
                    while nz | wend
                    dec d
                while nz | wend
                
                ld e,Width
                do
                    push de
                        exx
                            ld a,b
                        exx
                        or a
                        if nz
                            push hl
                                ld b,a
                                ld a,8-8*Width
                                sub b
                                ld e,a
                                ld d,0ffh
                                add hl,de
                                do
                                    ld a,(hl)
                                    inc hl
                                    ld (VdpAddress),a
                                dwnz
                            pop hl
                        endif
                        exx
                            ld a,8
                            sub b
                        exx
                        push hl
                            ld b,a
                            xor a
                            do
                                ld (VdpAddress),a
                            dwnz
                        pop hl
                        ld de,8
                        add hl,de
                    pop de
                    dec e
                while nz | wend
            ei            
            exx
                ld a,h
                add a,8
                ld h,a
                dec e
            exx
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
