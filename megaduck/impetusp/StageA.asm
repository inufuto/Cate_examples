include "MegaDuck.inc"
include "Vram.inc"
include "Chars.inc"

ext WaitModeN1
ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext TerrainPattern
ext NextPage, TerrainCharOffset

MapWidth equ 5
TileSize equ 4
GroundHeight equ (WindowHeight+TileSize-1)/TileSize+1

dseg
yPos:
    defb 0

; void UpdateGroundChars(bool next);
cseg
UpdateGroundChars_: public UpdateGroundChars_
    push af | push hl | push de | push bc
        or a,a
        ld a,(TerrainCharOffset)
        if z
            xor a,TerrainCharCount
        endif
        or a,a
        if z
            ld hl,CharRam0+Char_Terrain0*PatternSize 
        else
            ld hl,CharRam0+Char_Terrain1*PatternSize
        endif

        ld a,(DotOffset_)
        and a,7
        add a,a
        ld e,a
        ld a,low (TerrainPattern+PatternSize) | sub a,e | ld e,a
        ld a,high (TerrainPattern+PatternSize) | sbc a,0 | ld d,a

        ld c,Char_Terrain1-Char_Terrain0
        do
            push bc
                di
                    ld b,PatternSize
                    do
                        ld a,(de) | inc de
                        ld c,a
                        call WaitModeN1
                        ld a,c
                        ld (hl+),a
                    dec b | while nz | wend
                ei
            pop bc
            ld a,l | or a,a
            if z
                ld a,h
                cp a,high(CharRam0)+8
                if z
                    ld h,high CharRam1
                endif
            endif

            ld a,e | add a,PatternSize | ld e,a
            ld a,d | adc a,0 | ld d,a
        dec c | while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawGround();
cseg
DrawGround_: public DrawGround_
    ; ret
    push af | push hl | push de | push bc
        xor a,a | ld (yPos),a

                                                    _deb: public _deb
        ld a,(NextPage) | ld h,a
        ld l,0

        ld a,(yMod_)
        and a,3
        ld c,a
        if nz
            ld de,-VramRowSize
            do
                add hl,de
                ld a,(yPos) | dec a | ld (yPos),a
                dec c
            while nz | wend
        endif
        ld e,l | ld d,h

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
                    ld b,TileSize
                    do
                        ld a,(yPos)
                        cp a,VramHeight
                        if c
                            push bc
                                ld a,(TerrainCharOffset) | ld c,a
                                di
                                    ld b,TileSize
                                    do
                                        ld a,(hl+)
                                        add a,c
                                        push bc
                                            ld c,a
                                            call WaitModeN1
                                            ld a,c
                                            ld (de),a | inc de
                                        pop bc
                                    dec b | while nz | wend
                                ei
                            pop bc
                            ld a,e | add a,VramRowSize-TileSize | ld e,a
                            ld a,d | adc a,0 | ld d,a
                        else
                            inc hl | inc hl | inc hl | inc hl
                            ld a,e | add a,VramRowSize | ld e,a
                            ld a,d | adc a,0 | ld d,a
                        endif
                        ld a,(yPos) | inc a | ld (yPos),a
                    dec b | while nz | wend
                    ld a,e | sub a,low(VramRowSize*TileSize-TileSize) | ld e,a
                    ld a,d | sbc a,high(VramRowSize*TileSize-TileSize) | ld d,a
                    ld a,(yPos) | sub a,TileSize | ld (yPos),a
                pop hl
                dec c
            while nz | wend
            ld a,e | add a,low(VramRowSize*TileSize-TileSize*MapWidth) | ld e,a
            ld a,d | adc a,high(VramRowSize*TileSize-TileSize*MapWidth) | ld d,a
            ld a,(yPos) | add a,TileSize | ld (yPos),a
            cp a,VramHeight
        while c | wend
    pop bc | pop de | pop hl | pop af
ret


; void RollDown();
cseg
RollDown_: public RollDown_
    push af | push hl | push de | push bc
        ld hl,Ground_+MapWidth*GroundHeight-MapWidth
        ld de,Ground_+MapWidth*GroundHeight
        ld bc,MapWidth*(GroundHeight-1)
        do
            dec hl
            dec de
            ld a,(hl)
            ld (de),a
            dec bc
            ld a,c | or a,b
        while nz | wend

        ld a,(pCurrentRow_) | ld l,a
        ld a,(pCurrentRow_+1) | ld h,a
        ld de,Ground_
        ld bc,MapWidth
        do
            ld a,(hl+)
            ld (de),a | inc de
            dec bc
            ld a,c | or a,b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
