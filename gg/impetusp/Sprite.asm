include "Vdp.inc"
include "Vram.inc"


ext LDIRVM, WRTVRM
ext SpritePattern

Sprite_End equ 29
Top equ 8*3-1
Left equ 8*6
SpritesUnitSize equ 3
HiddenY equ 192

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

dseg
Sprites:   public Sprites
Sprites:
    defs SpritesUnitSize * Sprite_End
BufferEnd:
pFirst: public pFirst
    defw 0

cseg
InitSprites: public InitSprites
    ld hl,Sprites
    ld de,SpritesUnitSize
    ld b,Sprite_End
    do 
        ld (hl),HiddenY
        add hl,de
    dwnz
    ld hl,Sprites | ld (pFirst),hl
ret

; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        push de
            ld l,(ix+Movable_sprite)  ; index
            ld h,0
            ld e,l | ld d,h
            add hl,hl   ;*2
            add hl,de   ;*3
            ld de,Sprites | add hl,de
        pop de
        di
            ld a,(ix+Movable_y) ; y
            add a,Top
            ld (hl),a | inc hl 
            ld a,(ix+Movable_x) ; x
            add a,Left
            ld (hl),a | inc hl
            ld a,e ; pattern
            add a,a
            add a,a
            ld (hl),a
        ei
	pop	de | pop hl | pop af
ret


; void ShowSpriteXY(byte index, byte x, byte y, sbyte pattern);
dseg
ShowSpriteXY_@Param3: public ShowSpriteXY_@Param3
ShowSpriteXY_pattern:	
    defs 1
cseg
ShowSpriteXY_: public ShowSpriteXY_
	push af | push hl | push de
        ld b,e
        ld l,a ; index
        ld h,0
        ld h,0
        ld e,l | ld d,h
        add hl,hl   ;*2
        add hl,de   ;*3
        ld de,Sprites | add hl,de
        di
            ld a,c ; y
            add a,Top
            ld (hl),a | inc hl 
            ld a,b ; x
            add a,Left
            ld (hl),a | inc hl 
            ld a,(ShowSpriteXY_pattern)
            add a,a
            add a,a
            ld (hl),a
        ei
	pop de | pop hl | pop af
ret


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
	push af | push hl | push de
        ld l,a  ; index
        ld h,0
        ld e,l
        ld d,h
        add hl,hl   ;*2
        add hl,de   ;*3
        ld de,Sprites
        add hl,de
        di
            ld (hl),HiddenY
        ei
    pop	de | pop hl | pop af
ret


; void HideAllSprites();
HideAllSprites_: public HideAllSprites_
	push hl | push bc
        ld hl,Sprites
        ld b,Sprite_End
        di
            do
                ld (hl),HiddenY
                inc hl
                inc hl
                inc hl
            dwnz
        ei
    pop bc | pop hl
ret


UpdateSprites: public UpdateSprites
    ; push af | push hl | push de | push bc
        ld de,VRAM_SpriteAttribute
        exx
            ld de,VRAM_SpriteAttribute+128
        exx

        ld hl,(pFirst)
        ld bc, 32 or (Sprite_End shl 8)
        do
            ld a,(hl) ; y
            cp HiddenY
            if nz
                push bc
                    ld b,a
                        ld a,e | out (VdpPort+1),a
                        ld a,d | or 40h | out (VdpPort+1),a
                        inc de | inc de
                    ld a,b
                    out (VdpPort),a ; y
                    nop | nop | nop
                    out (VdpPort),a ; y
                    inc hl
                    exx
                        ld a,e | out (VdpPort+1),a
                        ld a,d | or 40h | out (VdpPort+1),a
                        inc de | inc de | inc de | inc de
                    exx
                    ld c,(hl) | inc hl ; x
                    ld b,(hl) | inc hl ; pattern
                    ld a,c
                    out (VdpPort),a ; x
                    nop | nop | nop
                    ld a,b
                    out (VdpPort),a ; pattern
                    ld a,c
                    add a,8
                    out (VdpPort),a ; x
                    nop | nop | nop
                    ld a,b
                    add a,2
                    out (VdpPort),a ; pattern
                pop bc
                dec c
                jr z,skip
            else
                inc hl | inc hl | inc hl  
            endif
            ld a,l
            cp low BufferEnd
            if z
                ld hl,Sprites
            endif
        dwnz
        ld a,e | out (VdpPort+1),a
        ld a,d | or 40h | out (VdpPort+1),a
        ld a,0d0h | out (VdpPort),a

        skip:
        ld hl,(pFirst)
        ld c,l
        inc hl | inc hl | inc hl
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
            inc hl | inc hl | inc hl
        wend
        exit:
        ld (pFirst),hl
    ; pop bc | pop de | pop hl | pop af
ret
