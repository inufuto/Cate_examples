include "vgszero.inc"
include "Vram.inc"
include "Chars.inc"

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

OAM_y equ 0
OAM_x equ 1
OAM_pattern equ 2
OAM_attribute equ 3
OAM_heightMinus1 equ 4
OAM_widthMinus1 equ 5
OAM_bank equ 6
OAM_attribute2 equ 7

; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    push af | push hl | push bc
        ld hl,OAM
        ld bc,8*256
        do
            ld (hl),0 | inc hl
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop hl | pop af
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
OAMPtr:
    ld l,a | ld h,0
    add hl,hl ;*2
    add hl,hl ;*4
    add hl,hl ;*8
    ld bc,OAM | add hl,bc
ret
ShowSprite_: public ShowSprite_
    push af | push hl | push bc
        ld a,(ix+Movable_sprite)
        call OAMPtr

        ld a,(ix+Movable_y)
        add a,CharHeight*3
        ld (hl),a | inc hl
        
        ld a,(ix+Movable_x)
        add a,CharWidth
        ld (hl),a | inc hl

        ld a,e        
        add a,a ;*2
        ld b,a
        and 0fh
        ld c,a
        ld a,b
        and 0f0h
        add a,a ;*2
        add a,c
        add a,Char_End
        ld (hl),a | inc hl

        ld (hl),80h | inc hl ; OAM_attribute
        ld (hl),1 | inc hl ; OAM_heightMinus1
        ld (hl),1 | inc hl ; OAM_widthMinus1
    pop bc | pop hl | pop af
ret


; void ShowSpriteXY(byte index, byte x, byte y, byte pattern);
dseg
ShowSpriteXY_@Param3: public ShowSpriteXY_@Param3
ShowSpriteXY_pattern:
    defb 0
cseg
ShowSpriteXY_: public ShowSpriteXY_
    push af | push hl | push bc
        push bc
            call OAMPtr
        pop bc
        
        ld a,c
        add a,CharHeight*3
        ld (hl),a | inc hl
        
        ld a,e
        add a,CharWidth
        ld (hl),a | inc hl

        ld a,(ShowSpriteXY_pattern)
        add a,a ;*2
        ld b,a
        and 0fh
        ld c,a
        ld a,b
        and 0f0h
        add a,a ;*2
        add a,c
        add a,Char_End
        ld (hl),a | inc hl

        ld (hl),80h | inc hl ; OAM_attribute
        ld (hl),1 | inc hl ; OAM_heightMinus1
        ld (hl),1 | inc hl ; OAM_widthMinus1
    pop bc | pop hl | pop af
ret


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    push af | push hl | push bc
        call OAMPtr
        inc hl | inc hl | inc hl
        ld (hl),00h | inc hl ; OAM_attribute
    pop bc | pop hl | pop af
ret
