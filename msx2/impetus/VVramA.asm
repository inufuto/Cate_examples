include "VVram.inc"
include "Vram.inc"

ext VVram_
ext Ground_, GroundY_, dotOffset_
ext Tiles_
ext Status_


TileSize equ 4
GroundWidth equ VVramWidth/TileSize
GroundHeight equ (VVramHeight+TileSize*2-1)/TileSize


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push de
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            add hl,hl ;*32
        ex de,hl
        ld l,a
        ld h,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de
ret


; void RollDown();
cseg
RollDown_: public RollDown_
    ;call PollVSync_
    push af | push hl | push de | push bc
        ld hl, Ground_+GroundWidth*GroundHeight
        ld de, Ground_+GroundWidth*(GroundHeight-1)
        ld bc, GroundWidth*(GroundHeight-1)
        do
            dec de | ld a,(de)
            dec hl | ld (hl),a
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawGround();
cseg
DrawGround_: public DrawGround_
    push af | push hl | push de | push bc
        ld hl,Tiles_
        ld a,(dotOffset_)
        or a
        if nz
            ld de,16 | add hl,de
        endif
        ld (DrawGround_tiles+1),hl

        ld hl,VVram_
        ld de,-VVramWidth
        ld a,(GroundY_)
        or a
        do | while m
            add hl,de
            inc a
        wend
        ld de,Ground_
        
        ld a,(GroundY_)
        ld c,a
        do
            ld b,GroundWidth
            do
                                _deb: public _deb
                ld a,(de) | inc de
                push de
                    exx
                        ld l,a
                        ld h,0
                        add hl,hl ;*2
                        add hl,hl ;*4
                        add hl,hl ;*8
                        add hl,hl ;*16
                        add hl,hl ;*32
                        DrawGround_tiles:
                        ld de,Tiles_
                        add hl,de
                    exx
                    push bc
                        ld e,c
                        ld c,TileSize
                        do
                            ld a,e
                            cp VVramHeight
                            if c
                                ld b,TileSize
                                do
                                    exx
                                        ld a,(hl) | inc hl
                                    exx
                                    ld (hl),a | inc hl
                                dwnz
                                push de
                                    ld de,VVramWidth-TileSize
                                    add hl,de
                                pop de
                            else
                                push de
                                    ld de,VVramWidth
                                    add hl,de
                                pop de
                                exx
                                    ld de,TileSize
                                    add hl,de
                                exx
                            endif
                            inc e
                            dec c
                        while nz | wend
                        push de
                            ld de,TileSize-VVramWidth*TileSize
                            add hl,de
                        pop de
                    pop bc
                pop de
            dwnz
            push de
                ld de,VVramWidth*TileSize-VVramWidth
                add hl,de
            pop de
            ld a,c
            add a,TileSize
            ld c,a
            cp VVramHeight
        while c | wend
    pop bc | pop de | pop hl | pop af
ret


; void StatusToVVram();
cseg
StatusToVVram_: public StatusToVVram_
    push af | push hl | push de | push bc
        ld hl,Status_
        ld de,VVram_
        ld bc,VVramWidth*StatusHeight
        do
            ld a,(hl) | inc hl
            or a
            if nz
                ld (de),a
            endif
            inc de
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
