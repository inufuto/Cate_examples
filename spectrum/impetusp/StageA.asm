include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Ground_, TopRow_, yMod_
ext pCurrentRow_
ext Tiles_
; ext PollVSync_

MapWidth equ 8
TileSize equ 4
GroundHeight equ (VVramHeight+TileSize-1)/TileSize+1

; void DrawGround();
cseg
DrawGround_: public DrawGround_
    push af | push hl | push de | push bc
        exx
            ld c,0 ; yPos
        exx
        ld hl,VVram_
        ld a,(yMod_)
        and 3
        if nz
            ld de,-VVramWidth
            do
                add hl,de
                exx
                    dec c
                exx
                dec a
            while nz | wend
        endif
        ex de,hl
        ld hl,Ground_
        do
            exx
                ld b,MapWidth
            exx
            do
                ld a,(hl) | inc hl
                push hl
                    ld l,a | ld h,0
                    add hl,hl ;*2
                    add hl,hl ;*4
                    add hl,hl ;*8
                    add hl,hl ;*16
                    ld a,l | add a,low(Tiles_) | ld l,a
                    ld a,h | adc a,high(Tiles_) | ld h,a

                    ld c,TileSize
                    do
                        exx
                            ld a,c
                        exx
                        cp VVramHeight
                        if c
                            ld b,TileSize
                            do
                                ld a,(hl) | inc hl
                                ld (de),a | inc de
                            dwnz
                            ld a,e | add a,VVramWidth-TileSize | ld e,a
                            ld a,d | adc a,0 | ld d,a
                        else
                            inc hl | inc hl | inc hl | inc hl
                            ld a,e | add a,VVramWidth | ld e,a
                            ld a,d | adc a,0 | ld d,a
                        endif
                        exx
                            inc c
                        exx
                        dec c
                    while nz | wend
                    ld a,e | sub VVramWidth*TileSize-TileSize | ld e,a
                    ld a,d | sbc a,0 | ld d,a
                    exx
                        ld a,c
                        sub TileSize
                        ld c,a
                    exx
                pop hl
                ; call PollVSync_
                exx
                    dec b
                exx
            while nz | wend
            ld a,e | add a,VVramWidth*TileSize-TileSize*MapWidth | ld e,a
            ld a,d | adc a,0 | ld d,a

            exx
                ld a,c
                add a,TileSize
                ld c,a
            exx
            cp VVramHeight
        while m | wend
    pop bc | pop de | pop hl | pop af
ret


; void RollDown();
cseg
RollDown_: public RollDown_
    push hl | push de | push bc
        ld hl,Ground_+MapWidth*GroundHeight-1-MapWidth
        ld de,Ground_+MapWidth*GroundHeight-1
        ld bc,MapWidth*(GroundHeight-1)
        lddr

        ld hl,(pCurrentRow_)
        ld de,Ground_
        ld bc,MapWidth
        ldir
    pop bc | pop de | pop hl
ret
