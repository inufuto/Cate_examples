include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext LinePattern

cseg
PaletteValues:
defb	00h, 00h, 61h, 00h, 55h, 06h, 00h, 07h
defb	55h, 05h, 77h, 07h, 77h, 03h, 77h, 07h
defb	70h, 07h, 72h, 04h, 41h, 02h, 63h, 05h
defb	27h, 05h, 03h, 03h, 30h, 03h, 33h, 03h
ColorTable:
defb 64, 05h ; Ascii
defb 16, 0bh ; Logo
defb 2, 0ah ; Wall
defb 1, 04h ; HardWall
defb 2, 08h ; Meter
defb 0

cseg
InitVram: public InitVram
    xor a | ld (BDRCLR),a
    call CHGCLR

    ld a,5 | call CHGMOD
    ld bc,0009h | call WRTVDP

    ld hl,PaletteValues
    ld d,0
    ld b,16
    do
        ld a,(hl) | inc hl
        ld e,(hl) | inc hl
        ld ix,SETPLT | call EXTROM
        inc d
    dwnz

    ld bc,010eh | call WRTVDP
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
        do
            call MakePatternMono
            inc a
        dwnz
        add a,b
    wend

    ld de,ColorPattern
    do
        call MakePatternColor
        inc a
        cp Char_End
    while c | wend
ret

ToPatternAddress: ; a->hl
    push de
        ld l,a
        and 1fh
        add a,a ;*2    
        add a,a ;*4
        ld e,a | ld d,0
        ld a,l
        and 0e0h
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        add hl,de
        ld de,Vram_Pattern | add hl,de
    pop de
ret

MakePatternMono:
    push af | push hl | push bc
        call ToPatternAddress
        ld a,c
        exx
            ld d,a
            and 0fh
            ld e,a
            srl d | srl d | srl d | srl d
        exx
        ld c,CharHeight
        do
            ld a,(de) | inc de
            push de
                ld e,a
                ld b,VramStep
                do
                    ld d,2
                    do
                        exx
                            sla c | sla c | sla c | sla c
                        exx
                        sla e
                        if c
                            exx
                                ld a,c
                                or e
                                ld c,a
                            exx
                        else
                            exx
                                ld a,c
                                or d
                                ld c,a
                            exx
                        endif
                        dec d
                    while nz | wend
                    exx
                        ld a,c
                    exx
                    call NWRVRM | inc hl
                dwnz
                ld de,VramWidth-VramStep
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop hl | pop af
ret

MakePatternColor:
    push af | push hl | push bc
        call ToPatternAddress
        ld c,CharHeight
        do
            ld b,VramStep
            do
                ld a,(de) | inc de
                call NWRVRM | inc hl
            dwnz
            push de
                ld de,VramWidth-VramStep
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop hl | pop af
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram_PatternName
        ld bc,VramRowSize*VramHeight
        xor a
        call FILVRM
    pop bc | pop hl | pop af
ret


; word VramAddress(byte x, byte y);
VramAddress_: public VramAddress_
    push af
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        ld l,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        ld h,a
    pop af
ret

VdpStatus: ;s#b
    push bc
        ld a,(VdpOutPort) | ld c,a
        inc c
        ld b,c
        out (c),a
        ld a,15 or 80h
        out (c),a
        ld a,(VdpInPort) | ld c,a
        inc c
        in a,(c)
    pop bc
ret

WaitVdp:
    push bc
        do
            di
                ld a,(VdpOutPort) | ld c,a
                inc c
                ld b,c
                ld a,2 | out (c),a
                ld a,15 or 80h | out (c),a
                ld a,(VdpInPort) | ld c,a
                inc c
                in a,(c)
                push af
                    ld c,b
                    xor a | out (c),a
                    ld a,15 or 80h | out (c),a
                pop af
            ei
            and 1
        while nz | wend
    pop bc
ret

Put: ; (hl,a)
    push de | push bc
        ld e,a
        rrca | rrca
        and 038h
        add a,192
        ld d,a
        ld a,e
        rlca | rlca | rlca
        and 0f8h
        ld e,a
        call WaitVdp
        di
            ld a,(VdpOutPort) | ld c,a
            inc c
            ld a,32 | out (c),a
            ld a,17 or 80h | out (c),a
            inc c | inc c
            xor a
            out (c),e | out (c),a ; sx
            out (c),d | out (c),a ; sy
            out (c),l | out (c),a ; dx
            out (c),h | out (c),a ; dy
            ld b,8
            out (c),b | out (c),a ; nx
            out (c),b | out (c),a ; ny
            out (c),a | out (c),a ; arg
            ld a,0d0h | out (c),a ; command
        ei
    pop bc | pop de
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af
        ld a,e
        call Put
        ld a,l | add a,8 | ld l,a
        ld a,h | adc a,0 | ld h,a
    pop af 
ret
