include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext TerrainPattern
ext TerrainCharOffset
ext VVram_

MapWidth equ 8
TileSize equ 4
GroundHeight equ VVramHeight/TileSize+1


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
            ld de,CharacterPatternTable+Char_Terrain0*PatternSize 
        else
            ld de,CharacterPatternTable+Char_Terrain1*PatternSize
        endif

        ld a,(DotOffset_)
        and 7
        add a,a
        add a,a
        ld l,a
        ld a,low (TerrainPattern+PatternSize) | sub l | ld l,a
        ld a,high (TerrainPattern+PatternSize) | sbc a,0 | ld h,a

        ld c,Char_Terrain1-Char_Terrain0
        do
            ld b,PatternSize
            do
                ld a,(hl) | inc hl
                ld (de),a | inc de
            dwnz
            ld a,l | add a,PatternSize | ld l,a
            ld a,h | adc a,0 | ld h,a

            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawGround();
cseg
DrawGround_: public DrawGround_
    push af | push hl | push de | push bc
        exx
            ld c,0 ; yPos
            ld a,(TerrainCharOffset) | ld h,a
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
            ld c,MapWidth
            do
                ld a,(hl) | inc hl
                push hl
                    push de
                        ld l,a | ld h,0
                        add hl,hl ;*2
                        add hl,hl ;*4
                        add hl,hl ;*8
                        add hl,hl ;*16
                        ld de,Tiles_ | add hl,de
                    pop de
                    exx
                        ld e,TileSize
                    exx
                    do
                        exx
                            ld a,c
                        exx
                        cp VVramHeight
                        if c
                            ld b,TileSize
                            do
                                ld a,(hl) | inc hl
                                exx
                                    add a,h
                                exx
                                ld (de),a | inc de
                            dwnz
                        else
                            inc hl | inc hl | inc hl | inc hl
                            inc de | inc de | inc de | inc de
                        endif
                        ld a,e | add a,VVramWidth-TileSize | ld e,a
                        ld a,d | adc a,0 | ld d,a
                        exx
                            inc c
                            dec e
                        exx
                    while nz | wend
                    ld a,e | sub low(VVramWidth*TileSize-TileSize) | ld e,a
                    ld a,d | sbc a,high(VVramWidth*TileSize-TileSize) | ld d,a
                    exx
                        ld a,c
                        sub TileSize
                        ld c,a
                    exx
                pop hl
                dec c
            while nz | wend
            ld a,e | add a,low(VVramWidth*TileSize-TileSize*MapWidth) | ld e,a
            ld a,d | adc a,high(VVramWidth*TileSize-TileSize*MapWidth) | ld d,a
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
