include "Vram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext TerrainPattern
ext TerrainCharOffset
ext NextPage_

TerrainCharCount equ Char_Terrain1-Char_Terrain0
MapWidth equ 8
TileSize equ 4
GroundHeight equ VramHeight/TileSize+1


; void UpdateGroundChars(bool next);
cseg
UpdateGroundChars_: public UpdateGroundChars_
    push af | push hl | push de | push bc
        or a
        ld a,(TerrainCharOffset)
        if z
            xor TerrainCharCount
        endif
        or a
        if z
            ld de,PCGAddress+800h+CharHeight*Char_Terrain0
        else
            ld de,PCGAddress+800h+CharHeight*Char_Terrain1
        endif

        ld a,(DotOffset_) | add a,a | and 7 | ld l,a
        ld a,low (TerrainPattern+CharHeight) | sub l | ld l,a
        ld a,high (TerrainPattern+CharHeight) | sbc a,0 | ld h,a

        exx
            ld e,TerrainCharCount
        exx
        do
            ld c,TPlaneCount
            do
                ld b,CharHeight
                do
                    ld a,(hl) | inc hl
                    ld (de),a | inc de
                dwnz
                ld a,l | add a,CharHeight | ld l,a
                ld a,h | adc a,0 | ld h,a

                ld a,e | add a,low(800h-CharHeight) | ld e,a
                ld a,d | adc a,high(800h-CharHeight) | ld d,a

                dec c
            while nz | wend
            ld a,e | sub low(1800h-CharHeight) | ld e,a
            ld a,d | sbc a,high(1800h-CharHeight) | ld d,a
            exx
                dec e
            exx
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawGround();
cseg
DrawGround_: public DrawGround_
    push af | push hl | push de | push bc
        call NextPage_
        exx
            ld c,0 ; yPos
            ld a,(TerrainCharOffset) | ld h,a ; charOffset
        exx
        ld a,(yMod_)
        and 3
        if nz
            ld de,-VramWidth
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
                        cp VramHeight
                        if c
                            ld b,TileSize
                            do
                                ld a,(hl) | inc hl
                                exx
                                    add a,h
                                exx
                                ld (de),a | inc de
                            dwnz
                            ld a,e | add a,VramWidth-TileSize | ld e,a
                            ld a,d | adc a,0 | ld d,a
                        else
                            inc hl | inc hl | inc hl | inc hl
                            ld a,e | add a,VramWidth | ld e,a
                            ld a,d | adc a,0 | ld d,a
                        endif
                        exx
                            inc c
                        exx
                        dec c
                    while nz | wend
                    ld a,e | sub VramWidth*TileSize-TileSize | ld e,a
                    ld a,d | sbc a,0 | ld d,a
                    exx
                        ld a,c
                        sub TileSize
                        ld c,a
                    exx
                pop hl
                exx
                    dec b
                exx
            while nz | wend
            ld a,e | add a,VramWidth*TileSize-TileSize*MapWidth | ld e,a
            ld a,d | adc a,0 | ld d,a

            exx
                ld a,c
                add a,TileSize
                ld c,a
            exx
            cp VramHeight
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
