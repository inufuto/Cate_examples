include "BIOS.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext WaitVdp, Put_
ext FighterX_, FighterY_

RaderTop equ 12;
RaderLeft equ VVramWidth


; void DrawFortRader(byte x, byte y, bool visible);
cseg
DrawFortRader_: public DrawFortRader_
    push af | push hl | push de
        rrca
        and 0f8h
        add a,RaderLeft*8
        ld l,a

        ld a,e
        rrca
        and 0f8h
        add a,RaderTop*8
        ld h,a

        ld a,Char_Map
        add a,c
        ld e,a

        call Put_
    pop de | pop hl | pop af
ret


; void DrawFighterOnRader();
cseg
DrawFighterOnRader_: public DrawFighterOnRader_
    push af | push hl | push de | push bc
        ld a,(FighterX_)
        srl a | dec a
        add a,RaderLeft*8
        ld h,a

        ld a,(FighterY_)
        srl a | dec a
        add a,RaderTop*8
        ld l,a
                            ; ld hl,0c000h
        ld b,0
        do
            call WaitVdp
            ld a,(VdpOutPort) | ld c,a
            inc c
            ld de,206h
            di
                                    _deb: public _deb
                ld a,36 | out (c),a
                ld a,17 or 80h | out (c),a
                inc c | inc c
                xor a
                out (c),h | out (c),a ; dx
                out (c),l | out (c),b ; dy
                xor a
                out (c),d | out (c),a ; nx
                out (c),d | out (c),a ; ny
                out (c),e | out (c),a ; arg
                ld a,83h | out (c),a ; command
            ei
            inc b
            ld a,b | cp 2
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
