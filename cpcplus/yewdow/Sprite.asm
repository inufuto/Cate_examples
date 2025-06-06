include "Vram.inc"
include "Chars.inc"
include "FixedCode.inc"

ext SpritePattern

Sprite_End equ 7
InvaldY equ 208
SpriteHeight equ 16
SpritePatternSize equ 8*SpriteHeight
Top equ 8

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

Sprite_xl equ 0
Sprite_xh equ 1
Sprite_y equ 2
Sprite_pattern equ 3
UnitSize equ 5

dseg
SpritePatternRam: public SpritePatternRam
    defs SpritePatternSize*Pattern_End


cseg
InitSprites: public InitSprites
    ld hl,SpritePattern
    ld de,SpritePatternRam
    ld c,Pattern_End
    do
        ld b,SpritePatternSize/2
        do
            ld a,(hl) | inc hl
            push af
                rrca | rrca | rrca | rrca | and 0fh
                ld (de),a | inc de
            pop af
            and 0fh
            ld (de),a | inc de
        dwnz
        dec c
    while nz | wend
; call HideAllSprites_

; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    push af | push hl | push de | push bc
        call HideAllSprites
    pop bc | pop de | pop hl | pop af
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de | push bc
        ld c,(ix+Movable_x) | ld b,0
        bit 7,e
        if nz
            or a
            if nz
                dec b
            endif
        endif
        sla c | rl b
        res 7,e

        ld h,e | ld l,0
        srl h | rr l
        ld de,SpritePatternRam
        add hl,de

                            _deb: public _deb
        ld a,(ix+Movable_y)
        add a,Top
        ld d,0
        cp -16
        if nc
            dec d
        endif
        ld e,a

        ld a,(ix+Movable_sprite)

        call ShowSprite
	pop bc | pop de | pop hl | pop af
ret


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
	push af | push bc
        call HideSprite
    pop bc | pop af
ret
