include "kh1000.inc"
include "Vram.inc"
include "Chars.inc"

ext EnableNmi, DisableNmi
ext WRTVRM, RDVRM, LDIRVM, FILVRM, SetVdpAddressDE, SetVdpAddressHL
ext NextPage_

TileSize equ 4
GroundHeight equ VramHeight+TileSize

Char_Count equ (Char_End-Char_Terrain)/2

ext charOffset_, dotOffset_, Ground_, VVram_
ext TerrainPattern_

; void RollChar();
cseg
RollChar_: public RollChar_
    push af | push hl | push de | push bc
        ld a,(dotOffset_)
        add a,a
        exx
            ld e,a
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
                    push hl
                        set 5,d
                        di
                            call SetVdpAddressDE
                            exx
                                ld a,e
                            exx
                            or a
                            if nz
                                ld b,a
                                ld a,(hl)
                                do
                                    ld (VdpAddress),a
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
                                ld (VdpAddress),a
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
                            call SetVdpAddressDE
                            ld b,8
                            do
                                ld a,(hl)
                                inc hl
                                ld (VdpAddress),a
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
        ld hl, Ground_+VramWidth*GroundHeight
        ld de, Ground_+VramWidth*(GroundHeight-1)
        ld bc, VramWidth*(GroundHeight-1)
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


; void GroundToVram();
cseg
GroundToVram_: public GroundToVram_
    push af | push hl | push de | push bc
        ld a,(charOffset_)
        exx
            ld e,a
        exx
        ld hl,Ground_+VramWidth*4
        ld de,(NextPage_)
        ld c,3
        do
            di
                call SetVdpAddressDE
                ld b,0
                do
                    ld a,(hl) | inc hl
                    exx
                        add a,e
                    exx
                    ld (VdpAddress),a
                dwnz
            ei
            inc d
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret