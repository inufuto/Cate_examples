include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern

dseg
Backup:
    defs VVramWidth*VVramHeight
PatternRam: public PatternRam
    defs PatternSize*Char_End

cseg
PalleteValues:
	defb	54h, 58h, 4eh, 45h, 42h, 57h, 59h, 40h
	defb	54h, 55h, 4ch, 4dh, 52h, 53h, 4ah, 4bh
ColorTable:
defb 64,0fh ; Ascii
defb 16,02h ; Logo
defb 1,05h ; Floor
defb 2,02h ; Ladder
defb 32,0bh ; Monster
defb 16,0fh ; Point
defb 4,0eh ; Item
defb 0
defb Char_End-Char_Man; color chars
DotTable:
    defb 00h, 40h, 04h, 44h, 10h, 50h, 14h, 54h
    defb 01h, 41h, 05h, 45h, 11h, 51h, 15h, 55h
ToDot: ; (a):d
    push af | push hl | push bc
        and 0fh
        ld l,a | ld h,0
        ld bc,DotTable | add hl,bc
        ld d,(hl)
    pop bc | pop hl | pop af
ret
InitVram: public InitVram
    ld hl,PalleteValues
    ld bc,7f00h
    ld e,16
    do
        out (c),c
        ld a,(hl) | inc hl
        out (c),a
        inc c
        dec e
    while nz | wend
    out (c),c
    ld a,54h | out (c),a

    exx
        ld hl,PatternRam
    exx
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld a,(hl) | inc hl ; count
        or a
    while nz
        ld c,a ; count
        ld a,(hl) | inc hl ; color
        exx
            call ToDot
            ld e,d
            rrca | rrca | rrca | rrca
            call ToDot
        exx
        push hl
            do
                ld b,4 ; source byte count
                do
                    ld a,(de) | inc de ; source
                    exx
                        ld c,a
                    exx
                    ld l,4 ; destination byte count
                    do
                        exx
                            xor a
                            ld b,2 ; destination pixel count
                            do
                                rlca
                                sla c
                                if c
                                    or e
                                else
                                    or d
                                endif
                            dwnz
                            ld (hl),a | inc hl
                        exx
                        dec l
                    while nz | wend
                dwnz
                                    _deb: public _deb
                dec c
            while nz | wend
        pop hl
    wend
    ld c,(hl)
    do
        ld b,16
        do
            ld a,(de)
            inc de
            exx
                ld (hl),a
                inc hl
            exx
        dwnz
        dec c
    while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,0c000h
        ld de,0c001h
        ld bc,4000h-1
        ld (hl),0
        ldir

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            push de
                ld l,a
                ld h,0
                add hl,hl ;*2
                add hl,hl ;*4
                add hl,hl ;*8
                add hl,hl ;*16
                ld de,PatternRam
                add hl,de
            pop de
        ex de,hl
        ld b,8
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
            ld a,(de) | inc de
            ld (hl),a
            push bc
                ld bc,800h-1
                add hl,bc
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*0
        exx
        ld c,VVramHeight
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
                            inc hl
                            inc hl
                        exx
                    endif
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
