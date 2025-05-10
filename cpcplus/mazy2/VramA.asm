include "Vram.inc"
include "Chars.inc"

ext MonoPattern,ColorPattern

CharPatternSize equ CharHeight*2


dseg
CharPatternRam: public CharPatternRam
    defs CharPatternSize*Char_End

cseg
ColorTable:
defb 64,07h ; Ascii
defb 16,05h ; Logo
defb 0

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
MakeMono:
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
            dec c
        while nz | wend
    pop hl
ret
MakeColor:
    do
        ld b,CharPatternSize
        do
            ld a,(de)
            inc de
            exx
                ld (hl),a | inc hl
            exx
        dwnz
        dec c
    while nz | wend
ret
InitVram: public InitVram
    exx
        ld hl,CharPatternRam
    exx
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld a,(hl) | inc hl ; count
        or a
    while nz
        ld c,a ; count
        ld a,(hl) | inc hl ; color
        call MakeMono
    wend

    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakeColor
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
                ld de,CharPatternRam
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


; ptr<byte> VramPtr(byte x, byte y);
cseg
VramPtr_: public VramPtr_
    push af | push bc
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,e ;*5
        ld l,a
        ld h,0
        add hl,hl ;*10
        add hl,hl ;*20
        add hl,hl ;*40
        ld b,0
        add hl,bc
        add hl,hl ; VramStep
        ld bc,Vram | add hl,bc
    pop bc | pop af
ret
