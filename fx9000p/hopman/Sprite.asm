include "Vram.inc"
include "VVram.inc"

ext VVramPtr_
ext LeftX_

SpriteCount equ 10
InvalidY equ 80h

Sprite_x equ 0
Sprite_y equ Sprite_x+1
Sprite_char equ Sprite_y+1
Sprite_unitSize equ Sprite_char+1

Movable_x equ 0
Movable_y equ Movable_x+1
Movable_sprite equ Movable_y+1

dseg
Sprites_: public Sprites_
    defs Sprite_unitSize*SpriteCount


cseg
ToPtr:
    ld l,a
    add a,a ;*2
    add a,l ;*3
    ld l,a
    ld h,0
    ld bc,Sprites_
    add hl,bc
ret


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    push af | push hl | push de | push bc
        ld hl,Sprites_
        ld b,Sprite_unitSize*SpriteCount
        do
            ld (hl),InvalidY | inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void ShowSprite(ptr<Movable> pMovable, byte code);
cseg
ShowSprite_: public ShowSprite_
    push af | push hl | push de | push bc
        ld a,(ix+2) ; index
        call ToPtr

        ld a,(ix+0) | inc bc ; x
        ld (hl),a | inc hl
        
        ld a,(ix+1) | inc bc ; y
        ld (hl),a | inc hl
        
        ld (hl),e ; code
    pop bc | pop de | pop hl | pop af
ret


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    push hl | push de
        call ToPtr
        inc hl | inc hl
        ld (hl),0
        inc hl
        ld (hl),0
    pop de | pop hl
ret


; void DrawSprites();
cseg
DrawSprites_: public DrawSprites_
    push af | push hl | push de | push bc
        ld hl,Sprites_
        ld b,SpriteCount
        do
            push bc
                ld d,(hl) | inc hl ; x
                ld e,(hl) | inc hl ; y
                ld c,(hl) | inc hl ; code

                ld a,e
                cp InvalidY
                if nz
                    push hl
                        ld a,d
                        ld hl,LeftX_
                        sub (hl)
                        jr c,DrawSprites_skip
                        cp VVramWidth-1
                        if c
                            ld d,a
                            ld a,e
                            cp VVramHeight
                            if c
                                ld e,a
                                ld a,d
                                call VVramPtr_

                                ld (hl),c | inc hl | inc c
                                ld (hl),c | inc hl | inc c
                                
                                ld a,e
                                cp VVramHeight-1
                                if c
                                    ld de,VVramWidth-2
                                    add hl,de

                                    ld (hl),c | inc hl | inc c
                                    ld (hl),c | inc hl | inc c
                                endif
                            endif
                        endif
                        DrawSprites_skip:
                    pop hl
                endif
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
ret
