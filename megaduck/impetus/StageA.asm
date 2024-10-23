include "Vram.inc"
include "Chars.inc"

TileSize equ 4
GroundHeight equ WindowHeight+TileSize

Char_Count equ (Char_Fort-Char_Terrain)/2

ext WaitModeN1
ext charOffset_, dotOffset_, Ground_, VVram_
ext TerrainPattern

; void RollChar();
cseg
RollChar_: public RollChar_
    push af | push hl | push de | push bc
        ld a,(dotOffset_)
        cpl | inc a
        add a,7
        ld l,a | ld h,0
        add hl,hl ;*2
        ld bc,TerrainPattern | add hl,bc
        ld e,l | ld d,h

        ld a,(charOffset_)
        add a,Char_Terrain
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        ld bc,CharRam0 | add hl,bc

        ld c,Char_Count
        do
            ld b,16
            do
                push bc
                    ld a,(de) | inc de
                    ld c,a
                    call WaitModeN1
                    ld (hl),c | inc hl
                pop bc
                dec b
            while nz|wend
            ld a,e | add a,15*2-16 | ld e,a
            ld a,d | adc a,0 | ld d,a
            ld a,l
            or a,a
            if z
                ld a,h
                cp a,high(CharRam0)+8
                if z
                    ld h,high CharRam1
                endif
            endif
            dec c
        while nz|wend
    pop bc | pop de | pop hl | pop af
ret


; void RollDown();
cseg
RollDown_: public RollDown_
    push af | push hl | push de | push bc
        ld hl, Ground_+WindowWidth*GroundHeight
        ld de, Ground_+WindowWidth*(GroundHeight-1)
        ld bc, WindowWidth*(GroundHeight-1)
        do
            dec de | ld a,(de)
            dec hl | ld (hl),a
            dec bc
            ld a,c | or a,b
        while nz|wend
    pop bc | pop de | pop hl | pop af
ret
