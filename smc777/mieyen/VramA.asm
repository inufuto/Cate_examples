include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext MonoPattern, ColorPattern

CharVram equ 0000h
AttrVram equ 0800h

dseg
Backup:
    defs VVramWidth*VVramHeight
PatternRam:
    defs PatternSize*Char_Color

cseg
ColorTable:
defb 64, 7h ; Ascii
defb 16, 3h ; Logo
defb 16, 1h ; Wall
defb 32,0eh ; Monster
defb 4,6h ; Dot
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
ret

MakePatternMono:
    push de
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld de,PatternRam
        add hl,de
    pop de
    push hl | exx | pop hl | exx
    ld a,c
    exx
        ld e,a
        and 0fh
        ld d,a
        ld a,e
        srl a | srl a | srl a | srl a
        ld e,a
    exx
    do
        ld c,CharHeight
        do
            ld a,(de)
            ld l,a
            inc de
            ld h,8
            xor a
            do
                sla l
                if c
                    exx
                        or d
                    exx
                else
                    exx
                        or e
                    exx
                endif
                bit 0,h
                if nz
                    exx
                        ld (hl),a
                        inc hl
                        xor a
                    exx
                else
                    rlca | rlca | rlca | rlca
                endif
                dec h
            while nz | wend
            dec c
        while nz | wend
    dwnz
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
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld de,8000h
        do
            ld b,l
            ld c,h
            xor a
            out (c),a
            inc hl
            dec de
            ld a,e
            or d
        while nz | wend

        ld hl,CharVram
        ld de,0800h
        do
            ld b,l
            ld c,h
            xor a
            out (c),a
            inc hl
            dec de
            ld a,e
            or d
        while nz | wend

        ld hl,AttrVram
        ld de,0800h
        do
            ld b,l
            ld c,h
            ld a,1
            out (c),a
            inc hl
            dec de
            ld a,e
            or d
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        ex de,hl
            push de
                ld a,l
                sub Char_Color
                if c
                    ld de, PatternRam
                else
                    ld l,a
                    ld de, ColorPattern
                endif
                ld h,0
                add hl,hl ;*2
                add hl,hl ;*4
                add hl,hl ;*8
                add hl,hl ;*16
                add hl,hl ;*32
                add hl,de
            pop de
        ex de,hl
        ld c,CharHeight
        do
            ld b,VramCellSize
            do
                push bc
                    ld b,l
                    ld c,h
                    ld a,(de)
                    inc de
                    out (c),a
                pop bc
                inc hl
            dwnz
            push de
                ld de,1000H-VramCellSize
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl | inc hl | inc hl
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
                            inc hl | inc hl | inc hl | inc hl
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth*4
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
