include 'BIOS.inc'
include 'Vram.inc'
include 'Chars.inc'

TileSize equ 4
GroundHeight equ 24+4

Char_Count equ (Char_End-Char_Terrain)/2

ext charOffset_, dotOffset_, Ground_, VVram_
ext TerrainPattern_

; void RollChar();
cseg
RollChar_: public RollChar_
    push af | push hl | push de | push bc
        ld a,(dotOffset_)
        exx
            ld e,a
        exx
        ld a,(VdpOutPort)
        exx
            ld d,a
        exx

        ld a,(charOffset_)
        add a,Char_Terrain
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        set 6,h
        ex de,hl

        ld hl,TerrainPattern_
        ld c,Char_Count
        do
            ld b,3
            do
                push bc
                    exx
                        ld a,d
                    exx
                    ld c,a
                    push hl
                        set 5,d
                        di
                            inc c
                                out (c),e
                                out (c),d
                            dec c
                            exx
                                ld a,e
                            exx
                            or a
                            if nz
                                ld b,a
                                ld a,(hl)
                                do
                                    out (c),a
                                dwnz
                            endif
                            inc hl
                            exx
                                ld a,8
                                sub e
                            exx
                            ld b,a
                            ld a,(hl)
                            do
                                out (c),a
                            dwnz
                            inc hl
                        ei
                        res 5,d
                    
                        push de
                            exx
                                ld a,7
                                sub e
                            exx
                            ld e,a
                            ld d,0
                            add hl,de
                        pop de
                        di
                            inc c
                                out (c),e
                                out (c),d
                            dec c
                            ld b,8
                            do
                                ld a,(hl)
                                inc hl
                                out (c),a
                            dwnz
                        ei
                    pop hl
                    ld a,d
                    add a,8
                    ld d,a
                pop bc
            dwnz
            ld a,d
            add a,-8*3
            ld d,a
            push bc
                ld bc,2+15
                add hl,bc
                ex de,hl
                    ld bc,8
                    add hl,bc
                ex de,hl
            pop bc
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void RollDown();
cseg
RollDown_: public RollDown_
    push af | push hl | push de | push bc
        ld hl, Ground_+VVramWidth*GroundHeight
        ld de, Ground_+VVramWidth*(GroundHeight-1)
        ld bc, VVramWidth*(GroundHeight-1)
        do
            dec de
            ld a,(de)
            dec hl
            ld (hl),a
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
