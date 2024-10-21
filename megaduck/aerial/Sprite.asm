include "MegaDuck.inc"
include "Vram.inc"

ext HScroll_

Sprite_y equ 0
Sprite_x equ 1
Sprite_pattern equ 2
UnitSize equ 3

SpriteCount equ 25
InvaldY equ 192
Top equ 16+CharHeight*2
Left equ 8

dseg
Sprites: public Sprites
    defs UnitSize*SpriteCount
FirstIndex:
    defs 1
FirstAddress:
    defs 2

cseg
InitSprites: public InitSprites
    ld hl,Sprites
    ld de,UnitSize
    ld b,SpriteCount
    do 
        ld (hl),InvaldY
        add hl,de
        dec b
    while nz|wend

    ld hl,ObjSource
    ld b,0a0h
    do
        ld (hl),InvaldY
        inc hl | inc hl | inc hl
        dec b
    while nz|wend
    
    xor a,a
    ld (FirstIndex),a
    ld a,low Sprites | ld (FirstAddress),a
    ld a,high Sprites | ld (FirstAddress+1),a
ret


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
	push hl | push	bc
        di
            ld hl,Sprites
            ld b,SpriteCount
            do
                ld (hl),InvaldY
                inc hl | inc hl | inc hl
                dec b
            while nz|wend
        ei
    pop	bc | pop hl
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public ShowSprite_
    push af | push hl | push de | push bc
        ld c,e
        inc hl | inc hl
        ld a,(hl) ; index
        ld e,a
        add a,a ;*2
        add a,e ;*3
        add a,low Sprites | ld e,a
        ld a,high Sprites | adc a,0 | ld d,a
        dec hl
        ld a,(hl) ; y
        add a,Top
        di
            ld (de),a | inc de
            dec hl
            ld a,(hl) ; x
            add a,Left
            ld (de),a | inc de
            ld a,c ; pattern
            add a,a | add a,a
            ld (de),a
        ei
	pop bc | pop de | pop hl | pop af
ret


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
	push af | push hl | push de
        ld l,a  ; index
        add a,a ;*2
        add a,l ;*3
        ld l,a | ld h,0
        ld de,Sprites | add hl,de
        di
            ld (hl),InvaldY
        ei
    pop	de | pop hl | pop af
ret


; void UpdateSprites();
cseg
UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc
        ld de,ObjSource
        ld a,(FirstAddress) | ld l,a
        ld a,(FirstAddress+1) | ld h,a
        ld a,(FirstIndex)
        ld b,SpriteCount
        do
            push bc
                push af
                    ld a,(hl+) ; y
                    ; sub (VScroll_)
                    cp a,InvaldY
                    if c
                        ld c,a
                        ld (de),a | inc de
                        ; ld a,(HScroll_) | ld b,a
                        ld a,(hl+) ; x
                        ; sub a,b ; HScroll
                        ld b,a
                        ld (de),a | inc de
                        ld a,(hl+) ; pattern
                        ld (de),a | inc de
                        push hl
                            ld l,a
                                xor a,a
                                ld (de),a | inc de
                                ld a,c ; y
                                ld (de),a | inc de
                                ld a,b ; x
                                add a,8
                                ld (de),a | inc de
                            ld a,l
                            add a,2
                            ld (de),a | inc de
                            xor a,a
                            ld (de),a | inc de
                        pop hl
                    else
                        inc hl
                        inc hl  
                    endif
                pop af
                inc a
                cp a,SpriteCount
                if nc
                    xor a,a
                    ld hl,Sprites
                endif
            pop bc
            dec b
        while nz|wend
        cp a,SpriteCount
        if nc
            xor a,a
            ld hl,Sprites
        endif
        inc a
        ld (FirstIndex),a
        ld a,l | ld (FirstAddress),a
        ld a,h | ld (FirstAddress+1),a

        do
            ld a,e
            cp a,0a0h
        while nz
            ld a,InvaldY
            ld (de),a | inc de
            inc de | inc de | inc de
        wend
    pop bc | pop de | pop hl | pop af
ret
