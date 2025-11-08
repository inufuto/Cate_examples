include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext TerrainPattern
ext NextPage, TerrainCharOffset
ext RepeatWrite

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
            ld de,4000h or Char_Terrain0*PatternSize 
        else
            ld de,4000h or Char_Terrain1*PatternSize
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
            di
                ld a,e | out (VdpPort+1),a
                ld a,d | out (VdpPort+1),a
                ld b,PatternSize
                call RepeatWrite
            ei
            call AddPatternSize
            ex de,hl
                call AddPatternSize
            ex de,hl
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
AddPatternSize:
    ld a,l | add a,PatternSize | ld l,a
    ld a,h | adc a,0 | ld h,a
ret


; void DrawGround();
cseg
DrawGround_: public DrawGround_
    push af | push hl | push de | push bc
        exx
            ld c,0 ; yPos
            ld a,(TerrainCharOffset) | ld h,a
        exx
        ld a,(NextPage)
        or 40h | ld h,a
        ld l,0
        ld a,(yMod_)
        and 3
        if nz
            ld de,-VramRowSize
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
                        cp VramHeight
                        if c
                            di
                                ld a,e | out (VdpPort+1),a
                                ld a,d | out (VdpPort+1),a

                                ld b,TileSize
                                do
                                    ld a,(hl) | inc hl
                                    exx
                                        add a,h
                                    exx
                                    out (VdpPort),a
                                    nop | nop | nop
                                    xor a
                                    out (VdpPort),a
                                dwnz
                            ei
                        else
                            inc hl | inc hl | inc hl | inc hl
                        endif
                        ld a,e | add a,VramRowSize | ld e,a
                        ld a,d | adc a,0 | ld d,a
                        exx
                            inc c
                            dec e
                        exx
                    while nz | wend
                    ld a,e | sub low(VramRowSize*TileSize-TileSize*VramStep) | ld e,a
                    ld a,d | sbc a,high(VramRowSize*TileSize-TileSize*VramStep) | ld d,a
                    exx
                        ld a,c
                        sub TileSize
                        ld c,a
                    exx
                pop hl
                dec c
            while nz | wend
            ld a,e | add a,low(VramRowSize*TileSize-TileSize*MapWidth*VramStep) | ld e,a
            ld a,d | adc a,high(VramRowSize*TileSize-TileSize*MapWidth*VramStep) | ld d,a
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
