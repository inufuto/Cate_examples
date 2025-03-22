include "vgszero.inc"
include "Vram.inc"

dseg
HScroll_: public HScroll_
    defb 0

cseg
PaletteValues:
	defb	00h, 00h, 0fbh, 2ch, 00h, 7ch, 0ffh, 7dh
	defb	0e0h, 03h, 7fh, 1fh, 0e0h, 7fh, 0ffh, 7fh
	defb	00h, 00h, 0efh, 6eh, 07h, 6ch, 00h, 4ch
	defb	77h, 5fh, 0efh, 01h, 6bh, 7eh, 73h, 4eh
InitVram: public InitVram
    ld hl,PaletteValues
    ld de,PaletteTable
    ld bc,16*2
    ldir

    ld a,TilePatternBank
    ld (BgDirectPatternMapping),a
    ld (FgDirectPatternMapping),a
    ld a,SpritePatternBank
    ld (SpriteDirectPatternMapping),a
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearA:
    do
        ld (hl),80h | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,BgNameTable
        ld bc,32*32
        call Clear

        ld hl,FgNameTable
        ld bc,32*32
        call Clear

        ld hl,BgAttribute
        ld bc,32*32
        call ClearA

        ld hl,FgAttribute
        ld bc,32*32
        call ClearA

        xor a
        ld (HScroll_),a
        ld (BgScrollY),a
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    inc hl
ret


; ; word VramOffset(byte x, byte y);
; VramOffset_: public VramOffset_
;     push de
;         ld l,e
;         ld h,0
;         add hl,hl ;*2
;         add hl,hl ;*4
;         add hl,hl ;*8
;         add hl,hl ;*16
;         add hl,hl ;*32
;         ld e,a
;         ld d,0
;         add hl,de
;     pop de
; ret


ext Ground_, Tiles_
ext dotOffset_, GroundY_

TileSize equ 4
GroundHeight equ 7

; void DrawGround();
cseg
DrawGround_: public DrawGround_
    push af | push hl | push de | push bc
        ld hl,VramBack
        ld de,Ground_
        
        ld c,GroundHeight
        do
            ld b,VramWidth/TileSize
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        exx
                            ld l,a
                            ld h,0
                            add hl,hl ;*2
                            add hl,hl ;*4
                            add hl,hl ;*8
                            add hl,hl ;*16
                            ld de,Tiles_ | add hl,de
                        exx
                        ld c,TileSize
                        do
                            ld b,TileSize
                            do
                                exx
                                    ld a,(hl) | inc hl
                                exx
                                ld (hl),a | inc hl
                            dwnz
                            ld de,VramRowSize-TileSize*VramStep | add hl,de
                            dec c
                        while nz | wend
                        ld de,TileSize*VramStep-VramRowSize*TileSize | add hl,de
                    pop de
                pop bc
            dwnz
            push de
                ld de,VramRowSize*TileSize-VramWidth*VramStep | add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void UpdateOffset();
cseg
UpdateOffset_: public UpdateOffset_
    push af | push de
        ld a,(dotOffset_)
        ld e,a
        ld a,(GroundY_)
        and TileSize-1
        neg
        add a,TileSize
        add a,a | add a,a | add a,a
        sub e
        ; sub 8
        ld (BgScrollY),a
    pop de | pop af
ret
