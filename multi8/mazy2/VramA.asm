include "FixedCode.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern

dseg
Backup:
    defs VVramWidth*VVramHeight


cseg
ToRam:
    push af
        ld a,20h
        out (2ah),a
    pop af
ret
ToRom:
    push af
        xor a
        out (2ah),a
    pop af
ret


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
defb 16,7 ; Point
defb 0
InitVram: public InitVram
    xor a
    ld de,MonoPattern
    ld hl,ColorTable
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

MakePatternMono:
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
    di | call ToRam
        push hl | exx | pop hl | exx
        do
            push bc
                ld a,c
                exx
                    ld d,a
                exx
                ld c,PlaneCount
                do
                    push de
                        ld h,CharHeight
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
                    ld de,CharHeight
                    add hl,de
                ex de,hl
            pop bc
        dwnz
    call ToRom | ei
ret

MakePatternColor:
    di | call ToRam
        do
            ld b,CharHeight*PlaneCount
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
    call ToRom | ei
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        call ClearVram

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
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
        ex de,hl
        call TransPattern
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*1
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                push bc 
                    ld a,(de)
                    inc de
                    or a
                    if z
                        ld a,(hl)
                        cp Char_Wall
                        if z
                            exx
                                xor a
                                call SetWall
                            exx
                            xor a
                            ld (hl),a
                            jr VVramToVram_next
                        endif
                        xor a
                    endif
                    cp Char_Wall
                    if z
                        ld a,(hl)
                        or a
                        if z
                            exx
                                ld a,0ffh
                                call SetWall
                            exx
                            ld a,Char_Wall
                            ld (hl),a
                            jr VVramToVram_next
                        endif
                        ld a,Char_Wall
                    endif
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            push de
                                ld e,a
                                call Put_
                            pop de
                        exx
                    else
                        exx
                            inc hl
                            inc hl
                        exx
                    endif
                    VVramToVram_next:
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth*2
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret