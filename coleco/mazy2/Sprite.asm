include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext SpritePattern
ext DisableNmi, EnableNmi
ext SetVdpAddressHL
ext WRTVRM
ext LDIRVM
ext RDVRM
ext FILVRM
ext WRTVDP

Top equ 8*2-1

Sprite_End equ 15

UnitSize equ 4
Offset_y equ 0
Offset_x equ 1
Offset_pattern equ 2
Offset_color equ 3

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

    ld hl,Vram_SpriteAttribute
    ld bc,4*32
    ld a,0d0h
    call FILVRM    
ret

cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        push de
            ld l,(ix+2)  ; index
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Buffer
            add hl,de
        pop de
        di
            ld a,(ix+1) ; y
            add a,Top
            ld (hl),a
            inc hl 
            ld a,(ix+0) ; x
            ld (hl),a 
            inc hl
            sla e | sla e
            ld (hl),e ; pattern
            inc hl 
            ld (hl),c ; color
        ei
	pop	de | pop hl | pop af
ret


HideSprite_:
    public HideSprite_
	push	af
	push	hl
	push	de
        ld l,a  ; index
        ld h,0
        add hl,hl   ;*2
        add hl,hl   ;*4
        ld de,Buffer
        add hl,de
        ld (hl),192
    pop	de
	pop	hl
	pop	af
ret


HideAllSprites_:
    public HideAllSprites_
	push	hl
	push	bc
        ld hl,Buffer
        ld b,Sprite_End
        do
            ld (hl),192
            inc hl
            inc hl
            inc hl
            inc hl
        dwnz
    pop	bc
	pop	hl
ret


UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc
        call DisableNmi
            ld hl,VRAM_SpriteAttribute
            call SetVdpAddressHL
            ld a,(FirstIndex)
            ld hl,(FirstAddress)
            ld d,Sprite_End
            do
                ex af,af'
                    ld a,(hl) | inc hl
                    cp 192
                    if c
                        out (VdpPort),a
                        ld b,UnitSize-1
                        do
                            ld e,(hl) | inc hl
                            ld a,e | out (VdpPort),a
                        dwnz
                    else
                        inc hl | inc hl | inc hl
                    endif
                ex af,af'
                inc a
                cp Sprite_End
                if nc
                    xor a
                    ld hl,Buffer
                endif
                dec d
            while nz | wend
        call EnableNmi
        ex af,af'
            ld a,0d0h | out (VdpPort),a
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
