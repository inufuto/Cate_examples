include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext TerrainPattern
ext NextPage, TerrainCharOffset
ext DisableNmi, EnableNmi

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
            ld de,4000h or Char_Terrain0*CharHeight 
        else
            ld de,4000h or Char_Terrain1*CharHeight
        endif
        
        ld c,VdpPort
        
        ld a,(DotOffset_) | and 7 | ld l,a
        ld a,low (TerrainPattern+CharHeight) | sub l | ld l,a
        ld a,high (TerrainPattern+CharHeight) | sbc a,0 | ld h,a

        exx
            ld e,Char_Terrain1-Char_Terrain0
        exx
        do
            call DisableNmi
                inc c
                out (c),e
                out (c),d
                dec c
                ld b,CharHeight
                do
                    outi
                while nz|wend
            call EnableNmi
            dec hl | dec hl | dec hl | dec hl | dec hl | dec hl | dec hl | dec hl
            ld a,d | or 08h
            call DisableNmi
                inc c
                out (c),e
                out (c),a
                dec c
                ld b,CharHeight
                do
                    outi
                while nz|wend
            call EnableNmi
            dec hl | dec hl | dec hl | dec hl | dec hl | dec hl | dec hl | dec hl
            ld a,d | or 10h
            call DisableNmi
                inc c
                out (c),e
                out (c),a
                dec c
                ld b,CharHeight
                do
                    outi
                while nz|wend
            call EnableNmi
            inc hl | inc hl | inc hl | inc hl | inc hl | inc hl | inc hl | inc hl

            ld a,d | or 20h
            call DisableNmi
                inc c
                out (c),e
                out (c),a
                dec c
                ld b,CharHeight
                do
                    outi
                while nz|wend
            call EnableNmi
            inc hl | inc hl | inc hl | inc hl | inc hl | inc hl | inc hl | inc hl
            inc de | inc de | inc de | inc de | inc de | inc de | inc de | inc de
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
        ld c,VdpPort

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
                            call DisableNmi
                                inc c
                                out (c),e
                                out (c),d
                                dec c
                                exx
                                    ld d,TileSize
                                exx
                                do
                                    ld a,(hl) | inc hl
                                    exx
                                        add a,h
                                    exx
                                    out (c),a
                                    exx
                                        dec d
                                    exx
                                while nz | wend
                            call EnableNmi
                        else
                            inc hl | inc hl | inc hl | inc hl
                        endif
                        ld a,e | add a,VramWidth | ld e,a
                        ld a,d | adc a,0 | ld d,a
                        exx
                            inc c
                            dec e
                        exx
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
