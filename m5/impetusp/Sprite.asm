include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"
include "Sprite.inc"

ext WRTVDP
ext LDIRVM

ext SpritePattern

Top equ 8*0-1
HiddenY equ 192
SkySpriteRange equ 24
GroundSpriteRange equ 32-SkySpriteRange

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

Sprite_y equ 0
Sprite_x equ 1
Sprite_name equ 2
Sprite_color equ 3
UnitSize equ 4

dseg
Sprites: public Sprites
    defs UnitSize*Sprite_End
BufferEnd:
pFirst:
    defw 0

cseg
InitSprites: public InitSprites
    ld bc,0e201h
    call WRTVDP

    ld hl,SpritePattern
    ld de,Vram_SpriteGenerator
    ld bc,CharHeight*Pattern_End*4
    call LDIRVM

    call HideAllSprites_

    ld hl,Sprites | ld (pFirst),hl
ret

cseg
SpritePtrIX:
    push de
        ld l,(ix+Movable_sprite)  ; index
        ld h,0
        add hl,hl   ;*2
        add hl,hl   ;*4
        ld de,Sprites | add hl,de
    pop de
ret

; void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        call SpritePtrIX
        di
            ld a,(ix+Movable_y) ; y
            add a,Top
            ld (hl),a | inc hl 
            ld a,(ix+Movable_x) ; x
            ld (hl),a | inc hl 
            sla e | sla e
            ld (hl),e | inc hl ; pattern
            ld (hl),c ; color
        ei
	pop de | pop hl | pop af
ret


; void ShowSpriteXY(byte index, byte x, byte y, sbyte pattern, byte color);
dseg
ShowSpriteXY_@Param3: public ShowSpriteXY_@Param3
ShowSpriteXY_pattern:	
    defs 1
ShowSpriteXY_@Param4: public ShowSpriteXY_@Param4
ShowSpriteXY_color:
    defs 1
cseg
ShowSpriteXY_: public ShowSpriteXY_
	push af | push hl | push de
        ld b,e
        call SpritePtrA
        di
            ld a,c ; y
            add a,Top
            ld (hl),a | inc hl 
            ld a,b ; x
            ld (hl),a | inc hl 
            ld a,(ShowSpriteXY_pattern)
            add a,a | add a,a
            ld (hl),a | inc hl ; pattern
            ld a,(ShowSpriteXY_color)
            ld (hl),a ; color
        ei
	pop de | pop hl | pop af
ret


; void ShowSprite2(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSprite2_: public ShowSprite2_
	push af | push hl | push de
        call SpritePtrIX
        di
            ld a,(ix+Movable_y) ; y
            add a,Top
            ld b,a
            ld (hl),a | inc hl 
            ld d,(ix+Movable_x) ; x
            ld (hl),d | inc hl 
            sla e | sla e
            ld (hl),e | inc hl ; pattern
            ld a,c
            and 0fh
            ld (hl),a | inc hl ; color

            ld (hl),b | inc hl 
            ld (hl),d | inc hl 
            ld a,e
            add a,4
            ld (hl),a | inc hl ; pattern
            ld a,c
            rrca | rrca | rrca | rrca
            and 0fh
            ld (hl),a | inc hl ; color
        ei
	pop de | pop hl | pop af
ret


SpritePtrA:
    ld l,a  ; index
    ld h,0
    add hl,hl   ;*2
    add hl,hl   ;*4
    ld de,Sprites | add hl,de
ret

; void HideSprite(byte index);
HideSprite_: public HideSprite_
	push af | push hl | push de
        call SpritePtrA
        di
            ld (hl),HiddenY
        ei
    pop	de | pop hl | pop af
ret


; void HideSprite2(byte index);
HideSprite2_: public HideSprite2_
	push af | push hl | push de
        call SpritePtrA
        di
            ld (hl),HiddenY
            inc hl | inc hl | inc hl | inc hl
            ld (hl),HiddenY
        ei
    pop	de | pop hl | pop af
ret


; void HideAllSprites();
HideAllSprites_: public HideAllSprites_
	push af | push hl | push bc
        ld hl,Sprites
        ld b,Sprite_End
        di
            do
                ld (hl),HiddenY
                inc hl | inc hl | inc hl | inc hl
            dwnz
        ei
    pop bc | pop hl | pop af
    ; call UpdateSprites
ret

scope
UpdateSprites: public UpdateSprites
    ; push af | push hl | push de | push bc
        ld c,VdpPort
        ld hl,4000h or VRAM_SpriteAttribute
        ; di
            inc c
            out (c),l
            out (c),h
            dec c
            
            ld hl,(pFirst)
            ld de,Sprite_End or (32 shl 8)
            do
                ld a,(hl) ; y
                cp HiddenY
                if nz
                    inc hl
                    out (c),a
                    ld b,UnitSize-1
                    do
                        ld a,(hl) | inc hl
                        out (c),a
                    dwnz
                    dec d
                    jr z,skip
                else
                    inc hl | inc hl | inc hl | inc hl
                endif
                ld a,l
                cp low BufferEnd
                if z
                    ld hl,Sprites
                endif
                dec e
            while nz | wend
            ld a,0d0h
            out (c),a
            skip:
        ; ei

        ld hl,(pFirst)
        ld c,l
        ld de,UnitSize*2 | add hl,de
        do
            ld a,l
            cp low BufferEnd
            if z
                ld hl,Sprites
            endif
            ld a,l
            cp c
        while nz
            ld a,(hl)
            cp HiddenY
            jr nz,exit
            inc hl | inc hl | inc hl | inc hl
            ld a,(hl)
            cp HiddenY
            if nz
                dec hl | dec hl | dec hl | dec hl
                jr exit
            endif
            inc hl | inc hl | inc hl | inc hl
        wend
        exit:
        ld (pFirst),hl
    ; pop bc | pop de | pop hl | pop af
ret
endscope