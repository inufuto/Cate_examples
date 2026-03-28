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

SpriteCount equ 6

UnitSize equ 4
Offset_y equ 0
Offset_x equ 1
Offset_pattern equ 2
Offset_color equ 3

dseg
Sprites: public Sprites
    defs UnitSize * SpriteCount
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
        ld hl,SpritePattern
        ld de,Vram_SpriteGenerator
        ld bc,CharHeight*4*Pattern_End
        call LDIRVM

        ld hl,Sprites
        ld de,UnitSize
        ld b,SpriteCount
        do 
            ld (hl),192
            add hl,de
        dwnz
        xor a
        ld (FirstIndex),a
        ld hl,Sprites
        ld (FirstAddress),hl

        ld hl,Vram_SpriteAttribute
        ld bc,4*32
        ld a,0d0h
        call FILVRM    
    pop	bc
	pop	de
	pop	hl
	pop	af
ret


dseg
ShowSprite_@Param3:	public	ShowSprite_@Param3
ShowSprite_pattern:
    defb 0
ShowSprite_@Param4:	public	ShowSprite_@Param4
ShowSprite_color:
    defb 0
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        add a,a | add a,a
        add a,low Sprites | ld l,a
        ld a,high Sprites | adc a,0 | ld h,a
        di
            ld a,c ; y
            add a,Top
            ld (hl),a
            inc hl 
            ld a,e ; x
            ld (hl),a 
            inc hl
            ld a,(ShowSprite_pattern)
            add a,a | add a,a
            ld (hl),a ; pattern
            inc hl 
            ld a,(ShowSprite_color)
            ld (hl),a ; color
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
        ld de,Sprites
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
        ld hl,Sprites
        ld b,SpriteCount
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
        di
            ld hl,VRAM_SpriteAttribute
            call SetVdpAddressHL
            ld a,(FirstIndex)
            ld hl,(FirstAddress)
            ld d,SpriteCount
            do
                ex af,af'
                    ld a,(hl) | inc hl
                    cp 192
                    if c
                        ld (VdpAddress),a
                        ld b,UnitSize-1
                        do
                            ld e,(hl) | inc hl
                            ld a,e | ld (VdpAddress),a
                        dwnz
                    else
                        inc hl | inc hl | inc hl
                    endif
                ex af,af'
                inc a
                cp SpriteCount
                if nc
                    xor a
                    ld hl,Sprites
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
        cp SpriteCount
        if nc
            xor a
            ld hl,Sprites
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop bc | pop de | pop hl | pop af
ret
