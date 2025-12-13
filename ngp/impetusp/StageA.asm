include "ngp.inc"
include "Vram.inc"
include "Chars.inc"

ext WaitModeN1
ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext Put_
ext VScroll, BackVram

MapWidth equ 5
TileSize equ 4
GroundHeight equ (WindowHeight+TileSize-1)/TileSize+1

; void DrawGround();
cseg
DrawGround_: public DrawGround_
    push wa | push hl | push de | push bc | push ix | push iy
        ld ix,Ground_
        ld iy,BackVram
        ld c,GroundHeight
        do
            ld b,MapWidth
            do
                ld a,(xix+)
                xor w,w
                add wa,wa ;*2
                add wa,wa ;*4
                add wa,wa ;*8
                add wa,wa ;*16
                add wa,Tiles_
                ld hl,wa
                ld e,TileSize
                do
                    ld d,TileSize
                    do
                        push c
                            ld c,(xhl+)
                            ld wa,iy
                            call Put_
                            ld iy,wa
                        pop c
                    dwnz d
                    add xiy,VramRowSize-TileSize*VramStep
                dwnz e
                add xiy,TileSize*VramStep-VramRowSize*TileSize
            dwnz b
            add xiy,VramRowSize*TileSize-TileSize*MapWidth*VramStep
        dwnz c
    pop iy | pop ix | pop bc | pop de | pop hl | pop wa
ret


; void RollDown();
cseg
RollDown_: public RollDown_
    push xhl | push xde | push bc
        ld hl,Ground_+MapWidth*GroundHeight-1-MapWidth
        ld de,Ground_+MapWidth*GroundHeight-1
        ld bc,MapWidth*(GroundHeight-1)
        lddr

        ld hl,(pCurrentRow_)
        ld de,Ground_
        ld bc,MapWidth
        ldir
    pop bc | pop xde | pop xhl
ret


; void UpdateOffset();
cseg
UpdateOffset_: public UpdateOffset_
    push wa
        ld a,(yMod_)
        inc 1,a
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        ld w,(DotOffset_)
        sub a,w
        ld (VScroll),a
    pop wa
ret
