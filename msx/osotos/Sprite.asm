include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext SpritePattern

Top equ 8*0-1

Sprite_End equ 13

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

Sprite_y equ 0
Sprite_x equ 1
Sprite_name equ 2
Sprite_color equ 3
UnitSize equ 4

dseg
Sprites_:   public Sprites_
Buffer:
    defs UnitSize * Sprite_End
FirstIndex:
    defs 1
FirstAddress:
    defs 2

cseg
InitSprites: public InitSprites
	push	af
	push	hl
	push	de
	push	bc
        ld bc,0e201h
        call WRTVDP

        ld hl,SpritePattern
        ld de,Vram_SpriteGenerator
        ld bc,CharHeight*Pattern_End*4
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
    pop	bc
	pop	de
	pop	hl
	pop	af
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


UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort)
        ld c,a
        ld hl,VRAM_SpriteAttribute or 4000h
        di
            inc c
            out (c),l
            out (c),h
            dec c
            
            ld a,(FirstIndex)
            ld hl,(FirstAddress)
            ld d,Sprite_End
            do
                ld b,UnitSize
                do
                    ld e,(hl)
                    inc hl
                    out (c),e
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
