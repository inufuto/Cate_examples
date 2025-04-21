include "Vram.inc"
include "Chars.inc"
include "FixedCode.inc"

ext SpritePattern

Sprite_End equ 13
InvaldY equ 208
SpriteHeight equ 16
SpritePatternSize equ 8*SpriteHeight
; Top equ 8

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

Sprite_x equ 0
Sprite_y equ 1
Sprite_pattern equ 2
UnitSize equ 4

dseg
Sprites: public Sprites
    defs UnitSize*Sprite_End
SpritePatternRam: public SpritePatternRam
    defs SpritePatternSize*Pattern_End

FirstIndex:
    defs 1
FirstAddress:
    defs 2


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
        ld hl,Sprites+Sprite_y
        ld de,UnitSize
        ld b,Sprite_End
        do 
            ld (hl),InvaldY
            add hl,de
        dwnz
        xor a
        ld (FirstIndex),a
        ld hl,Sprites
        ld (FirstAddress),hl
    pop bc | pop de | pop hl | pop af
    call UpdateSprites_
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de | push bc
        push de
            ld l,(ix+Movable_sprite)
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Sprites
            add hl,de
        pop de
        di
            ld a,(ix+Movable_x)
            ld (hl),a | inc hl
            ld a,(ix+Movable_y)
            ; add a,Top
            ld (hl),a | inc hl
            ld d,e | ld e,0
            srl d | rr e
            ex de,hl
                ld bc,SpritePatternRam
                add hl,bc
            ex de,hl
            ld (hl),e | inc hl
            ld (hl),d
        ei
	pop bc | pop de | pop hl | pop af
ret


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
	push af | push hl | push de
        ld l,a  ; index
        ld h,0
        add hl,hl   ;*2
        add hl,hl   ;*4
        ld de,Sprites+Sprite_y
        add hl,de
        di
            ld (hl),InvaldY
        ei
    pop de | pop hl | pop af
ret


; void UpdateSprites();
cseg
UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc | push ix
        ld a,(FirstIndex) | ld c,a
        ld ix,(FirstAddress)
        ld hl,6000h
        ld de,4000h
        ld b,Sprite_End
        do
            ld a,(ix+Sprite_y)
            cp InvaldY
            if nz
                call CopySprite
                ld a,d
                cp 50h
                jr nc,exit
            endif
            inc ix | inc ix | inc ix | inc ix
            inc c
            ld a,c
            cp Sprite_End
            if nc
                ld c,0
                ld ix,Sprites
            endif
        dwnz
        call EraseSprite
        exit:
        ld hl,(FirstAddress)
        inc hl | inc hl | inc hl | inc hl
        ld a,(FirstIndex)
        inc a
        cp Sprite_End
        if nc
            xor a
            ld hl,Sprites
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop ix | pop bc | pop de | pop hl | pop af
ret
