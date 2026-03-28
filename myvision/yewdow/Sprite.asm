include "kh1000.inc"
include "Vram.inc"
include "Chars.inc"

ext SpritePattern
ext SetVdpAddressHL
ext WRTVRM
ext LDIRVM
ext RDVRM
ext FILVRM
ext WRTVDP

Top equ 8*2-1

Sprite_End equ 7

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

Sprite_y equ 0
Sprite_x equ 1
Sprite_name equ 2
Sprite_color equ 3
UnitSize equ 4

dseg
Buffer: 
    defs UnitSize*Sprite_End
FirstIndex:
    defs 1
FirstAddress:
    defs 2

cseg
InitSprites: public InitSprites
    ld hl,SpritePattern
    ld de,Vram_SpriteGenerator
    ld bc,CharHeight*4*Pattern_End
    call LDIRVM

    ld hl,Buffer
    ld de,UnitSize
    ld b,Sprite_End
    do 
        ld (hl),192
        add hl,de
    dwnz
    xor a
    ld (FirstIndex),a
    ld hl,Buffer
    ld (FirstAddress),hl
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de | push bc
        push de
            ld l,(ix+Movable_sprite)  ; index
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Buffer
            add hl,de
        pop de
        di
            ld a,(ix+Movable_y) ; y
            add a,Top
            ld (hl),a
            inc hl 
            ld a,(ix+Movable_x) ; x
            bit 7,c
            if nz
                add a,32
            endif
            ld (hl),a
            inc hl 
            sla e | sla e
            ld (hl),e ; pattern
            inc hl 
            ld (hl),c ; color | EC
        ei
	pop bc | pop de | pop hl | pop af
ret


HideSprite_: public HideSprite_
	push af | push hl | push de
            ld l,a  ; index
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Buffer
            add hl,de
            di
                ld (hl),192
            ei
    pop	de | pop hl | pop af
ret


HideAllSprites_: public HideAllSprites_
	push	hl
	push	bc
        ld hl,Buffer
        ld b,Sprite_End
        di
            do
                ld (hl),192
                inc hl
                inc hl
                inc hl
                inc hl
            dwnz
        ei
    pop	bc
	pop	hl
    call UpdateSprites_
ret


; void UpdateSprites();
UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc
        di
            ld hl,VRAM_SpriteAttribute
            call SetVdpAddressHL

            ld a,(FirstIndex)
            ld hl,(FirstAddress)
            ld d,Sprite_End
            do
                ld b,UnitSize
                do
                    ld e,(hl)
                    inc hl
                    ex af,af'
                        ld a,e | ld (VdpAddress),a
                    ex af,af'
                dwnz
                inc a
                cp Sprite_End
                if nc
                    xor a
                    ld hl,Buffer
                endif
                dec d
            while nz | wend
        ei
        ex af,af'
            ld a,0d0h | ld (VdpAddress),a
        ex af,af'
        inc hl
        inc hl
        inc hl
        inc hl
        inc a
        cp Sprite_End
        if nc
            xor a
            ld hl,Buffer
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop bc | pop de | pop hl | pop af
ret
